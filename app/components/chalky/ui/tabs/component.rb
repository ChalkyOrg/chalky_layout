# frozen_string_literal: true

module Chalky::Ui
  module Tabs
    class Component < ViewComponent::Base
      # @param tabs [Array<Hash>] Array of tab definitions
      #   - :name [String] Tab label (required)
      #   - :path [String] Tab URL or anchor (required)
      #   - :icon [String] Optional Font Awesome icon class
      #   - :badge [Integer] Optional badge count
      #   - :active_param [String] Query param name for active detection
      #   - :active_value [String] Query param value for active detection
      #   - :default [Boolean] Set to true to make this anchor tab active by default
      def initialize(tabs:)
        super()
        @tabs = tabs
      end

      attr_reader :tabs

      # Check if any tab uses anchors (enables Stimulus controller)
      def has_anchor_tabs?
        tabs.any? { |tab| anchor_tab?(tab) }
      end

      # Container data attributes
      def container_data
        return {} unless has_anchor_tabs?

        {
          controller: "tabs",
          tabs_active_class: "active"
        }
      end

      private

      def anchor_tab?(tab)
        tab[:path].to_s.start_with?("#")
      end

      def tab_active?(tab)
        if anchor_tab?(tab)
          # For anchors: first tab or one marked as default is active
          tab[:default] || (!tabs.any? { |t| t[:default] } && tab == tabs.find { |t| anchor_tab?(t) })
        elsif tab[:active_value]
          param_value = request.params[tab[:active_param]]
          tab[:active_value] == param_value
        else
          tab[:path] == request.path
        end
      end

      def tab_classes(tab)
        base_classes = "flex items-center gap-2 px-3 py-2 text-xs md:text-base font-medium transition-colors"
        state_classes = tab_active?(tab) ? active_tab_classes : inactive_tab_classes
        "#{base_classes} #{state_classes}"
      end

      def active_tab_classes
        "bg-chalky-surface-secondary rounded-t-lg text-chalky-text-primary border-t border-l border-r border-chalky-border -mb-px relative z-10"
      end

      def inactive_tab_classes
        "text-chalky-text-secondary hover:text-chalky-text-primary hover:bg-chalky-surface-hover rounded-t-lg"
      end

      def tab_data(tab)
        return {} unless anchor_tab?(tab)

        {
          action: "click->tabs#switch",
          tabs_target: "tab",
          tab_id: tab[:path].delete("#")
        }
      end

      def tab_href(tab)
        anchor_tab?(tab) ? "#" : tab[:path]
      end

      def tab_anchor_id(tab)
        tab[:path].delete("#") if anchor_tab?(tab)
      end
    end
  end
end
