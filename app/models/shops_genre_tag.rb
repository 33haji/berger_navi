# == Schema Information
#
# Table name: shops_genre_tags
#
#  id           :integer          not null, primary key
#  shop_id      :integer          default("0"), not null
#  genre_tag_id :integer          default("0"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ShopsGenreTag < ApplicationRecord
end
