# frozen_string_literal: true

## LiveStremModel
class LivestreamModel
  TWITCH_CHANNEL_BASE_URL = 'https://www.twitch.tv'
  attr_accessor :id, :user_id, :user_login, :user_name, :game_id, :game_name, :type,
                :title, :viewer_count, :started_at, :language, :thumbnail_url,
                :tag_ids, :tags, :is_mature

  def initialize(info)
    @id = info['id']
    @user_id = info['user_id']
    @user_login = info['user_login']
    @user_name = info['user_name']
    @game_id = info['game_id']
    @game_name = info['game_name']
    @type = info['type']
    @title = info['title']
    @viewer_count = info['viewer_count']
    @started_at = info['started_at']
    @language = info['language']
    @thumbnail_url = info['thumbnail_url']
    @tag_ids = info['tag_ids']
    @tags = info['tags']
    @is_mature = info['is_mature']
  end

  def livestream_url
    "#{TWITCH_CHANNEL_BASE_URL}/#{@user_login}"
  end
end
