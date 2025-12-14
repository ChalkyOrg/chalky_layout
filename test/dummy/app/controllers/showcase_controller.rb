# frozen_string_literal: true

class ShowcaseController < ApplicationController
  User = Struct.new(:id, :name, :email, :role, :active, :created_at, keyword_init: true) do
    def model_name
      ActiveModel::Name.new(self.class, nil, "User")
    end

    def to_key
      [id]
    end
  end

  def index
    @users = [
      User.new(id: 1, name: "Alice Martin", email: "alice@example.com", role: "admin", active: true, created_at: 3.days.ago),
      User.new(id: 2, name: "Bob Dupont", email: "bob@example.com", role: "user", active: true, created_at: 1.week.ago),
      User.new(id: 3, name: "Claire Bernard", email: "claire@example.com", role: "moderator", active: false, created_at: 2.weeks.ago)
    ]
  end
end
