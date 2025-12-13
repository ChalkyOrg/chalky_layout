# frozen_string_literal: true

module Chalky::Grid
  module Label
    class Component < Chalky::ApplicationComponent
      ICONS = {
        text: "text",
        number: "hashtag",
        date: "calendar-day",
        datetime: "calendar-day",
        date_time_range: "calendar-day",
        string: "text",
        select: "chevron-circle-down",
        boolean: "check-square",
        files: "file",
        link: "file",
        references: "ballot-check",
        users: "user-friends",
        formula: "function",
        lookups: "search",
        created_at: "calendar-plus",
        last_modified_at: "calendar-edit",
        created_by: "user-plus",
        last_modified_by: "user-edit",
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
      def error_class = error ? "!text-red-600" : ""
      def display_required? = data_required
      def display_sync? = data_sync
      def computed_value? = computed_value
    end
  end
end
