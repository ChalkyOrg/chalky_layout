# frozen_string_literal: true

class FormDemo < ApplicationRecord
  # Validations for testing error states
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :bio, length: { maximum: 500 }
  validates :age, numericality: { greater_than: 0, less_than: 150 }, allow_nil: true
  validates :salary, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :terms_accepted, acceptance: { accept: true }, on: :create

  # Available options for select/radio/checkboxes
  COUNTRIES = %w[France USA UK Germany Spain Italy Japan Canada Australia Brazil].freeze
  ROLES = %w[Admin Editor Viewer Guest].freeze
  INTERESTS = %w[Technology Sports Music Art Travel Food Gaming Reading].freeze

  # Accessor for virtual attribute (multi-select demo)
  attr_accessor :preferred_countries
end
