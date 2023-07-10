# frozen_string_literal: true

## CacheModel
class CacheDTO
  attr_reader :content, :timestamp

  def initialize(content)
    @content = content
    @timestamp = Time.now
  end

  def as_json(_options = {})
    {
      content: @content,
      timestamp: @timestamp.to_i
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end
end
