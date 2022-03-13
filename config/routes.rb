# frozen_string_literal: true

# == Route Map
#
#   Prefix Verb URI Pattern         Controller#Action
# callback POST /callback(.:format) linebot#callback

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/callback', to: 'linebot#callback'

  get '/test', to: 'linebot#test'
end
