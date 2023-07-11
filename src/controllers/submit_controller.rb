# frozen_string_literal: true

require 'sinatra'
require 'json'
require_relative '../repositories/submit_videos_repository'

# PodcastsController
class SubmitController < Sinatra::Base
  before do
    content_type :json
  end

  post '/submit/video' do
    json = JSON.parse(request.body.read)
    status 201

    vid = SubmitVideosRepository.insert_from_json(json)

    vid.to_json
  end
end
