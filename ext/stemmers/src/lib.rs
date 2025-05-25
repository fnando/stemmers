use magnus::{exception, function, prelude::*, Error, Ruby};
use rust_stemmers::{Algorithm, Stemmer};
use whatlang::{detect, Lang};

fn lang_to_code(lang: Lang) -> Option<String> {
    match lang {
        Lang::Eng => Some("en".into()),
        Lang::Rus => Some("ru".into()),
        Lang::Spa => Some("es".into()),
        Lang::Por => Some("pt".into()),
        Lang::Ita => Some("it".into()),
        Lang::Fra => Some("fr".into()),
        Lang::Deu => Some("de".into()),
        Lang::Ara => Some("ar".into()),
        Lang::Nob => Some("nb".into()),
        Lang::Dan => Some("da".into()),
        Lang::Swe => Some("sv".into()),
        Lang::Fin => Some("fi".into()),
        Lang::Tur => Some("tr".into()),
        Lang::Nld => Some("nl".into()),
        Lang::Hun => Some("hu".into()),
        Lang::Ell => Some("el".into()),
        Lang::Ron => Some("ro".into()),
        Lang::Tam => Some("ta".into()),
        _ => None,
    }
}

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

fn detect_language(text: String) -> Option<String> {
    let Some(info) = detect(&text) else {
        return None;
    };

    lang_to_code(info.lang())
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
    module.define_singleton_method("detect_language", function!(detect_language, 1))?;
    module.define_singleton_method("supported_language?", function!(is_supported_language, 1))?;
    Ok(())
}
