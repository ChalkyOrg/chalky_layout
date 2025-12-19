# frozen_string_literal: true

class ShowcaseController < ApplicationController
  User = Struct.new(:id, :name, :email, :role, :active, :created_at, :phone, :address, :city, :country, :updated_at, keyword_init: true) do
    def model_name
      ActiveModel::Name.new(self.class, nil, "User")
    end

    def to_key
      [id]
    end
  end

  def index
    @users = [
      User.new(id: 1, name: "Alice Martin", email: "alice@example.com", role: "admin", active: true, created_at: 3.days.ago, phone: "+33 6 12 34 56 78", address: "123 Rue de la Paix", city: "Paris", country: "France", updated_at: 1.day.ago),
      User.new(id: 2, name: "Bob Dupont", email: "bob@example.com", role: "user", active: true, created_at: 1.week.ago, phone: "+33 6 98 76 54 32", address: "456 Avenue des Champs", city: "Lyon", country: "France", updated_at: 2.days.ago),
      User.new(id: 3, name: "Claire Bernard", email: "claire@example.com", role: "moderator", active: false, created_at: 2.weeks.ago, phone: "+33 6 11 22 33 44", address: "789 Boulevard Central", city: "Marseille", country: "France", updated_at: 5.days.ago)
    ]
  end
end
