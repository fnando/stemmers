# frozen_string_literal: true

require "test_helper"

class StemmersTest < Minitest::Test
  test "detects supported language" do
    assert Stemmers.supported_language?("en")
    assert Stemmers.supported_language?("pt")
    assert Stemmers.supported_language?("it")
    assert Stemmers.supported_language?("es")
    assert Stemmers.supported_language?("fr")
    assert Stemmers.supported_language?("de")
    assert Stemmers.supported_language?("nl")
    assert Stemmers.supported_language?("ru")
    assert Stemmers.supported_language?("sv")
    assert Stemmers.supported_language?("fi")
    assert Stemmers.supported_language?("ar")
    assert Stemmers.supported_language?("hy")
    assert Stemmers.supported_language?("ca")
    assert Stemmers.supported_language?("cs")
    assert Stemmers.supported_language?("da")
    assert Stemmers.supported_language?("et")
    assert Stemmers.supported_language?("el")
    assert Stemmers.supported_language?("hi")
    assert Stemmers.supported_language?("hu")
    assert Stemmers.supported_language?("id")
    assert Stemmers.supported_language?("lt")
    assert Stemmers.supported_language?("ne")
    assert Stemmers.supported_language?("nb")
    assert Stemmers.supported_language?("pl")
    assert Stemmers.supported_language?("ro")
    assert Stemmers.supported_language?("tr")
    assert Stemmers.supported_language?("yi")
  end

  test "stems word (en)" do
    assert_equal "test", Stemmers.stem_word("testing", language: "en")
  end

  test "stems word (pt)" do
    assert_equal "cac", Stemmers.stem_word("caça", language: "pt")
  end

  test "stems word (it)" do
    assert_equal "parl", Stemmers.stem_word("parlare", language: "it")
  end

  test "stems word (es)" do
    assert_equal "trabaj", Stemmers.stem_word("trabajando", language: "es")
  end

  test "stems word (fr)" do
    assert_equal "aim", Stemmers.stem_word("aimant", language: "fr")
  end

  test "stems word (de)" do
    assert_equal "arbeit", Stemmers.stem_word("arbeitend", language: "de")
  end

  test "stems word (nl)" do
    assert_equal "lop", Stemmers.stem_word("lopen", language: "nl")
  end

  test "stems word (ru)" do
    assert_equal "работа", Stemmers.stem_word("работать", language: "ru")
  end

  test "stems word (sv)" do
    assert_equal "arbet", Stemmers.stem_word("arbetade", language: "sv")
  end

  test "stems word (fi)" do
    assert_equal "talo", Stemmers.stem_word("talossa", language: "fi")
  end

  test "stems word (ar)" do
    assert_equal "كتاب", Stemmers.stem_word("كتابة", language: "ar")
  end

  test "stems word (hy)" do
    assert_equal "գիտությ", Stemmers.stem_word("գիտություն", language: "hy")
  end

  test "stems word (ca)" do
    assert_equal "treball", Stemmers.stem_word("treballant", language: "ca")
  end

  test "stems word (cs)" do
    assert_equal "prac", Stemmers.stem_word("pracovat", language: "cs")
  end

  test "stems word (da)" do
    assert_equal "arbejd", Stemmers.stem_word("arbejder", language: "da")
  end

  test "stems word (et)" do
    assert_equal "maja", Stemmers.stem_word("majast", language: "et")
  end

  test "stems word (el)" do
    assert_equal "εργασ", Stemmers.stem_word("εργασία", language: "el")
  end

  test "stems word (hi)" do
    assert_equal "पढ़", Stemmers.stem_word("पढ़ाई", language: "hi")
  end

  test "stems word (hu)" do
    assert_equal "ház", Stemmers.stem_word("házak", language: "hu")
  end

  test "stems word (id)" do
    assert_equal "kerja", Stemmers.stem_word("bekerja", language: "id")
  end

  test "stems word (lt)" do
    assert_equal "darb", Stemmers.stem_word("darbas", language: "lt")
  end

  test "stems word (ne)" do
    assert_equal "काम", Stemmers.stem_word("कामहरू", language: "ne")
  end

  test "stems word (nb)" do
    assert_equal "arbeid", Stemmers.stem_word("arbeider", language: "nb")
  end

  test "stems word (pl)" do
    assert_equal "prac", Stemmers.stem_word("pracować", language: "pl")
  end

  test "stems word (ro)" do
    assert_equal "lucr", Stemmers.stem_word("lucra", language: "ro")
  end

  test "stems word (tr)" do
    assert_equal "ev", Stemmers.stem_word("evler", language: "tr")
  end

  test "stems word (yi)" do
    assert_equal "לערנ", Stemmers.stem_word("לערנען", language: "yi")
  end

  test "raises error for unsupported language" do
    error = assert_raises(ArgumentError) do
      Stemmers.stem_word("testing", language: "invalid")
    end

    assert_equal "Unsupported language: invalid", error.message
  end

  test "detects language" do
    assert_equal "en", Stemmers.detect_language("this is a test")
    assert_equal "pt", Stemmers.detect_language("isto é um teste")
    assert_equal "it", Stemmers.detect_language("questo è molto bello")
    assert_equal "es", Stemmers.detect_language("esto es una prueba")
    assert_equal "fr", Stemmers.detect_language("ceci est un test")
    assert_equal "de", Stemmers.detect_language("das ist ein Test")
    assert_equal "nl", Stemmers.detect_language("dit is een test")
    assert_equal "ru", Stemmers.detect_language("это тест")
    assert_equal "sv", Stemmers.detect_language("det här är ett test")
    assert_equal "fi", Stemmers.detect_language("tämä on testi")
    assert_equal "ar", Stemmers.detect_language("هذا اختبار")
    assert_equal "hy", Stemmers.detect_language("սա թեստ է")
    assert_equal "ca", Stemmers.detect_language("això és una prova")
    assert_equal "cs", Stemmers.detect_language("dobrý den jak se jmenujete")
    assert_equal "da", Stemmers.detect_language("jeg hedder Lars")
    assert_equal "et", Stemmers.detect_language("see on test")
    assert_equal "el", Stemmers.detect_language("αυτό είναι ένα τεστ")
    assert_equal "hi", Stemmers.detect_language("यह एक परीक्षा है")
    assert_equal "hu", Stemmers.detect_language("ez egy teszt")
    assert_equal "id", Stemmers.detect_language("terima kasih banyak")
    assert_equal "lt", Stemmers.detect_language("tai yra testas")
    assert_equal "ne", Stemmers.detect_language("तपाईं कस्तो हुनुहुन्छ")
    assert_equal "nb", Stemmers.detect_language("dette er en test")
    assert_equal "pl", Stemmers.detect_language("dziękuję bardzo za pomoc")
    assert_equal "ro", Stemmers.detect_language("mulțumesc pentru ajutor")
    assert_equal "tr", Stemmers.detect_language("merhaba nasılsınız")
    assert_equal "yi", Stemmers.detect_language("דאָס איז אַ טעסט")
    assert_nil Stemmers.detect_language("asdfasdfasdf")
  end
end
