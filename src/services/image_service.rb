# frozen_string_literal: true

require 'mini_magick'
require_relative '../services/screen_shot_service'

## ImageService
module ImageService
  def self.crop_twitch_player(streamer_name)
    img_path = ScreenShotService.image_path(streamer_name)

    image = MiniMagick::Image.open(img_path)
    image.crop('750x420+50+50')

    File.delete(img_path) if File.exist?(img_path)

    image.write(img_path)

    puts "image updated #{img_path}"
  end

  def self.crop_bo3_round(img_name)
    img_path = ScreenShotService.image_path(img_name)

    image = MiniMagick::Image.open(img_path)
    image.crop('130x300+0+400')

    round_dir = "#{ScreenShotService.get_shot_path}/round"
    Dir.mkdir(round_dir) unless File.directory?(round_dir)

    new_img_path = "#{round_dir}/#{img_name}.png"

    image.write(new_img_path)

    puts "round cropped updated #{new_img_path}"
  end
end
