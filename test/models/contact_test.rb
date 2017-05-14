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

require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
