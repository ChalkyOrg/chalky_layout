# frozen_string_literal: true

module Chalky::Grid
  module Cell
    module Datetime
      class Component < Chalky::ApplicationComponent
        attr_reader :data, :formatted_as

        def initialize(data:, formatted_as: :with_time)
          super()
          @data = data
          @formatted_as = formatted_as
        end

        def render?
          data.present?
        end

        def formatted_datetime
          return "" unless data

          case formatted_as
          when :with_time
            I18n.l(data, format: :short)
          when :relative
            time_ago_in_words(data)
          else
            I18n.l(data, format: :default)
          end
        rescue StandardError
          data.to_s
        end
      end
    end
  end
end
