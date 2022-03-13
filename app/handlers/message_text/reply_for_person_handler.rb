# frozen_string_literal: true

module MessageText
  class ReplyForPersonHandler < BaseHandler
    def process
      client.reply_message(event['replyToken'], reply_message_json)
    end
  end
end
