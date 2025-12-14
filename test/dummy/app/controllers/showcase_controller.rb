# frozen_string_literal: true

require "ostruct"

class ShowcaseController < ApplicationController
  def index
    @users = [
      OpenStruct.new(id: 1, name: "Alice Martin", email: "alice@example.com", role: "admin", active: true, created_at: 3.days.ago),
      OpenStruct.new(id: 2, name: "Bob Dupont", email: "bob@example.com", role: "user", active: true, created_at: 1.week.ago),
      OpenStruct.new(id: 3, name: "Claire Bernard", email: "claire@example.com", role: "moderator", active: false, created_at: 2.weeks.ago)
    ]
  end
end
