require 'rails_helper'

RSpec.describe Factory do
  describe "random_sentence" do
    subject { described_class.new.random_sentence(noun) }

    context "when there is no word about arg noun in Word" do
      let(:noun) { "nothing" }

      it "returns arg noun" do
        expect(subject).to be noun
      end
    end

    context "when there are words about arg noun in Word" do
      let(:noun) { "存在" }
      before do
        create(:word, pos: "名詞", reading: "そんざい", surface: noun)
      end

      context "when there is no MarkovDic" do
        it "returns arg noun" do
          expect(subject).to be noun
        end
      end

      context "when there are MarkovDic" do
        before do
          create(:markov_dic, prefix_1: "存在", prefix_2: "する", suffix: "私")
        end

        it "returns arg noun" do
          expect(subject).to include "存在する"
        end
      end
    end
  end
end
