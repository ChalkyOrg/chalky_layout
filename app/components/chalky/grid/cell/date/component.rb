# frozen_string_literal: true

module Chalky::Grid
  module Cell
    module Date
      class Component < Chalky::ApplicationComponent
        attr_reader :data, :formatted_as

        def initialize(data:, formatted_as: :default)
          super()
          @data = data
          @formatted_as = formatted_as
        end

        def render?
          data.present?
        end

        def formatted_date
          return "" unless data

          case formatted_as
          when :short
            I18n.l(data, format: :short)
          when :long
            I18n.l(data, format: :long)
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
