# frozen_string_literal: true

module Chalky::Grid
  module Label
    class Component < Chalky::ApplicationComponent
      # Icons available in Font Awesome 6 Free (solid)
      # Note: :text and :string are intentionally excluded to keep text columns clean
      ICONS = {
        number: "hashtag",
        date: "calendar",
        datetime: "calendar",
        date_time_range: "calendar",
        select: "circle-chevron-down",
        boolean: "square-check",
        files: "file",
        link: "link",
        references: "list-check",
        users: "user-group",
        formula: "calculator",
        lookups: "magnifying-glass",
        created_at: "calendar-plus",
        last_modified_at: "pen",
        created_by: "user-plus",
        last_modified_by: "user-pen",
        image: "image",
        status_icon: "circle",
        price_range: "dollar-sign"
      }.freeze

      attr_reader :label, :data_type, :icon, :data_required, :error, :data_sync, :computed_value

      def initialize(label:,
                     data_type: nil,
                     icon: nil,
                     data_required: false,
                     error: false,
                     data_sync: false,
                     computed_value: false)
        super()
        @label = label
        @data_type = data_type
        @icon = icon
        @data_required = data_required
        @error = error
        @data_sync = data_sync
        @computed_value = computed_value
      end

      def icon_class = icon ? "fa-#{icon}" : "fa-#{ICONS[data_type]}"
      def has_icon? = icon.present? || ICONS.key?(data_type)
      def error_class = error ? "!text-red-600" : ""
      def display_required? = data_required
      def display_sync? = data_sync
      def computed_value? = computed_value
    end
  end
end
