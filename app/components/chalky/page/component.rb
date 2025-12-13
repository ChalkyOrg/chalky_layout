# frozen_string_literal: true

module Chalky::Page
  class Component < Chalky::ApplicationComponent
    # Clean slot API:
    # - page.with_header(title: ...) - title bar with actions
    # - page.with_body - main content area
    renders_one :header, Chalky::Page::Header::Component
    renders_one :body, lambda { |full_width: false, **options|
      Chalky::Page::Body::Component.new(full_width:, **options)
    }

    attr_reader :title, :subtitle, :css_classes, :data_attributes

    def initialize(title: nil, subtitle: nil, css_classes: "", data_attributes: {})
      super()
      @title = title
      @subtitle = subtitle
      @css_classes = css_classes
      @data_attributes = data_attributes
    end
  end
end
