# frozen_string_literal: true

## CacheModel
class CacheModel
  attr_reader :livestreams, :timestamp

  def initialize(livestreams)
    @livestreams = livestreams
    @timestamp = Time.now
  end

  def as_json(_options = {})
    {
      livestreams: @livestreams,
      timestamp: @timestamp.to_i
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end
end
