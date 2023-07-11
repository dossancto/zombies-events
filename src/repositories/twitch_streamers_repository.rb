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
