# frozen_string_literal: true

require 'rmagick'
require_relative '../services/screen_shot_service'

## ImageService
module ImageService
  def self.crop_twitch_player(streamer_name)
    img_path = ScreenShotService.image_path(streamer_name)

    image = Magick::Image.read(img_path).first
    # image.crop('750x420+50+50')
    cropped_image = image.crop(50, 50, 750, 420)

    File.delete(img_path) if File.exist?(img_path)

    cropped_image.write(img_path)

    puts "image updated #{img_path}"
  end

  def self.crop_bo3_round(img_name)
    img_path = ScreenShotService.image_path(img_name)

    image = Magick::Image.read(img_path).first
    image = image.crop(0, 380, 180, 300)

    # image = image.channel(Magick::MagentaChannel)

    # image = image.channel(Magick::RedChannel)
    image = image.quantize(512, Magick::CMYKColorspace)

    # Enhance contrast
    image = image.contrast_stretch_channel(0, Magick::QuantumRange)

    # Sharpen the image
    image = image.sharpen(0, 10)
    # image = image.modulate(30, 100, 100)
    image = image.quantize(256, Magick::GRAYColorspace)

    round_dir = "#{ScreenShotService.get_shot_path}/round"
    Dir.mkdir(round_dir) unless File.directory?(round_dir)

    new_img_path = "#{round_dir}/#{img_name}.png"

    image.write(new_img_path)

    puts "round cropped updated #{new_img_path}"
  end
end
