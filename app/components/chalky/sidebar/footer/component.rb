# frozen_string_literal: true

module Chalky
  module Sidebar
    module Footer
      class Component < ViewComponent::Base
        attr_reader :user_name, :user_email, :avatar_url, :role_label, :role_color,
                    :profile_path, :logout_path, :logout_method

        renders_many :menu_items, Chalky::Sidebar::MenuItem::Component

        ROLE_COLORS = {
          blue: "bg-chalky-accent-blue-light text-chalky-accent-blue-text",
          green: "bg-chalky-accent-green-light text-chalky-accent-green-text",
          purple: "bg-chalky-accent-purple-light text-chalky-accent-purple-text",
          orange: "bg-chalky-accent-orange-light text-chalky-accent-orange-text",
          red: "bg-chalky-accent-red-light text-chalky-accent-red-text",
          gray: "bg-chalky-accent-gray-light text-chalky-accent-gray-text",
          indigo: "bg-chalky-accent-indigo-light text-chalky-accent-indigo-text"
        }.freeze

        def initialize(
          user_name:,
          user_email:,
          logout_path:,
          avatar_url: nil,
          role_label: nil,
          role_color: :gray,
          profile_path: nil,
          logout_method: :delete
        )
          super()
          @user_name = user_name
          @user_email = user_email
          @avatar_url = avatar_url
          @role_label = role_label
          @role_color = role_color
          @profile_path = profile_path
          @logout_path = logout_path
          @logout_method = logout_method
        end

        def role_badge_classes
          ROLE_COLORS[role_color] || ROLE_COLORS[:gray]
        end

        def show_role_badge?
          role_label.present?
        end

        def show_menu_items?
          menu_items.any?
        end

        def settings_menu_classes
          "sidebar-menu-item group flex items-center gap-x-3 rounded-lg p-2.5 text-sm font-medium " \
            "text-chalky-text-secondary hover:bg-chalky-surface-hover hover:text-chalky-text-primary transition-all duration-150"
        end

        def logout_menu_classes
          "sidebar-menu-item sidebar-footer-logout group flex items-center gap-x-3 rounded-lg p-2.5 text-sm font-medium " \
            "text-chalky-text-secondary hover:bg-chalky-danger-light hover:text-chalky-danger transition-all duration-150"
        end

        def icon_container_classes
          "sidebar-menu-icon flex-shrink-0 w-5 h-5 flex items-center justify-center text-chalky-text-muted group-hover:text-chalky-text-secondary"
        end

        def logout_icon_container_classes
          "sidebar-menu-icon flex-shrink-0 w-5 h-5 flex items-center justify-center text-chalky-text-muted group-hover:text-chalky-danger"
        end

        def avatar_initials
          return "" if user_name.blank?

          user_name.split.map { |n| n[0] }.join.upcase[0, 2]
        end
      end
    end
  end
end
