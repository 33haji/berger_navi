class ShopsController < ApplicationController
  before_action :set_shop, only: %w(edit update delete)

  def index
    @q = Shop.ransack(params[:q])
    shops = @q.result.where(delete_flag: false)
    @shops = shops.page(params[:page]).order(created_at: :desc)
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
      params.require(:shop).permit(:name, :rate, :area, :new_area, :address, :url, :comment, :detail, :image1, :image2, :image3, :remove_image1, :remove_image2, :remove_image3)
    end

    def set_shop
      @shop = Shop.find(params[:id])
    end
end
