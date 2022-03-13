# frozen_string_literal: true

# == Schema Information
#
# Table name: markov_dics
#
#  id         :bigint           not null, primary key
#  prefix_1   :string           not null
#  prefix_2   :string           not null
#  suffix     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_markov_dics_on_prefix_1_and_prefix_2             (prefix_1,prefix_2)
#  index_markov_dics_on_prefix_1_and_prefix_2_and_suffix  (prefix_1,prefix_2,suffix) UNIQUE
#
require 'test_helper'

class MarkovDicTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
