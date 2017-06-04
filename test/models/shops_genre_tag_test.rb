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

require 'test_helper'

class ShopsGenreTagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
