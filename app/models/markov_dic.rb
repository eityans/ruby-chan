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
class MarkovDic < ApplicationRecord
  validates :prefix_1, uniqueness: { scope: %i[prefix_2 suffix] }

  def create_sentence(text, markov_dic)
    return text if markov_dic.suffix == 'END_OF_SENTENCE'

    next_markov_dic = MarkovDic.where(prefix_1: markov_dic.prefix_2, prefix_2: markov_dic.suffix).sample(1).first
    return text unless next_markov_dic

    text << markov_dic.suffix
    create_sentence(text, next_markov_dic)
  end

  def prefixes
    prefix_1 + prefix_2
  end
end
