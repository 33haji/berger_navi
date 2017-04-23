# == Schema Information
#
# Table name: tips
#
#  id          :integer          not null, primary key
#  genre_id    :integer          default("0"), not null
#  title       :text(65535)
#  detail      :text(65535)
#  delete_flag :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class TipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
