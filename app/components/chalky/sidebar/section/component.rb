# frozen_string_literal: true

module Chalky
  module Sidebar
    module Section
      class Component < ViewComponent::Base
        attr_reader :css_classes, :spacing_classes

        def initialize(css_classes: "", spacing: "mb-6")
          super()
          @css_classes = css_classes
          @spacing_classes = spacing
        end

        def section_classes
          base_classes = "sidebar-section bg-white rounded-xl shadow-sm border border-gray-200 p-4 transition-shadow hover:shadow-md"
          [base_classes, spacing_classes, css_classes].compact.join(" ")
        end
      end
    end
  end
end
