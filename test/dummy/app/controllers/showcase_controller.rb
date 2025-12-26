# frozen_string_literal: true

class ShowcaseController < ApplicationController
  include Pagy::Backend

  User = Struct.new(:id, :name, :email, :role, :active, :created_at, :phone, :address, :city, :country, :updated_at, keyword_init: true) do
    def model_name
      ActiveModel::Name.new(self.class, nil, "User")
    end

    def to_key
      [id]
    end
  end

  before_action :set_users

  def index
  end

  def feedback
  end

  def navigation
  end

  def layout
  end

  def buttons
  end

  def data
    all_users = generate_users(100)
    @pagy, @paginated_users = pagy_array(all_users, limit: 10)
  end

  def simple_form
    @form_demo = FormDemo.new
  end

  def create_form_demo
    @form_demo = FormDemo.new(form_demo_params)

    if @form_demo.save
      flash[:success] = "Form submitted successfully!"
      redirect_to simple_form_path
    else
      flash.now[:error] = "Please fix the errors below."
      render :simple_form, status: :unprocessable_entity
    end
  end

  private

  def form_demo_params
    params.require(:form_demo).permit(
      :name, :email, :password_digest, :bio, :age, :salary,
      :country, :role, :terms_accepted, :newsletter,
      :birth_date, :appointment, :avatar, interests: []
    )
  end

  def set_users
    @users = [
      User.new(id: 1, name: "Alice Martin", email: "alice@example.com", role: "admin", active: true, created_at: 3.days.ago, phone: "+33 6 12 34 56 78", address: "123 Rue de la Paix", city: "Paris", country: "France", updated_at: 1.day.ago),
      User.new(id: 2, name: "Bob Dupont", email: "bob@example.com", role: "user", active: true, created_at: 1.week.ago, phone: "+33 6 98 76 54 32", address: "456 Avenue des Champs", city: "Lyon", country: "France", updated_at: 2.days.ago),
      User.new(id: 3, name: "Claire Bernard", email: "claire@example.com", role: "moderator", active: false, created_at: 2.weeks.ago, phone: "+33 6 11 22 33 44", address: "789 Boulevard Central", city: "Marseille", country: "France", updated_at: 5.days.ago)
    ]
  end

  def generate_users(count)
    first_names = %w[Alice Bob Claire David Emma François Gabrielle Hugo Isabelle Jules]
    last_names = %w[Martin Dupont Bernard Petit Moreau Garcia Roux Fournier Girard Andre]
    roles = %w[admin user moderator editor viewer]
    cities = %w[Paris Lyon Marseille Toulouse Bordeaux Nantes Nice Strasbourg Montpellier Lille]

    count.times.map do |i|
      User.new(
        id: i + 1,
        name: "#{first_names.sample} #{last_names.sample}",
        email: "user#{i + 1}@example.com",
        role: roles.sample,
        active: [true, true, true, false].sample,
        created_at: rand(1..90).days.ago,
        phone: "+33 6 #{rand(10..99)} #{rand(10..99)} #{rand(10..99)} #{rand(10..99)}",
        address: "#{rand(1..999)} Rue #{last_names.sample}",
        city: cities.sample,
        country: "France",
        updated_at: rand(1..30).days.ago
      )
    end
  end
end
