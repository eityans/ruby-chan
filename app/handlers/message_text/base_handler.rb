# frozen_string_literal: true

module MessageText
  class BaseHandler
    attr_reader :event, :user

    def initialize(event:)
      @event = event
      @user = User.find_or_create_user(event['source']['userId'])
    end

    def run
      process
    end

    def process
      raise 'not implemented'
    end

    private

    def reply_message_json
      message_json(factory.random_sentence(poses.sample))
    end

    def factory
      @factory ||= Factory.new
    end

    def poses
      factory.record(receive_message, user)
    end

    def receive_message
      event.message['text']
    end

    def client
      @client ||= Utils.client
    end

    def message_json(message)
      {
        type: 'text',
        text: message
      }
    end
  end
end
