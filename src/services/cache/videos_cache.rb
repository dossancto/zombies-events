# frozen_string_literal: true

require_relative '../cache_controll'
require_relative '../../dtos/cache_dto'
require_relative '../../dtos/twitch_video_dto'

## OnlineStreamersCache
class VideosCache < CacheControll
  def initialize
    super('vods')
  end

  def save_videos(vods = [TwitchVideoDTO])
    return if vods.empty?

    cache = CacheDTO.new(vods)
    write_cache(cache.to_json)
  end

  def read_videos
    cache = JSON.parse(read_cache)
    json_content = cache['content']

    json_content.map do |content|
      TwitchVideoDTO.new content
    end
  end
end
