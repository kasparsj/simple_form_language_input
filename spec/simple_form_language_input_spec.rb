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
end
