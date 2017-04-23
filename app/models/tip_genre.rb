# == Schema Information
#
# Table name: tip_genres
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  image      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TipGenre < ApplicationRecord
  mount_uploader :image, ImageUploader

  has_many :tips
end
