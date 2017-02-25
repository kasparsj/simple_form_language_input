# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_form_language_input/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_form_language_input"
  spec.version       = SimpleFormLanguageInput::VERSION
  spec.authors       = ["Kaspars"]
  spec.email         = ["kasparsj@gmail.com"]

  spec.summary       = "Simple Form input component for displaying a localised <select> of languages"
  spec.description   = "Simple Form input component for displaying a localised <select> of languages using the ISO 369 standard or your own custom data source."
  spec.homepage      = "https://github.com/kasparsj/simple_form_language_input"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-rails", "~> 3.5"
  spec.add_development_dependency 'pry', '~> 0'
  spec.add_development_dependency 'pry-nav'

  spec.add_dependency "simple_form"
  spec.add_dependency "rails_language_select"
end
