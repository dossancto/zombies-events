# frozen_string_literal: true

require 'sinatra'
require 'json'
require_relative '../services/twtich_api_service'
require_relative '../services/cache/online_streamers_cache'
require_relative '../services/cache/videos_cache'
require_relative '../utils/render_utils'
require_relative '../services/twitch_videos_service'

require_relative '../models/twitch_videos'

# PodcastsController
class PlayersController < Sinatra::Base
  before do
    content_type :json
  end

  get '/aethercup/players/online' do
    cache_controll = OnlineStreamersCache.new

    return RenderUtils.render(cache_controll.read_livestreams) if cache_controll.cache_valid?

    twitch_api = TwtichAPIService.new

    bo1_lives = twitch_api.get_streams_by_game('23894', 'en')
    bo3_lives = twitch_api.get_streams_by_game('489401')

    puts "Bo1 lives: #{bo1_lives}"
    lives = bo1_lives + bo3_lives
    # TODO: Add event filter here.
    # TODO: Store all players

    cache_controll.save_livestreamres(lives)

    RenderUtils.render(lives)
  end

  get '/aethercup/players/videos' do
    cache_controll = VideosCache.new
    return RenderUtils.render(cache_controll.read_videos) if cache_controll.cache_valid?

    twitch_api = TwtichAPIService.new
    latest_vod = TwitchVideosService.latest_video

    vods = if latest_vod.nil?
             twitch_api.get_vods('489401', 15)
           else
             twitch_api.get_all_vods_since('489401', latest_vod.published_at)
           end

    # TODO: Add filters
    TwitchVideos.insert_all(vods.map(&:as_model)) unless vods.empty?

    RenderUtils.render(vods)
  end

  get '/aethercup/players/videos/saved' do
    @videos = TwitchVideosService.all_videos_ordened
    @videos.to_json
  end
end
