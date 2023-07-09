# frozen_string_literal: true

require_relative '../cache_controll'
require_relative '../../models/cache_model'

## OnlineStreamersCache
class OnlineStreamersCache < CacheControll
  def initialize
    super('online-players')
  end

  def save_livestreamres(livestreams = [LivestreamModel])
    cache = CacheModel.new(livestreams)
    write_cache(cache.to_json)
  end

  def read_livestreams
    cache = JSON.parse(read_cache)
    json_livestreams = cache['content']

    json_livestreams.map do |json_live|
      LivestreamModel.new json_live
    end
  end
end
