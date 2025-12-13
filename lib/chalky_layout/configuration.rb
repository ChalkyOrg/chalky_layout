# frozen_string_literal: true

module ChalkyLayout
  class Configuration
    attr_accessor :primary_color, :default_grid_variant, :default_dropdown_variant

    def initialize
      @primary_color = "#3b82f6"
      @default_grid_variant = :admin
      @default_dropdown_variant = :admin
    end
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def config
      configuration
    end
  end
end
