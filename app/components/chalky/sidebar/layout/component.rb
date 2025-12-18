# frozen_string_literal: true

module Chalky
  module Sidebar
    module Layout
      class Component < ViewComponent::Base
        # Header slot - typically logo/branding
        renders_one :header

        # Navigation sections with menu items
        # Lambda allows passing arguments to Section::Component constructor
        renders_many :sections, lambda { |title:, icon_path:, description: nil, icon_color: :blue, **options|
          Chalky::Sidebar::Section::Component.new(
            title: title,
            icon_path: icon_path,
            description: description,
            icon_color: icon_color,
            **options
          )
        }

        # Footer slot with user profile
        # Lambda allows passing arguments to Footer::Component constructor
        renders_one :footer, lambda { |user_name:, user_email:, logout_path:, **options|
          Chalky::Sidebar::Footer::Component.new(
            user_name: user_name,
            user_email: user_email,
            logout_path: logout_path,
            **options
          )
        }

        attr_reader :menu_title

        def initialize(menu_title: "Menu")
          super()
          @menu_title = menu_title
        end
      end
    end
  end
end
