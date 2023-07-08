# frozen_string_literal: true

require 'net/http'
require 'dotenv'
require 'json'
require_relative '../models/livestream_model'

Dotenv.load

CLIENT_ID = ENV['TWITCH_CLIENT_ID']
CLIENT_SECRET = ENV['TWITCH_CLIENT_SECRET']

BASE_TWITCH_URL = 'https://api.twitch.tv/helix'

## TwtichAPIService
class TwtichAPIService
  attr_reader :access_token

  @@access_token = ''

  def initialize
    return unless @@access_token.empty?

    new_authorization_token
  end

  # TODO: Pagination support.
  def get_streams_by_game(game_id, lang = 'pt')
    url = URI.parse("#{BASE_TWITCH_URL}/streams")
    params = URI.encode_www_form('first' => 100, 'game_id' => game_id.to_s, 'language' => lang)
    url.query = params

    headers = {
      'Authorization' => "Bearer #{@@access_token}",
      'Client-Id' => CLIENT_ID
    }

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')

    request = Net::HTTP::Get.new(url.request_uri, headers)
    response = http.request(request)
    json_body = JSON.parse(response.body)

    streams = json_body['data']

    streams.map do |stream|
      LivestreamModel.new(stream)
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
end
