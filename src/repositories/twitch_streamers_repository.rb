require_relative '../../config/mongo_database'

## TwitchVideosRepository
module TwitchStreamersRepository
  def self.insert_new_lives(lives = [LivestreamDTO])
    client = MongoDatabase.database_connection
    collection = client[:streamers]
    viewer_count = lives.inject(0) { |sum, x| sum + x.viewer_count }
    count = lives.length

    document = {
      lives: lives.as_json,
      created_at: DateTime.now,
      total_views: viewer_count,
      lives_count: count
    }

    collection.insert_one(document)
  end
end

# client = DatabaseConfig.database_connection
# # users = db[:users].find
# # users.to_a.to_json

# # Get a reference to the collection
# collection = client[:your_collection_name]

# # Define the document to insert
# document = { field1: 'value1', field2: 'value2' }

# # Insert the document
# result = collection.insert_one(document)

# # Check the result
# return "Document inserted with ID: #{result.inserted_id}" if result.inserted_id

# 'Failed to insert document'
