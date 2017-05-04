class HomeController < ApplicationController
  def index
    @shops = Shop.where(delete_flag: false).where.not(latitude: nil, longitude:nil)
    @map = Gmaps4rails.build_markers(@shops) do |shop, marker|
      marker.lat shop.latitude
      marker.lng shop.longitude
      marker.infowindow render_to_string(partial: "home/infowindow", locals: { shop: shop })
      marker.json({title: shop.name})
    end
    @shops_in_area = count_shop_in_area
  end

  private
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
end
