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
require 'rails_helper'

RSpec.describe MarkovDic, type: :model do
  describe "#create_sentence" do
    subject { markov_dic.create_sentence(text, markov_dic) }
    let(:text) { "私は" }
    let(:markov_dic) do
      create(
        :markov_dic,
        prefix_1: "私",
        prefix_2: "は",
        suffix:
      )
    end
    before do
      create(
        :markov_dic,
        prefix_1: "は",
        prefix_2: "犬",
        suffix: "です"
      )
    end

    context "when suffix is 'END_OF_SENTENCE'" do
      let(:suffix) { 'END_OF_SENTENCE' }

      it "returns prefixes" do
        expect(subject).to eq "私は"
      end
    end

    context "when suffix is not 'END_OF_SENTENCE'" do
      context "when next_morkov_dic exists" do
        let(:suffix) { "犬" }

        it "returns prefixes" do
          expect(subject).to eq "私は犬"
        end
      end

      context "when next_morkov_dic does not exist" do
        let(:suffix) { "ほげ" }

        it "returns prefixes" do
          expect(subject).to eq "私は"
        end
      end
    end
  end

  describe "#prefixes" do
    subject { markov_dic.prefixes }
    let(:markov_dic) { create(:markov_dic, prefix_1: "私", prefix_2: "は") }

    it "returns prefixes" do
      expect(subject).to eq "私は"
    end
  end
end
