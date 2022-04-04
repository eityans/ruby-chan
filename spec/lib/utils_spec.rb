require 'rails_helper'

RSpec.describe Utils do
  describe "client" do
    subject { described_class.client }

    it "returns Line::Bot::Client instance" do
      expect(subject.is_a?(Line::Bot::Client)).to be true
    end
  end
end
