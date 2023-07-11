# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'dotenv'

Dotenv.load

configure :development do
  set :database, { adapter: 'postgresql', encoding: 'unicode',
                   host: 'localhost',
                   database: 'zombies_round_dev', pool: 2, username: 'postgres', password: 'postgres' }
end

configure :production do
  set :database, { adapter: 'postgresql', encoding: 'unicode', host: ENV['POSTGRES_DATABASE_HOST'],
                   database: ENV['POSTGRES_DATABASE_NAME'], pool: 2, username: ENV['POSTGRES_DATABASE_USER'],
                   password: ENV['POSTGRES_DATABASE_PASSWORD'] }
end
