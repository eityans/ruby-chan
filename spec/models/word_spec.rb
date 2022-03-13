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
require 'rails_helper'

RSpec.describe Word, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
