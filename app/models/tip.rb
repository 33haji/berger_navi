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

class Tip < ApplicationRecord
  belongs_to :tip_genre, foreign_key: "genre_id"
end
