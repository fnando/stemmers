# frozen_string_literal: true

require_relative "stemmers/version"
require_relative "stemmers/stemmers"

module Stemmers
  # Detects the language of the given text.
  # This method can be quite slow.
  def self.detect_language(text, distance: 0.1)
    Bindings.detect_language(text, distance)
  end

  # Detects if the language is supported by the stemmers.
  def self.supported_language?(language)
    Bindings.supported_language?(language)
  end

  # Stems the given word in the specified language.
  # If the language is "detect", it will automatically detect the language.
  # If the language is not supported, it raises an `ArgumentError`.
  def self.stem_word(word, language: "detect")
    language = detect_language(word) if language == "detect"

    Bindings.stem_word(word, language)
  end
end
