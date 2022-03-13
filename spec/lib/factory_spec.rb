require 'rails_helper'

RSpec.describe Factory do
  describe "random_sentence" do
    subject { described_class.new.random_sentence(noun) }

    context "when there is no arg noun in Word" do
      let(:noun) { "nothing" }

      it "returns arg noun" do
        expect(subject).to be noun
      end
    end
  end
end
