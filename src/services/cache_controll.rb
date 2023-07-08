# frozen_string_literal: true

require_relative '../models/livestream_model'
require_relative '../models/cache_model'

## CacheControll
class CacheControll
  CACHE_DIRECTORY = File.join(Dir.home, '.cache/zombies_round')
  CACHE_FILE_LOCATION = File.join(CACHE_DIRECTORY, 'players.json')

  MAX_ALIVE = 10 * 60 * 1000 # 10 minutes

  def cache_valid?
    return false unless File.exist? CACHE_FILE_LOCATION

    cache_yet_valid?
  end

  def cache_yet_valid?
    cache = JSON.parse(read_cache)

    given_timestamp = cache['timestamp']

    current_timestamp = Time.now.to_i
    time_difference = current_timestamp - given_timestamp

    time_difference < MAX_ALIVE
  end

  def write_cache(livestreams = [LivestreamModel])
    setup_config_file

    cache_content = CacheModel.new(livestreams)

    File.open(CACHE_FILE_LOCATION, 'w') do |file|
      content = cache_content.to_json
      file.puts content
      puts 'livestreams cache updated'
    end
  end

  def read_livestreams
    cache = JSON.parse(read_cache)
    json_livestreams = cache['livestreams']

    json_livestreams.map do |json_live|
      LivestreamModel.new json_live
    end
  end

  private

  def setup_config_file
    Dir.mkdir(CACHE_DIRECTORY) unless Dir.exist?(CACHE_DIRECTORY)
  end

  def read_cache
    File.read(CACHE_FILE_LOCATION)
  end
end
