# frozen_string_literal: true

require 'sinatra'
require 'json'
require_relative '../services/twtich_api_service'
require_relative '../services/cache_controll'

# PodcastsController
class PlayersController < Sinatra::Base
  get '/aethercup/players/online' do
    cache_controll = CacheControll.new

    return render_many(cache_controll.read_livestreams).to_json if cache_controll.cache_valid?

    twitch_api = TwtichAPIService.new
    lives = twitch_api.get_streams_by_game('489401')
    # TODO: Add event filter here.

    cache_controll.write_cache(lives)

    content_type = 'application/json'

    render_many(lives.to_json).to_json
  end

  def render_many(json)
    {
      data: json
    }
  end
end
