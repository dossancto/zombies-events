# frozen_string_literal: true

require 'sinatra'
require_relative './src/controllers/players_controller'
require_relative './src/controllers/submit_controller'
require './config/postgres_database'

## App
class App < Sinatra::Base
  before do
    content_type :json
  end

  use PlayersController
  use SubmitController

  get '/' do
    p 'Salve.'
  end
end
