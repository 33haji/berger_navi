class HomeController < ApplicationController
  def index
    @shops = Shop.where(delete_flag: false).where.not(latitude: nil, longitude:nil)
    @map = Gmaps4rails.build_markers(@shops) do |shop, marker|
      marker.lat shop.latitude
      marker.lng shop.longitude
      marker.infowindow render_to_string(partial: "home/infowindow", locals: { shop: shop })
      marker.json({title: shop.name})
    end
  end
end
