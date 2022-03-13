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
FactoryBot.define do
  factory :markov_dic do
    prefix_1 { "私" }
    prefix_2 { "は" }
    suffix { "犬" }
  end
end
