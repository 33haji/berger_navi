class HomeController < ApplicationController
  require 'dropbox_sdk'

  def index
    # 対象の店舗を取得する
    if params[:area].blank?
      @shops = Shop.where(delete_flag: false).where.not(latitude: nil, longitude:nil).order(rate: :desc).take(5)
    else
      @shops = Shop.where(delete_flag: false, area: params[:area]).where.not(latitude: nil, longitude:nil).order(rate: :desc).take(5)
    end
    @all_shop_count = Shop.where(delete_flag: false).where.not(latitude: nil, longitude:nil).count
    @shops_in_area = count_shop_in_area
    # 順位を決定する
    @ranking = get_ranking(@shops)

    # Googleマップの設定
    @map = Gmaps4rails.build_markers(@shops) do |shop, marker|
      marker.lat shop.latitude
      marker.lng shop.longitude
      marker.infowindow render_to_string(partial: "home/infowindow", locals: { shop: shop })
      marker.json({title: shop.name})
    end

    # 画像パスを取得(本番環境ではDropboxから取得)
    client = new_dropbox_client if Rails.env.production?
    @image_paths = {}
    @shops.each do |shop|
      image_path = (Rails.env.production?) ? client.media(shop.image1_filename)['url'] : shop.image1.url if shop.image1.url.present?
      @image_paths[shop.id] = image_path
    end
  end

  private
    # 対象地域のショップ数を算出する
    def count_shop_in_area
      shops_in_area = {}
      areas = Shop.select(:area).uniq
      areas.each do |area|
        shop_count = Shop.where(delete_flag: false, area: area.area).count
        shops_in_area[area.area] = shop_count
      end
      shops_in_area.sort {|(k1, v1), (k2, v2)| v2 <=> v1 }
      shops_in_area
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
end
