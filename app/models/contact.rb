# == Schema Information
#
# Table name: contacts
#
#  id            :integer          not null, primary key
#  contact_email :string(255)
#  content       :text(65535)
#  read_flag     :boolean          default("0")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Contact < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :contact_email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX, message: "が正しくありません" }
  validates :content, presence: true
end
