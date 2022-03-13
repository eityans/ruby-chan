# frozen_string_literal: true

module MessageText
  class WordCloudHandler < BaseHandler
    def process
      client.reply_message(event['replyToken'], image_object)
    end

    private

    def image_object
      # cf. https://developers.line.biz/ja/reference/messaging-api/#image-message
      {
        type: 'image',
        originalContentUrl: image_url,
        previewImageUrl: image_url
      }
    end

    def image_url
      Word.generate_word_cloud
    end
  end
end
