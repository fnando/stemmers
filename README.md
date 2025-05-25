# Stemmers

Rust bindings for https://whatlang.org and
https://github.com/testuj-to/tantivy-stemmers for language detection and
stemming.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add stemmers
```

If bundler is not being used to manage dependencies, install the gem by
executing:

```bash
gem install stemmers
```

## Usage

The language detection works in the context of the supported stemmers. If
language doesn't have a stemmer, then it'll return `nil`.

```ruby
require "stemmers"

Stemmers.detect_language("Hello there!")
#=> "en"

Stemmers.detect_language("Olá, mundo!")
#=> "pt"
```

To stem a word, you can use the `Stemmers.stem_word(word, language:)` method.

```ruby
require "stemmers"

Stemmers.stem_word("running", language: "en")
#=> "run"

Stemmers.stem_word("correndo", language: "pt")
#=> "corr"
```

To stem a phrase, you can use `Stemmers.stem(input, language:)`.

```ruby
require "stemmers"

Stemmers.stem("Testing this phrase", language: "en")
#=> ["test", "this", "phrase"]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake test` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and the created tag, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/fnando/stemmers. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the
[code of conduct](https://github.com/fnando/stemmers/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Stemmers project's codebases, issue trackers, chat
rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/fnando/stemmers/blob/main/CODE_OF_CONDUCT.md).
