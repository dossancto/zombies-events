# frozen_string_literal: true

require_relative '../utils/convert_time'
require 'date'

## TwitchVideoModel
class TwitchVideoDTO
  attr_accessor :id, :stream_id, :user_id, :user_login, :user_name, :title, :description, :created_at,
                :published_at, :url, :thumbnail_url, :viewable, :view_count, :language, :type, :duration,
                :muted_segments

  def initialize(json_data)
    duration = get_duration(json_data['duration'])
    created_at = get_time(json_data['created_at'])
    updated_at = get_time(json_data['published_at'])

    @id = json_data['id']
    @stream_id = json_data['stream_id']
    @user_id = json_data['user_id']
    @user_login = json_data['user_login']
    @user_name = json_data['user_name']
    @title = json_data['title']
    @description = json_data['description']
    @created_at = created_at
    @published_at = updated_at
    @url = json_data['url']
    @thumbnail_url = json_data['thumbnail_url']
    @viewable = json_data['viewable']
    @view_count = json_data['view_count']
    @language = json_data['language']
    @type = json_data['type']
    @duration = duration
    @muted_segments = json_data['muted_segments']
  end

  def as_json(_options = {})
    {
      id: @id,
      stream_id: @stream_id,
      user_id: @user_id,
      user_login: @user_login,
      user_name: @user_name,
      title: @title,
      description: @description,
      created_at: @created_at,
      published_at: @published_at,
      url: @url,
      thumbnail_url: @thumbnail_url,
      viewable: @viewable,
      view_count: @view_count,
      language: @language,
      type: @type,
      duration: @duration,
      muted_segments: @muted_segments
    }
  end

  def as_model
    {
      user_login: @user_login,
      user_name: @user_name,
      title: @title,
      description: @description,
      published_at: @published_at,
      url: @url,
      view_count: @view_count,
      language: @language,
      duration: @duration
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end

  private

  def get_time(date)
    return date unless date.is_a?(String)

    DateTime.parse(date)
  end

  def get_duration(duration)
    return duration if duration.is_a?(Integer)

    ConvertTime.time_to_seconds(duration)
  end
end
