# frozen_string_literal: true

module Chalky
  module Sidebar
    module MenuItem
      class Component < ViewComponent::Base
        attr_reader :path, :title, :icon_classes, :icon_path, :active_override

        def initialize(path:, title:, icon_classes: nil, icon_path: nil, active: nil)
          super()
          @path = path
          @title = title
          @icon_classes = icon_classes
          @icon_path = icon_path
          @active_override = active
        end

        def active?
          return active_override unless active_override.nil?

          request.path == path
        end

        def link_classes
          base_classes = "sidebar-menu-item group flex items-center gap-x-3 rounded-lg p-2.5 text-sm " \
                         "font-medium transition-all duration-150"

          state_classes = if active?
                            "bg-chalky-primary-light text-chalky-primary-text shadow-sm"
                          else
                            "text-chalky-text-secondary hover:bg-chalky-surface-hover hover:text-chalky-text-primary"
                          end

          [base_classes, state_classes].join(" ")
        end

        def icon_container_classes
          base_classes = "sidebar-menu-icon flex-shrink-0 w-5 h-5 flex items-center justify-center"

          if active?
            "#{base_classes} text-chalky-primary"
          else
            "#{base_classes} text-chalky-text-muted group-hover:text-chalky-text-secondary"
          end
        end

        def use_svg_icon?
          icon_path.present? && icon_classes.blank?
        end
      end
    end
  end
end
