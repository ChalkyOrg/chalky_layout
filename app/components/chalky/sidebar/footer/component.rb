# frozen_string_literal: true

module Chalky
  module Sidebar
    module Footer
      class Component < ViewComponent::Base
        attr_reader :user_name, :user_email, :avatar_url, :role_label, :role_color,
                    :profile_path, :logout_path, :logout_method

        renders_many :menu_items, Chalky::Sidebar::MenuItem::Component

        ROLE_COLORS = {
          blue: "bg-blue-100 text-blue-600",
          green: "bg-green-100 text-green-600",
          purple: "bg-purple-100 text-purple-600",
          orange: "bg-orange-100 text-orange-600",
          red: "bg-red-100 text-red-600",
          gray: "bg-gray-100 text-gray-600",
          indigo: "bg-indigo-100 text-indigo-600"
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
            "text-gray-700 hover:bg-gray-50 hover:text-gray-900 transition-all duration-150"
        end

        def logout_menu_classes
          "sidebar-menu-item sidebar-footer-logout group flex items-center gap-x-3 rounded-lg p-2.5 text-sm font-medium " \
            "text-gray-700 hover:bg-red-50 hover:text-red-700 transition-all duration-150"
        end

        def icon_container_classes
          "sidebar-menu-icon flex-shrink-0 w-5 h-5 flex items-center justify-center text-gray-400 group-hover:text-gray-600"
        end

        def logout_icon_container_classes
          "sidebar-menu-icon flex-shrink-0 w-5 h-5 flex items-center justify-center text-gray-400 group-hover:text-red-600"
        end

        def avatar_initials
          return "" if user_name.blank?

          user_name.split.map { |n| n[0] }.join.upcase[0, 2]
        end
      end
    end
  end
end
