# frozen_string_literal: true

module Chalky
  module Pagination
    class Component < ViewComponent::Base
      attr_reader :pagy, :url_builder

      # @param pagy [Pagy] The Pagy object containing pagination info
      # @param url_builder [Proc] Optional proc to build URLs, receives page number
      def initialize(pagy:, url_builder: nil)
        super()
        @pagy = pagy
        @url_builder = url_builder || ->(page) { "?page=#{page}" }
      end

      def render?
        pagy.present? && pagy.pages > 1
      end

      def page_url(page)
        url_builder.call(page)
      end

      def pages_to_show
        build_page_series
      end

      def info_text
        from = pagy.from || 1
        to = pagy.to || pagy.count
        "#{from}-#{to} sur #{pagy.count}"
      end

      def page_info_text
        "Page #{pagy.page} sur #{pagy.pages}"
      end

      private

      def build_page_series
        series = []
        window = 2 # Pages around current page

        # Always show first page
        series << 1

        # Gap after first?
        if pagy.page > (window + 2)
          series << :gap
        end

        # Pages around current
        start_page = [pagy.page - window, 2].max
        end_page = [pagy.page + window, pagy.pages - 1].min

        (start_page..end_page).each do |page|
          series << page unless series.include?(page)
        end

        # Gap before last?
        if pagy.page < (pagy.pages - window - 1)
          series << :gap
        end

        # Always show last page
        series << pagy.pages unless series.include?(pagy.pages)

        series
      end

      def nav_button_classes(enabled:)
        base = "relative inline-flex items-center px-3 py-2 text-sm font-medium rounded-md transition-colors"
        if enabled
          "#{base} text-chalky-text-secondary bg-chalky-surface border border-chalky-border-strong hover:bg-chalky-surface-hover"
        else
          "#{base} text-chalky-text-muted bg-chalky-surface-tertiary border border-chalky-border cursor-not-allowed"
        end
      end

      def page_button_classes(current:)
        base = "relative inline-flex items-center px-4 py-2 text-sm font-medium rounded-md transition-colors"
        if current
          "#{base} text-chalky-text-inverted bg-chalky-primary border border-chalky-primary"
        else
          "#{base} text-chalky-text-secondary bg-chalky-surface border border-chalky-border-strong hover:bg-chalky-surface-hover"
        end
      end

      def gap_classes
        "relative inline-flex items-center px-4 py-2 text-sm font-medium text-chalky-text-tertiary"
      end
    end
  end
end
