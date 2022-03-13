# frozen_string_literal: true

module MessageText
  class ReplyForGroupHandler < BaseHandler
    def process
      client.reply_message(event['replyToken'], reply_message_json) if rand(100) < 30
    end
  end
end
