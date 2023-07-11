require 'mongo'
require 'dotenv'

Dotenv.load

## DatabaseConfig
module MongoDatabase
  def self.database_connection
    database_name = 'zombies_events'
    database_url = case ENV['RACK_ENV']
                   when 'production'
                     # "mongodb://#{ENV['MONGO_USERNAME']}:#{ENV['MONGO_PASSWORD']}@#{ENV['MONGO_HOST']}:#{ENV['MONGO_PORT']}/#{database_name}_prod"
                    "mongodb+srv://#{ENV['MONGO_USERNAME']}:#{ENV['MONGO_PASSWORD']}@aether.mkeuhzv.mongodb.net/#{database_name}?retryWrites=true&w=majority&authSource=admin"
                   else
                     "mongodb://root:example@127.0.0.1:27017/#{database_name}_dev?serverSelectionTimeoutMS=2000&authSource=admin"
                   end

    client = Mongo::Client.new(database_url)
    @database_connection ||= client.database
  end
end
