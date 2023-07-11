# frozen_string_literal: true

require 'sinatra'
require_relative './src/controllers/players_controller'
require_relative './src/controllers/submit_controller'

set :database_file, 'config/database.yml'

## App
class App < Sinatra::Base
  before do
    content_type :json
  end

  use Rack::Cache,
      verbose: true,
      metastore: 'heap:/',
      entitystore: 'heap:/'

  use PlayersController
  use SubmitController

  get '/' do
    p 'Salve.'
  end
end
