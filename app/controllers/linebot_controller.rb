# frozen_string_literal: true

class LinebotController < ApplicationController
  require 'line/bot'
  require 'rexml/document'

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    head :bad_request unless Utils.client.validate_signature(body, signature)

    events = Utils.client.parse_events_from(body)

    events.each do |event|
      next unless event.is_a?(Line::Bot::Event::Message)
      next unless event.type == Line::Bot::Event::MessageType::Text

      handler = MessageText.find_handler(event)
      handler&.new(event: event)&.run
    end
    head :ok
  end

  def test
    words = Word.all.pluck(:surface, :appearance).last(100).to_h
    font = 'MotoyaLCedar'
    cloud = MagicCloud::Cloud.new(words, rotate: :none, scale: :linear, font_family: font)
    cloud.draw(500, 250).write("public/word.png")
    head :ok
  end
end
