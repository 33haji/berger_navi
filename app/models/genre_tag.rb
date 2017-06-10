# == Schema Information
#
# Table name: genre_tags
#
#  id         :integer          not null, primary key
#  tag_name   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GenreTag < ApplicationRecord
  has_many :shops_genre_tags
  has_many :shops, :through => :shops_genre_tags

  validates :tag_name, presence: true
end
