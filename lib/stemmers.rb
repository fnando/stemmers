# frozen_string_literal: true

require_relative "stemmers/version"
require_relative "stemmers/stemmers"

module Stemmers
  # Detects the language of the given text.
  # If the language cannot be detected, it returns nil.
  #
  # @param text [String] The text to be analyzed.
  # @return [String, nil] The detected language code or nil if undetectable.
  def self.detect_language(text)
    Bindings.detect_language(text)
  end

  # Detects if the language is supported by the stemmers.
  #
  # @param language [String] The language to check.
  # @return [Boolean] True if the language is supported, false otherwise.
  def self.supported_language?(language)
    Bindings.supported_language?(language)
  end

  # Stems the given word in the specified language.
  # If the language is not supported, it raises an `ArgumentError`.
  #
  # @param word [String] The word to be stemmed.
  # @param language [String] The language of the word.
  # @return [String] The stemmed word.
  def self.stem_word(word, language:)
    Bindings.stem_word(word.downcase.strip, language)
  end

  # Stems the given phrase in the specified language.
  # If the language is not supported, it raises an `ArgumentError`.
  #
  # @param phrase [String] The phrase to be stemmed.
  # @param language [String] The language of the phrase.
  # @return [Array<String>] An array of stemmed words.
  def self.stem(phrase, language:)
    phrase.strip.split(/\s+/).map {|word| stem_word(word, language:) }
  end
end
