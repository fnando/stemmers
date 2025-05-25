use magnus::{exception, function, prelude::*, Error, Ruby};
use tantivy_stemmers::algorithms::{
    arabic, armenian_mkrtchyan, catalan, czech_dolamic_light, danish, dutch, english_porter_2,
    estonian_freienthal, finnish, french, german, greek, hindi_lightweight, hungarian,
    indonesian_tala, italian, lithuanian_jocas, nepali, norwegian_bokmal,
    polish_yarovoy_unaccented, portuguese, romanian, russian, spanish, swedish, turkish_cilden,
    yiddish_urieli,
};
use whatlang::{detect, Lang};

fn lang_to_code(lang: Lang) -> Option<String> {
    match lang {
        Lang::Ara => Some("ar".into()),
        Lang::Cat => Some("ca".into()),
        Lang::Ces => Some("cs".into()),
        Lang::Dan => Some("da".into()),
        Lang::Deu => Some("de".into()),
        Lang::Ell => Some("el".into()),
        Lang::Eng => Some("en".into()),
        Lang::Est => Some("et".into()),
        Lang::Fin => Some("fi".into()),
        Lang::Fra => Some("fr".into()),
        Lang::Hin => Some("hi".into()),
        Lang::Hun => Some("hu".into()),
        Lang::Hye => Some("hy".into()),
        Lang::Ind => Some("id".into()),
        Lang::Ita => Some("it".into()),
        Lang::Lit => Some("lt".into()),
        Lang::Nep => Some("ne".into()),
        Lang::Nld => Some("nl".into()),
        Lang::Nob => Some("nb".into()),
        Lang::Pol => Some("pl".into()),
        Lang::Por => Some("pt".into()),
        Lang::Ron => Some("ro".into()),
        Lang::Rus => Some("ru".into()),
        Lang::Spa => Some("es".into()),
        Lang::Swe => Some("sv".into()),
        Lang::Tam => Some("ta".into()),
        Lang::Tur => Some("tr".into()),
        Lang::Yid => Some("yi".into()),
        _ => None,
    }
}

fn detect_language(text: String) -> Option<String> {
    let Some(info) = detect(&text) else {
        return None;
    };

    lang_to_code(info.lang())
}

fn stem_word(word: String, language: String) -> Result<String, Error> {
    match language.as_str() {
        "ar" => Ok(arabic(&word).to_string()),
        "ca" => Ok(catalan(&word).to_string()),
        "cs" => Ok(czech_dolamic_light(&word).to_string()),
        "da" => Ok(danish(&word).to_string()),
        "de" => Ok(german(&word).to_string()),
        "el" => Ok(greek(&word).to_string()),
        "en" => Ok(english_porter_2(&word).to_string()),
        "es" => Ok(spanish(&word).to_string()),
        "et" => Ok(estonian_freienthal(&word).to_string()),
        "fi" => Ok(finnish(&word).to_string()),
        "fr" => Ok(french(&word).to_string()),
        "hi" => Ok(hindi_lightweight(&word).to_string()),
        "hu" => Ok(hungarian(&word).to_string()),
        "hy" => Ok(armenian_mkrtchyan(&word).to_string()),
        "id" => Ok(indonesian_tala(&word).to_string()),
        "it" => Ok(italian(&word).to_string()),
        "lt" => Ok(lithuanian_jocas(&word).to_string()),
        "nb" => Ok(norwegian_bokmal(&word).to_string()),
        "ne" => Ok(nepali(&word).to_string()),
        "nl" => Ok(dutch(&word).to_string()),
        "pl" => Ok(polish_yarovoy_unaccented(&word).to_string()),
        "pt" => Ok(portuguese(&word).to_string()),
        "ro" => Ok(romanian(&word).to_string()),
        "ru" => Ok(russian(&word).to_string()),
        "sv" => Ok(swedish(&word).to_string()),
        "tr" => Ok(turkish_cilden(&word).to_string()),
        "yi" => Ok(yiddish_urieli(&word).to_string()),
        _ => Err(Error::new(
            exception::arg_error(),
            format!("Unsupported language: {language}"),
        )),
    }
}

fn is_supported_language(language: String) -> bool {
    [
        "ar", "ca", "cs", "da", "de", "el", "en", "es", "et", "fi", "fr", "hi", "hu", "hy", "id",
        "it", "lt", "nb", "ne", "nl", "pl", "pt", "ro", "ru", "sv", "tr", "yi",
    ]
    .contains(&language.as_str())
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
