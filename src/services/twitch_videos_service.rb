# frozen_string_literal: true

require_relative '../models/twitch_videos'

## TwitchVideosService
module TwitchVideosService
  def self.latest_video
    TwitchVideos.order(published_at: :desc).first
  end

  def self.all_videos_ordened
    TwitchVideos.order(published_at: :desc)
  end
end
