# frozen_string_literal: true

require 'json'

## RenderUtils
module RenderUtils
  def self.render(content)
    return render_many(content) if content.is_a?(Array)

    render_one(content)
  end

  def self.render_one(json)
    json.to_json
  end

  def self.render_many(json)
    {
      count: json.length,
      data: json
    }.to_json
  end
end
