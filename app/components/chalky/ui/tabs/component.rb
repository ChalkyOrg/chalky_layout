# frozen_string_literal: true

module Chalky::Ui
  module Tabs
    class Component < ViewComponent::Base
      # @param tabs [Array<Hash>] Array of tab definitions
      #   - :name [String] Tab label (required)
      #   - :path [String] Tab URL (required)
      #   - :icon [String] Optional Font Awesome icon class
      #   - :badge [Integer] Optional badge count
      #   - :active_param [String] Query param name for active detection
      #   - :active_value [String] Query param value for active detection
      def initialize(tabs:)
        super()
        @tabs = tabs
      end

      attr_reader :tabs

      private

      def tab_active?(tab)
        if tab[:active_value]
          param_value = request.params[tab[:active_param]]
          tab[:active_value] == param_value
        else
          tab[:path] == request.path
        end
      end

      def tab_classes(tab)
        base_classes = "flex items-center gap-2 px-3 py-2 text-xs md:text-base font-medium"
        state_classes = tab_active?(tab) ? active_tab_classes : inactive_tab_classes
        "#{base_classes} #{state_classes}"
      end

      def active_tab_classes
        # bg-light matches the page body background for visual continuity
        "bg-light rounded-t-lg text-gray-900 border-t border-l border-r border-gray-200 -mb-px relative z-10"
      end

      def inactive_tab_classes
        "text-gray-600 hover:text-gray-900 hover:bg-gray-50 rounded-t-lg"
      end
    end
  end
end
