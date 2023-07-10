# frozen_string_literal: true

require 'sinatra'
require_relative './src/controllers/players_controller'
require './src/config/database'

## App
class App < Sinatra::Base
  before do
    content_type :json
  end

  use PlayersController

  get '/' do
    p 'Salve.'
  end
end
