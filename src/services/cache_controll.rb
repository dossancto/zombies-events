# frozen_string_literal: true

## CacheControll
class CacheControll
  attr_reader :file_name, :ext
  attr_accessor :max_live

  CACHE_DIRECTORY = File.join(Dir.home, '.cache/zombies_round')

  def initialize(file_name, ext = 'json')
    @file_name = file_name
    @ext = ext
    @file_path = "#{CACHE_DIRECTORY}/#{file_name}.#{ext}"
    @max_alive = 10 * 60 # 300 secounds, 10 minutes  end
  end

  def set_max_alive(max_alive = 600)
    @max_alive = max_alive
    self
  end

  def cache_valid?
    return false unless File.exist? @file_path

    cache_yet_valid?
  end

  def cache_yet_valid?
    cache = JSON.parse(read_cache)

    given_timestamp = cache['timestamp']

    current_timestamp = Time.now.to_i
    time_difference = current_timestamp - given_timestamp

    time_difference < @max_alive
  end

  def write_cache(content)
    File.open(@file_path, 'w') do |file|
      file.puts content
      puts "[cache] #{@file_name} updated."
    end
  end

  def setup_config_file
    Dir.mkdir(CACHE_DIRECTORY) unless Dir.exist?(CACHE_DIRECTORY)
  end

  def read_cache
    File.read(@file_path)
  end

  def reset_cache
    write_cache('')
    puts 'cache reseted'
  end
end
