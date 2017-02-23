# Simple Form Language Input

Simple Form input component for displaying a localised <select> of languages using the ISO 369 standard or your own custom data source.

Uses: https://github.com/kasparsj/rails_language_select

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_form_language_input'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_form_language_input

## Usage

Simple usage:

```ruby
= f.input :language_code, as: :language
```

Supplying priority countries to be placed at the top of the list:

```ruby
f.input :language_code, as: :language, priority_countries: ["EN", "FR", "DE"]
```

Supplying only certain languages:

```ruby
f.input :language_code, as: :language, only: ["EN", "FR", "DR"]
```

Discarding certain languages:

```ruby
f.input :language_code, as: :language, except: ["EN", "FR", "DE"]
```

Pre-selecting a particular language:

```ruby
f.input :language_code, as: :language, selected: "EN"
```

Using existing `select` options:
```ruby
f.input :language_code, as: :language, include_blank: true
f.input :language_code, as: :language, include_blank: 'Select a language', input_html: { class: 'language-select-box' })
```

Supplying additional html options:

```ruby
f.input :language_code, as: :language, priority_languages: ["EN", "FR"], selected: "EN", input_html: { class: 'form-control', data: { attribute: "value" } })

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

