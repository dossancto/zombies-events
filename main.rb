require './src/services/twtich_api_service'
require './src/services/screen_shot_service'
require './src/services/image_service'

def start
  twitch_api = TwtichAPIService.new
  lives = twitch_api.get_streams_by_game('489401')

  screenshot = ScreenShotService.new

  lives.each do |live|
    screenshot.take_screen_shot_from(live, 10)
    ImageService.crop_twitch_player(live.user_login)
    ImageService.crop_bo3_round(live.user_login)
  end
end

start
