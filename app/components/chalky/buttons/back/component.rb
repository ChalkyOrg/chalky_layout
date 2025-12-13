# frozen_string_literal: true

module Chalky::Buttons
  module Back
    class Component < Chalky::ApplicationComponent
      attr_reader :label, :icon, :fallback_url

      def initialize(label: nil, icon: "fa-solid fa-arrow-left", fallback_url: "/")
        super
        @label = label || I18n.t("common.actions.back", default: "Back")
        @icon = icon
        @fallback_url = fallback_url
      end

      def link_data_attributes
        {
          controller: "back",
          action: "click->back#goBack",
          back_fallback_url_value: fallback_url
        }
      end
    end
  end
end
