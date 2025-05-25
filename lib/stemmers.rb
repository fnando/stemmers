# frozen_string_literal: true

require_relative "stemmers/version"
require_relative "stemmers/stemmers"

module Stemmers
  # Detects the language of the given text.
  # If the language cannot be detected, it returns nil.
  def self.detect_language(text)
    Bindings.detect_language(text)
  end

  # Detects if the language is supported by the stemmers.
  def self.supported_language?(language)
    Bindings.supported_language?(language)
  end

  # Stems the given word in the specified language.
  # If the language is not supported, it raises an `ArgumentError`.
  def self.stem_word(word, language:)
    Bindings.stem_word(word, language)
  end
end
