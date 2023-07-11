# frozen_string_literal: true

require_relative '../cache_controll'
require_relative '../../dtos/cache_dto'
require_relative '../../dtos/livestream_dto'

## OnlineStreamersCache
class OnlineStreamersCache < CacheControll
  def initialize
    super('online-players')

    # Reload every 3 minutes
    set_max_alive(60 * 3)
  end

  def save_livestreamres(livestreams = [LivestreamDTO])
    cache = CacheDTO.new(livestreams)
    write_cache(cache.to_json)
  end

  def read_livestreams
    cache = JSON.parse(read_cache)
    json_livestreams = cache['content']

    json_livestreams.map do |json_live|
      LivestreamDTO.new json_live
    end
  end
end
