# frozen_string_literal: true

# Pagy initializer - only load if pagy is available
begin
  require "pagy/extras/array"
rescue LoadError
  # pagy not available, skip
end
