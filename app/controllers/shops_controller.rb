class ShopsController < ApplicationController
  require 'dropbox_sdk'
  before_action :set_shop, only: %w(edit update delete)

  def index
    @q = Shop.ransack(params[:q])
    shops = @q.result.where(delete_flag: false)
    @shops = shops.page(params[:page]).order(created_at: :desc)
    @shops_genre_tags = ShopsGenreTag.where(shop_id: @shops.ids)
    @genre_tags = GenreTag.where(id: @shops_genre_tags.map{|item| item.genre_tag_id})
  end

  def new
    @shop = Shop.new
    @rate_values = [0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0]
    @areas = Shop.select(:area).uniq
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.valid?
      @shop.area = @shop.new_area if @shop.new_area.present?
      @shop.save
      redirect_to shops_path
    else
      @rate_values = [0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0]
      @areas = Shop.select(:area).uniq
      render 'new'
    end
  end

  def show
    @shop = Shop.find(params[:id])
    genre_tag_ids = ShopsGenreTag.where(shop_id: @shop.id).map {|item| item.genre_tag_id}
    @genre_tag_names = GenreTag.where(id: genre_tag_ids).map {|item| item.tag_name}
    # 画像パスを取得(本番環境ではDropboxから取得)
    client = new_dropbox_client if Rails.env.production?
    @image1_path = (Rails.env.production?) ? client.media(@shop.image1_filename)['url'] : @shop.image1.url if @shop.image1.url.present?
    @image2_path = (Rails.env.production?) ? client.media(@shop.image2_filename)['url'] : @shop.image2.url if @shop.image2.url.present?
    @image3_path = (Rails.env.production?) ? client.media(@shop.image3_filename)['url'] : @shop.image3.url if @shop.image3.url.present?

    # サイドバーの情報を取得
    @all_shop_count = Shop.where(delete_flag: false).where.not(latitude: nil, longitude:nil).count
    @area_search_info = get_area_search_info
    @genre_tag_search_info = get_genre_tag_search_info

    @map = Gmaps4rails.build_markers(@shop) do |s, marker|
      marker.lat s.latitude
      marker.lng s.longitude
      marker.infowindow render_to_string(partial: "shops/infowindow", locals: { shop: s })
      marker.json({title: s.name})
    end
  end

  def edit
    @rate_values = [0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0]
    @areas = Shop.select(:area).uniq
  end

  def update
    if @shop.update(shop_params)
      @shop.area = @shop.new_area if @shop.new_area.present?
      @shop.save
      redirect_to shops_path
    else
      @rate_values = [0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0]
      @areas = Shop.select(:area).uniq
      render 'edit'
    end
  end

  def delete
    if @shop.update_attribute(:delete_flag, true)
      redirect_to shops_path
    else
      redirect_to shops_path, alert: '削除に失敗しました'
    end
  end

  private

    def shop_params
      params.require(:shop).permit(:name, :rate, :area, :new_area, :address, :url, :comment, :detail, :image1, :image2, :image3, :remove_image1, :remove_image2, :remove_image3 ,{ :genre_tag_ids=> [] })
    end

    def set_shop
      @shop = Shop.find(params[:id])
    end

    # 地域検索の情報(地域名、店舗数)を取得するメソッド
    def get_area_search_info
      area_search_info = {}
      areas = Shop.select(:area).uniq
      areas.each do |area|
        shop_count = Shop.where(delete_flag: false, area: area.area).count
        area_search_info[area.area] = shop_count
      end
      area_search_info.sort {|(k1, v1), (k2, v2)| v2 <=> v1 }
      area_search_info
    end

    # ジャンル検索の情報(ジャンル名、店舗数)を取得するメソッド
    def get_genre_tag_search_info
      genre_tag_search_info = {}
      genre_tags = GenreTag.all
      genre_tags.each do |genre_tag|
        shop_count = ShopsGenreTag.where(genre_tag_id: genre_tag.id).count
        genre_tag_search_info[genre_tag.tag_name] = shop_count
      end
      genre_tag_search_info
    end
end
