# frozen_string_literal: true

require_relative '../models/submit_videos'

## TwitchVideosRepository
module SubmitVideosRepository
  def self.insert_from_json(json)
    vid = SubmitVideos.new

    vid.player_name = json['player_name']
    vid.discord_user = json['discord_user']
    vid.instagram = json['instagram']
    vid.twitter = json['twitter']
    vid.category = json['category']
    vid.gameplay_url = json['gameplay_url']
    vid.created_at = DateTime.now
    vid.updated_at = DateTime.now

    vid.save

    vid
  end
end
