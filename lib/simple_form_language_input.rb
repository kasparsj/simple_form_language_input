require 'simple_form'
require 'rails_language_select'

require "simple_form_language_input/version"

module SimpleForm
  # Default priority for language inputs.
  mattr_accessor :language_priority
  @@language_priority = nil

  module Inputs
    class LanguageInput < PriorityInput
      def input_type
        :language
      end
      def input_priority
        input_priority = super
        input_priority.call if input_priority.try(:lambda?) === true
      end
    end
  end
end
