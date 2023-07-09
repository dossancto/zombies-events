# frozen_string_literal: true

## ConvertTime
module ConvertTime
  def self.time_to_seconds(time_string)
    hours = minutes = seconds = 0

    if time_string.include?('h')
      hours, time_string = time_string.split('h')
      hours = hours.to_i
    end

    if time_string.include?('m')
      minutes, time_string = time_string.split('m')
      minutes = minutes.to_i
    end

    seconds = time_string.chomp('s').to_i if time_string.include?('s')

    hours * 3600 + minutes * 60 + seconds
  end
end
