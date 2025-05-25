# frozen_string_literal: true

require "test_helper"

class StemmersTest < Minitest::Test
  test "detects supported language" do
    assert Stemmers.supported_language?("en")
    assert Stemmers.supported_language?("pt")
  end

  test "stems word (en)" do
    assert_equal "test", Stemmers.stem_word("testing", language: "en")
    assert_equal "test", Stemmers.stem_word("tested", language: "en")
    assert_equal "test", Stemmers.stem_word("tests", language: "en")
  end

  test "stems word (pt)" do
    assert_equal "cac", Stemmers.stem_word("caça", language: "pt")
    assert_equal "cac", Stemmers.stem_word("caçado", language: "pt")
    assert_equal "cac", Stemmers.stem_word("caçando", language: "pt")
  end

  test "raises error for unsupported language" do
    error = assert_raises(ArgumentError) do
      Stemmers.stem_word("testing", language: "invalid")
    end

    assert_equal "Unsupported language: invalid", error.message
  end

  test "detects language" do
    assert_equal "en", Stemmers.detect_language("this is a test")
    assert_equal "pt", Stemmers.detect_language("isso é um teste")
  end
end
