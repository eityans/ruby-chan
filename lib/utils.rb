# frozen_string_literal: true

module Utils
  class << self
    def client
      @client ||= Line::Bot::Client.new do |config|
        config.channel_secret = ENV['LINE_CHANNEL_SECRET']
        config.channel_token = ENV['LINE_CHANNEL_TOKEN']
      end
    end
  end
end
