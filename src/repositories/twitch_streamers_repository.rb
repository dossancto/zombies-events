require_relative '../../config/mongo_database'

## TwitchVideosRepository
module TwitchStreamersRepository
  def self.insert_new_lives(lives = [LivestreamDTO])
    client = MongoDatabase.database_connection
    collection = client[:streamers]
    viewer_count = lives.inject(0) { |sum, x| sum + x.viewer_count }
    count = lives.length

    mongo_lives = lives.map do |live|
      to_mongodb_live(live)
    end

    document = {
      lives: mongo_lives,
      created_at: DateTime.now,
      total_views: viewer_count,
      lives_count: count
    }

    collection.insert_one(document)
  end

  def self.to_mongodb_live(live)
    {
      user_login: live.user_login,
      title: live.title,
      language: live.language,
      started_at: live.started_at,
      game_name: live.game_name,
      viewer_count: live.viewer_count
    }
  end
end
