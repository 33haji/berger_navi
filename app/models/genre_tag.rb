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
  validates :tag_name, presence: true
end
