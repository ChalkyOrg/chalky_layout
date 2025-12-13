# frozen_string_literal: true

require_relative "chalky_layout/version"
require_relative "chalky_layout/configuration"
require_relative "chalky_layout/engine" if defined?(Rails::Engine)

module ChalkyLayout
  class Error < StandardError; end
end
