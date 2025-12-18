# frozen_string_literal: true

module Chalky
  module Sidebar
    module Container
      class Component < ViewComponent::Base
        attr_reader :css_classes, :data_attributes

        def initialize(css_classes: "", data_attributes: {})
          super()
          @css_classes = css_classes
          @data_attributes = data_attributes
        end

        def container_classes
          base_classes = "sidebar-container flex flex-col h-full bg-white p-4"
          [base_classes, css_classes].compact.join(" ")
        end

        def container_data
          {
            controller: "chalky-sidebar",
            chalky_sidebar_storage_key_value: "chalky_sidebar_collapsed"
          }.merge(data_attributes)
        end
      end
    end
  end
end
