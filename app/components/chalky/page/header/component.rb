# frozen_string_literal: true

module Chalky::Page
  module Header
    class Component < ViewComponent::Base
      renders_one :navigation
      renders_one :actions, Chalky::Page::Actions::Component

      attr_reader :title, :subtitle, :spacing_classes, :show_backlink, :backlink_fallback_url

      def initialize(title: nil, subtitle: nil, spacing: "mb-0", backlink: true, backlink_fallback_url: "/")
        super()
        @title = title
        @subtitle = subtitle
        @spacing_classes = spacing
        @show_backlink = backlink
        @backlink_fallback_url = backlink_fallback_url
      end

      def bar_classes
        base_classes = "bg-chalky-surface sticky top-0 z-40"
        border_classes = navigation? ? "" : "border-b border-chalky-border"
        [base_classes, border_classes, spacing_classes].compact.join(" ")
      end

      def show_title?
        title.present?
      end

      def show_subtitle?
        subtitle.present?
      end

      def navigation?
        navigation.present?
      end

      def actions?
        actions.present?
      end

      def backlink?
        show_backlink
      end
    end
  end
end
