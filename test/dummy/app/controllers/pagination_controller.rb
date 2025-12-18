# frozen_string_literal: true

class PaginationController < ApplicationController
  include Pagy::Backend

  User = Struct.new(:id, :name, :email, :role, :status, :created_at, keyword_init: true) do
    def model_name
      ActiveModel::Name.new(self.class, nil, "User")
    end

    def to_key
      [id]
    end
  end

  ROLES = %w[admin user moderator editor viewer].freeze
  STATUSES = %w[active inactive pending suspended].freeze
  FIRST_NAMES = %w[Alice Bob Claire David Emma Frank Grace Hugo Iris Jack Kate Leo Marie Nathan Olivia Paul Quinn Rose Sam Tom].freeze
  LAST_NAMES = %w[Martin Dupont Bernard Moreau Petit Simon Laurent Lefevre Roux Girard Bonnet Dubois Rousseau Fontaine Mercier].freeze

  def index
    all_users = generate_users(100)
    @pagy, @users = pagy_array(all_users, limit: 20)
  end

  private

  def generate_users(count)
    count.times.map do |i|
      User.new(
        id: i + 1,
        name: "#{FIRST_NAMES.sample} #{LAST_NAMES.sample}",
        email: "user#{i + 1}@example.com",
        role: ROLES.sample,
        status: STATUSES.sample,
        created_at: rand(1..365).days.ago
      )
    end
  end
end
