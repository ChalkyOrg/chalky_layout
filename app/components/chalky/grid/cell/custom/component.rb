# frozen_string_literal: true

module Chalky::Grid
  module Cell
    module Custom
      class Component < Chalky::ApplicationComponent
        attr_reader :html_content

        def initialize(html_content:)
          super()
          @html_content = html_content
        end
      end
    end
  end
end
