# == Schema Information
#
# Table name: words
#
#  id                 :bigint           not null, primary key
#  appearance         :integer          default(0)
#  pos                :string           not null
#  reading            :string           not null
#  surface            :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  contribute_user_id :integer
#
# Indexes
#
#  index_words_on_surface                      (surface)
#  index_words_on_surface_and_reading_and_pos  (surface,reading,pos) UNIQUE
#
FactoryBot.define do
  factory :word do
    pos { "名詞" }
    reading { "わたし" }
    surface { "私" }
  end
end
