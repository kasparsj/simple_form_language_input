require "spec_helper"

require 'action_view'

require 'simple_form'
require 'simple_form_language_input'

RSpec.describe SimpleFormLanguageInput do
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormOptionsHelper
  include SimpleForm::ActionViewExtensions::FormHelper

  class Walrus
    attr_accessor :language_code
  end

  let(:walrus) { Walrus.new }
  let!(:template) { ActionView::Base.new }

  let(:builder) do
    SimpleForm::FormBuilder.new(:walrus, walrus, template, {})
  end

  it "selects the value of language_code" do
    tag = options_for_select([['English', 'EN']], 'EN')

    walrus.language_code = 'EN'
    t = builder.input :language_code, as: :language
    expect(t).to include(tag)
  end

  it "uses the locale specified by I18n.locale" do
    I18n.available_locales = [:en, :es]

    tag = options_for_select([['Inglés', 'EN']], 'EN')

    walrus.language_code = 'EN'
    original_locale = I18n.locale
    begin
      I18n.locale = :es
      t = builder.input :language_code, as: :language
      expect(t).to include(tag)
    ensure
      I18n.locale = original_locale
    end
  end

  it "accepts a locale option" do
    I18n.available_locales = [:en, :fr]

    tag = options_for_select([['anglais', 'EN']], 'EN')

    walrus.language_code = 'EN'
    t = builder.input :language_code, as: :language, locale: :fr
    expect(t).to include(tag)
  end

  it "accepts priority languages" do
    tag = options_for_select(
        [
            ['Latvian','LV'],
            ['English','EN'],
            ['Danish', 'DA'],
            ['-'*15,'-'*15]
        ],
        selected: 'EN',
        disabled: '-'*15
    )

    walrus.language_code = 'EN'
    t = builder.input :language_code, as: :language, priority: ['LV','EN','DA']
    expect(t).to include(tag)
  end

  describe "when selected options is not an array" do
    it "selects only the first matching option" do
      tag = options_for_select([["English", "EN"],["Uruguay", "UY"]], "EN")
      walrus.language_code = 'EN'
      t = builder.input :language_code, as: :language, priority: ['LV','EN']
      expect(t).to_not include(tag)
    end
  end

  describe "when selected options is an array" do
    it "selects all options but only once" do
      walrus.language_code = 'en'
      t = builder.input :language_code, as: :language, priority: ['LV','EN','ES'], selected: ['ZU', 'EN'], multiple: true
      expect(t.scan(options_for_select([["English", "EN"]], "EN")).length).to be(1)
      expect(t.scan(options_for_select([["Zulu", "ZU"]], "ZU")).length).to be(1)
    end
  end

  it "displays only the chosen languages" do
    options = [["Danish", "DA"],["German", "DE"]]
    tag = builder.select(:language_code, options, {}, {class: 'language required'})
    walrus.language_code = 'en'
    t = builder.input :language_code, as: :language, only: ['DA','DE'], include_blank: false
    expect(t).to include(tag)
  end

  it "discards some languages" do
    tag = options_for_select([["English", "EN"]])
    walrus.language_code = 'de'
    t = builder.input :language_code, as: :language, except: ['EN']
    expect(t).to_not include(tag)
  end

  it 'sorts unicode' do
    tag = builder.input :language_code, as: :language, only: ['BG', 'CA', 'CH', 'ZU']
    order = tag.scan(/value="(\w{2})"/).map { |o| o[0] }
    expect(order).to eq(['BG', 'CA', 'CH', 'ZU'])
  end

  describe "custom formats" do
    it "accepts a custom formatter" do
      ::RailsLanguageSelect::FORMATS[:with_code] = lambda do |language, code|
        "#{language} (#{code})"
      end

      tag = options_for_select([['English (EN)', 'EN']], 'EN')

      walrus.language_code = 'EN'
      t = builder.input :language_code, as: :language, format: :with_code
      expect(t).to include(tag)
    end
  end

  describe "custom data source" do
    it "accepts a custom data source" do
      ::RailsLanguageSelect::DATA_SOURCE[:custom_data] = lambda do |code_or_name = nil|
        custom_data = {yay: "YAY!", wii: 'Yippii!'}
        if code_or_name.nil?
          custom_data.keys
        else
          if (language = custom_data[code_or_name])
            code = code_or_name
          elsif (code = custom_data.key(code_or_name))
            language = code_or_name
          end
          return language, code
        end
      end

      tag = options_for_select([['YAY!', 'yay'], ['Yippii!', 'wii']], 'wii')
      walrus.language_code = 'wii'
      t = builder.input :language_code, as: :language, data_source: :custom_data
      expect(t).to include(tag)
    end
  end
end
