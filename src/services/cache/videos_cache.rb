# frozen_string_literal: true

require_relative '../cache_controll'
require_relative '../../models/cache_model'
require_relative '../../models/twitch_video_model.rb'

## OnlineStreamersCache
class VideosCache < CacheControll
  def initialize
    super('vods')
  end

  def save_videos(vods = [TwitchVideoModel])
    cache = CacheModel.new(vods)
    write_cache(cache.to_json)
  end

  def read_videos
    cache = JSON.parse(read_cache)
    json_content = cache['content']

    json_content.map do |content|
      TwitchVideoModel.new content
    end
  end
end
