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
#  comment     :text(65535)
#  image1      :string(255)
#  image2      :string(255)
#  image3      :string(255)
#  delete_flag :boolean          default("0")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Shop < ApplicationRecord
  mount_uploader :image, ImageUploader
end
