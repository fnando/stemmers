use lingua::{
    Language::{
        Arabic, Danish, Dutch, English, Finnish, French, German, Greek, Hungarian, Italian,
        Portuguese, Romanian, Russian, Spanish, Swedish, Tamil, Turkish,
    },
    LanguageDetectorBuilder,
};
use magnus::{exception, function, prelude::*, Error, Ruby};
use rust_stemmers::{Algorithm, Stemmer};

fn get_algorithm(language: &str) -> Option<Algorithm> {
    let algorithm = match language {
        "ar" => Algorithm::Arabic,
        "da" => Algorithm::Danish,
        "de" => Algorithm::German,
        "el" => Algorithm::Greek,
        "en" => Algorithm::English,
        "es" => Algorithm::Spanish,
        "fi" => Algorithm::Finnish,
        "fr" => Algorithm::French,
        "hu" => Algorithm::Hungarian,
        "it" => Algorithm::Italian,
        "nl" => Algorithm::Dutch,
        "no" => Algorithm::Norwegian,
        "pt" => Algorithm::Portuguese,
        "ro" => Algorithm::Romanian,
        "ru" => Algorithm::Russian,
        "sv" => Algorithm::Swedish,
        "ta" => Algorithm::Tamil,
        "tr" => Algorithm::Turkish,
        _ => return None,
    };

    Some(algorithm)
}

fn detect_language(text: String, distance: f64) -> Option<String> {
    let detector = LanguageDetectorBuilder::from_languages(&[
        Arabic, Danish, Dutch, English, Finnish, French, German, Greek, Hungarian, Italian,
        Portuguese, Romanian, Russian, Spanish, Swedish, Tamil, Turkish,
    ])
    .with_minimum_relative_distance(distance)
    .build();

    let Some(language) = detector.detect_language_of(text) else {
        return None;
    };

    Some(format!("{}", language.iso_code_639_1().to_string()))
}

fn stem_word(word: String, language: String) -> Result<String, Error> {
    let Some(algorithm) = get_algorithm(&language) else {
        return Err(Error::new(
            exception::arg_error(),
            format!("Unsupported language: {language}"),
        ));
    };

    let stemmer = Stemmer::create(algorithm);
    Ok(stemmer.stem(word.as_str()).to_string())
}

fn is_supported_language(language: String) -> bool {
    get_algorithm(&language).is_some()
}

#[magnus::init]
fn init(ruby: &Ruby) -> Result<(), Error> {
    let root = ruby.define_module("Stemmers")?;
    let module = root.define_module("Bindings")?;
    module.define_singleton_method("stem_word", function!(stem_word, 2))?;
    module.define_singleton_method("detect_language", function!(detect_language, 2))?;
    module.define_singleton_method("supported_language?", function!(is_supported_language, 1))?;
    Ok(())
}
