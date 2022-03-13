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
FactoryBot.define do
  factory :user do
    name { "name" }
    user_id { "これなんだっけ" }
  end
end
