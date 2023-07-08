# frozen_string_literal: true

require 'selenium-webdriver'

## ScreenShotService
class ScreenShotService
  SHOT_PATH = '/tmp/zombies_round'
  attr_reader :options, :driver

  def initialize
    @shot_path = SHOT_PATH

    @options = Selenium::WebDriver::Chrome::Options.new
    @options.add_argument('--enable-javascript')
    @options.add_argument('headless')
    @driver = Selenium::WebDriver.for(:chrome, options:)
  end

  def take_screen_shot_from(live, delay = 5)
    url = live.livestream_url
    puts url
    @driver.get(url)
    sleep(delay)
    take_screen_shot(live.user_login)
  end

  def self.image_path(streamer_name)
    "#{SHOT_PATH}/#{streamer_name}.png"
  end

  private

  def take_screen_shot(streamer_name)
    shot = @driver.screenshot_as(:png)
    date = Time.now.to_i.to_s
    Dir.mkdir(@shot_path) unless File.directory?(@shot_path)
    file_path = ScreenShotService.image_path(streamer_name)

    File.delete(file_path) if File.exist?(file_path)

    puts "Saving #{file_path}"
    File.open(file_path, 'w+') do |file|
      file.write(shot)
    end
  end
end
