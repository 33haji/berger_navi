# == Schema Information
#
# Table name: shops
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  rate        :float(24)
#  area        :string(255)
#  address     :string(255)
#  latitude    :float(24)
#  longitude   :float(24)
#  url         :string(255)
#  comment     :string(255)
#  detail      :text(65535)
#  image1      :string(255)
#  image2      :string(255)
#  image3      :string(255)
#  delete_flag :boolean          default("0")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Shop < ApplicationRecord
  mount_uploader :image1, ImageUploader
  mount_uploader :image2, ImageUploader
  mount_uploader :image3, ImageUploader
  geocoded_by :address
  after_validation :geocode

  attr_accessor :new_area, :remove_image1, :remove_image2, :remove_image3

  validates :name, presence: true
  validates :rate, presence: true, numericality: true
  validates :area, presence: true, if: :new_area_blank?

  before_update do
    self.image1 = "" if remove_image1.to_i.nonzero?
    self.image2 = "" if remove_image2.to_i.nonzero?
    self.image3 = "" if remove_image3.to_i.nonzero?
  end

  def new_area_blank?
    new_area.blank?
  end
end
