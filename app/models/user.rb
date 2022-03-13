# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  picture_url :string
#  premium     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :string           not null
#
# Indexes
#
#  index_users_on_user_id  (user_id) UNIQUE
#
class User < ApplicationRecord
  validates :user_id, uniqueness: true
  class << self
    def find_or_create_user(user_id)
      response = Utils.client.get_profile(user_id)
      case response
      when Net::HTTPSuccess
        contact = JSON.parse(response.body)
        user = User.find_or_initialize_by(user_id: user_id)
        user.update!(name: contact['displayName'], picture_url: contact['pictureUrl'])
        user
      else
        p "#{response.code} #{response.body}"
      end
    end
  end
end
