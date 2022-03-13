# frozen_string_literal: true

module MessageText
  class PingHandler < BaseHandler
    def process
      client.reply_message(event['replyToken'], pong)
    end

    private

    def pong
      # cf. https://developers.line.biz/ja/reference/messaging-api/#text-message
      {
        type: 'text',
        text: '生きてる'
      }
    end
  end
end
