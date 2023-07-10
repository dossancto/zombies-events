# frozen_string_literal: true

require 'sinatra/activerecord'

## TwitchVideo
class TwitchVideos < ActiveRecord::Base
  validates_presence_of :title, :description, :view_count, :published_at, :url, :duration, :language, :user_login,
                        :user_name
end
