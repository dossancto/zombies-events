# frozen_string_literal: true

require 'sinatra'
require 'json'
require 'rack/cache'

require_relative '../services/twtich_api_service'

require_relative '../utils/render_utils'

require_relative '../repositories/twitch_videos_repository'
require_relative '../repositories/twitch_streamers_repository'
require_relative '../models/twitch_videos'

# PodcastsController
class PlayersController < Sinatra::Base
  before do
    content_type :json
  end

  get '/aethercup/players/online' do
    cache_control :public, max_age: (60 * 3)
    twitch_api = TwtichAPIService.new

    bo1_lives = twitch_api.get_streams_by_game('23894', 'en')
    bo3_lives = twitch_api.get_streams_by_game('489401')

    lives = bo1_lives + bo3_lives
    # TODO: Add event filter here.

    puts TwitchStreamersRepository.insert_new_lives(lives)

    RenderUtils.render_many(lives)
  end

  get '/aethercup/players/new-videos' do
    twitch_api = TwtichAPIService.new
    latest_vod = TwitchVideosRepository.latest_video

    vods = if latest_vod.nil?
             twitch_api.get_vods('489401', 15)
           else
             twitch_api.get_all_vods_since('489401', latest_vod.published_at)
           end

    return RenderUtils.render_many([]) if vods.empty?

    # TODO: Add filters
    TwitchVideos.insert_all(vods.map(&:as_model)) unless vods.empty?

    RenderUtils.render_many(vods)
  end

  get '/aethercup/players/vods' do
    cache_control :public, max_age: (60 * 10)

    vods = TwitchVideosRepository.all_videos_ordened

    RenderUtils.render_many(vods)
  end
end
