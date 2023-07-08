# frozen_string_literal: true

require_relative '../services/twtich_api_service'
require_relative '../models/livestream_model'

## EventFiltersService
module EventFiltersService
  def self.aethercup_filter(livestreams = [])
    filter_words = ['#aethercup', 'aethercup', 'aether cup']

    livestreams.select do |live|
      filter_words.any? do |word|
        filter_word = word.downcase
        title = live.title.downcase

        title.include?(filter_word)
      end
    end
  end
end
