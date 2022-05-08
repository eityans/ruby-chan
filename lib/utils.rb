# frozen_string_literal: true

module Utils
  class << self
    def client
      @client ||= Line::Bot::Client.new do |config|
        config.channel_secret = ENV.fetch('LINE_CHANNEL_SECRET', nil)
        config.channel_token = ENV.fetch('LINE_CHANNEL_TOKEN', nil)
      end
    end
  end
end
