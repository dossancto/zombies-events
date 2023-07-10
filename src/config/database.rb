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
  set :database, { adapter: 'postgresql', encoding: 'unicode', host: ENV['DATABASE_HOST'],
                   database: ENV['DATABASE_NAME'], pool: 2, username: ENV['DATABASE_USER'],
                   password: ENV['DATABASE_PASSWORD'] }
end
