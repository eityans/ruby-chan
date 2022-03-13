# frozen_string_literal: true

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
class Word < ApplicationRecord
  validates :surface, uniqueness: { scope: %i[reading pos] }

  def self.save_words(morphological_words, user) # rubocop:disable Lint/UnusedMethodArgument
    poses = []

    morphological_words.each do |word|
      w = Word.find_or_initialize_by(word)

      poses << w.surface if w.pos == '名詞'
      w.appearance += 1
      w.save!
    end

    poses
  end

  def self.generate_word_cloud
    words = Word.where(pos: "名詞").order(appearance: :desc).pluck(:surface, :appearance).first(100).to_h
    font = 'MotoyaLCedar'
    cloud = MagicCloud::Cloud.new(words, rotate: :none, scale: :linear, font_family: font)
    image_name = "#{Time.zone.now.to_i}.png"
    cloud.draw(500, 250).write("public/#{image_name}")
    "https://peaceful-dusk-72142.herokuapp.com/#{image_name}"
  end
end
