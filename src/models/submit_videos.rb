# frozen_string_literal: true

require 'sinatra/activerecord'

## SubmitVideos
class SubmitVideos < ActiveRecord::Base
  validates_presence_of :player_name, :discord_user, :instagram, :twitter, :category, :gameplay_url, :created_at,
                        :updated_at
end
