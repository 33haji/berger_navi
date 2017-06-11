class HomeController < ApplicationController
  require 'dropbox_sdk'

  def index
    # 対象の店舗を取得する
    if params[:area].present?
      @shops = Shop.where(delete_flag: false, area: params[:area]).where.not(latitude: nil, longitude:nil).order(rate: :desc).take(5)
    elsif params[:genre_tag].present?
      @shops = Shop.includes(:genre_tags).where("delete_flag = ? AND genre_tags.tag_name = ?", false, params[:genre_tag]).where.not(latitude: nil, longitude:nil).order(rate: :desc).references(:genre_tags).take(5)
    else
      @shops = Shop.where(delete_flag: false).where.not(latitude: nil, longitude:nil).order(rate: :desc).take(5)
    end
    # ショップのジャンル名を取得
    @genre_tag_names_list = get_genre_tag_names(@shops)
    # 順位を決定する
    @ranking = get_ranking(@shops)
    # 画像パスを取得(本番環境ではDropboxから取得)
    client = new_dropbox_client if Rails.env.production?
    @image_paths = {}
    @shops.each do |shop|
      image_path = (Rails.env.production?) ? client.media(shop.image1_filename)['url'] : shop.image1.url if shop.image1.url.present?
      @image_paths[shop.id] = image_path
    end

    # サイドバーの情報を取得
    @all_shop_count = Shop.where(delete_flag: false).where.not(latitude: nil, longitude:nil).count
    @area_search_info = get_area_search_info
    @genre_tag_search_info = get_genre_tag_search_info

    # Googleマップの設定
    @map = Gmaps4rails.build_markers(@shops) do |shop, marker|
      marker.lat shop.latitude
      marker.lng shop.longitude
      marker.infowindow render_to_string(partial: "home/infowindow", locals: { shop: shop })
      marker.json({title: shop.name})
    end
  end

  private
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

    # ショップの評価のランキングを作成する
    def get_ranking(shops)
      ranking = []
      count = 1
      rank = 1
      pre_rate = 0
      shops.each do |shop|
        if ranking.empty? || pre_rate == shop[:rate]
          ranking << rank
          pre_rate = shop[:rate]
        elsif pre_rate != shop[:rate] && count <= 3
          rank = rank + 1
          ranking << rank
          pre_rate = shop[:rate]
        else
          ranking << 0
        end
        count = count + 1
      end
      ranking
    end

    # shopsのジャンル名を取得するメソッド
    def get_genre_tag_names(shops)
      genre_tag_names_list = []
      shops.each do |shop|
        genre_tag_ids = ShopsGenreTag.where(shop_id: shop.id).map {|item| item.genre_tag_id}
        genre_tag_names = GenreTag.where(id: genre_tag_ids).map {|item| item.tag_name}
        genre_tag_names_list << genre_tag_names
      end
      genre_tag_names_list
    end
end
