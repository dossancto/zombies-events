# frozen_string_literal: true

require 'net/http'
require 'dotenv'
require 'json'
require_relative '../dtos/livestream_dto'
require_relative '../dtos/twitch_video_dto'

Dotenv.load

CLIENT_ID = ENV['TWITCH_CLIENT_ID']
CLIENT_SECRET = ENV['TWITCH_CLIENT_SECRET']

BASE_TWITCH_URL = 'https://api.twitch.tv/helix'

## TwtichAPIService
class TwtichAPIService
  attr_reader :access_token

  @@access_token = 'joedyhhmfis02j2tmt4srlqer9wnsj'

  def initialize
    return unless @@access_token.empty?

    new_authorization_token
  end

  # TODO: Pagination support.
  def get_streams_by_game(game_id, lang = 'pt')
    url = "#{BASE_TWITCH_URL}/streams"
    params = URI.encode_www_form('first' => 100, 'game_id' => game_id.to_s, 'language' => lang)

    response = make_general_request(url, params)
    json_body = JSON.parse(response.body)

    streams = json_body['data']

    streams.map do |stream|
      LivestreamDTO.new(stream)
    end
  end

  def get_vods(game_id, count = 100, lang = 'pt', cursor = '')
    url = "#{BASE_TWITCH_URL}/videos"

    fixed_count = count.clamp(0, 100)

    return [] if fixed_count.zero?

    params = URI.encode_www_form('language' => lang, 'game_id' => game_id.to_s, 'period' => 'month', 'first' => fixed_count,
                                 'sort' => 'time', 'after' => cursor)

    if cursor.nil? || cursor.empty? || cursor == ''
      params = URI.encode_www_form('language' => lang, 'game_id' => game_id.to_s, 'period' => 'month', 'first' => fixed_count,
                                   'sort' => 'time')
    end

    response = make_general_request(url, params)
    result = JSON.parse(response.body)
    vods = result['data']

    new_cursor = result['pagination']['cursor']

    parsed_vods = vods.map do |vod|
      TwitchVideoDTO.new(vod)
    end

    if !new_cursor.nil? && new_cursor != ''
      return parsed_vods + get_vods(game_id, count - fixed_count, lang,
                                    new_cursor)
    end

    parsed_vods
  end

  def get_all_vods_since(game_id, date, lang = 'pt', count = 5, limit = 1)
    puts limit
    vods = get_vods(game_id, count, lang)

    last_vod = vods.last
    has_more = last_vod.published_at > date

    puts has_more

    return [] if limit == 10

    return get_all_vods_since(game_id, date, lang, count + 15, limit + 1) if has_more

    vods.filter do |vod|
      vod.published_at > date
    end
  end

  private

  def new_authorization_token
    url = URI.parse('https://id.twitch.tv/oauth2/token')

    headers = {
      'Content-Type' => 'application/x-www-form-urlencoded'
    }

    data = "client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&grant_type=client_credentials"

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')

    request = Net::HTTP::Post.new(url.path, headers)
    request.body = data

    response = http.request(request)

    json_body = JSON.parse(response.body)
    @@access_token = json_body['access_token']
    puts "NEW TOKEN GENERATED #{@@access_token}"
  end

  def make_general_request(url, query)
    url = URI.parse(url)
    url.query = query

    headers = {
      'Authorization' => "Bearer #{@@access_token}",
      'Client-Id' => CLIENT_ID
    }

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')

    request = Net::HTTP::Get.new(url.request_uri, headers)
    http.request(request)
  end
end
