# frozen_string_literal: true

module MessageText
  class << self
    def find_handler(event)
      receive_message = event.message['text']

      if receive_message.eql?('生きてる？')
        PingHandler
      elsif receive_message.in?(%w[ワードクラウド 脳内])
        WordCloudHandler
      elsif event['source']['groupId'].present?
        ReplyForGroupHandler
      else
        # TODO: ルビイちゃんから個人に送りだす部分は、Jobとして詰め込む方式で書き直す
        # if rand(100) < 2
        #  User.where(premium: true).all.each do |user|
        #    next if [1..100].sample(1)[0] < 10
        #    client.push_message(user.user_id, message_json(factory.random_sentence(poses.sample)))
        #  end
        # end
        ReplyForPersonHandler
      end
    end
  end
end
