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

  def as_json(_options = {})
    {
      id: @id,
      user_id: @user_id,
      user_login: @user_login,
      user_name: @user_name,
      game_id: @game_id,
      game_name: @game_name,
      type: @type,
      title: @title,
      viewer_count: @viewer_count,
      started_at: @started_at,
      language: @language,
      thumbnail_url: @thumbnail_url,
      tag_ids: @tag_ids,
      tags: @tags,
      is_mature: @is_mature
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end
end
