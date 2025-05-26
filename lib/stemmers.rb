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
  # @param normalize [Boolean] If true, removes accents from the word after
  #                            stemming.
  # @return [String] The stemmed word.
  def self.stem_word(word, language:, normalize: false)
    stem = Bindings.stem_word(word, language)
    stem = normalize_word(stem) if normalize

    stem
  end

  # Stems the given phrase in the specified language.
  # If the language is not supported, it raises an `ArgumentError`.
  #
  # @param phrase [String] The phrase to be stemmed.
  # @param language [String] The language of the phrase.
  # @param clean [Boolean] If true, removes stop words before stemming.
  # @param normalize [Boolean] If true, removes accents from the phrase
  #                                 after stemming.
  # @return [Array<String>] An array of stemmed words.
  def self.stem(phrase, language:, clean: false, normalize: false)
    words = phrase.downcase.strip.split(/\s+/)

    if clean
      stop_words = stop_words(language)
      words = words.reject {|word| stop_words.include?(word) }
    end

    words.map {|word| stem_word(word, language:, normalize:) }
  end

  # Returns the stop words for the specified language.
  # If the language is not supported, an empty list is returned.
  #
  # @param language [String] The language for which to retrieve stop words.
  # @return [Array<String>] An array of stop words.
  def self.stop_words(language)
    stop_words_cache[language]
  end

  # Normalizes a word by removing accents and diacritics.
  # This is useful for languages where accents do not change the meaning
  # of the word, such as Portuguese.
  #
  # @param word [String] The word to be normalized.
  # @return [String] The normalized word with accents removed.
  def self.normalize_word(word)
    word.unicode_normalize(:nfkd).gsub(/\p{M}/, "")
  end

  # Returns a cache of stop words loaded from a JSON file.
  # The cache is initialized only once and reused for subsequent calls.
  # @return [Hash<String, Array<String>>] A hash mapping language codes to
  #                                       arrays of stop words.
  def self.stop_words_cache
    @stop_words_cache ||= Hash.new do |hash, key|
      path = File.join(__dir__, "stemmers/stopwords/#{key}.json")
      hash[key] = File.file?(path) ? JSON.load_file(path) : []
    end
  end
end
