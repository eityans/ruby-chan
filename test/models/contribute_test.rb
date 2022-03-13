# frozen_string_literal: true

# == Schema Information
#
# Table name: contributes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#  word_id    :integer          not null
#
# Indexes
#
#  index_contributes_on_user_id  (user_id)
#
require 'test_helper'

class ContributeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
