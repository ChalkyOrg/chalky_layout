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

  def ajax_select
    @form_demo = FormDemo.new
  end

  def search_countries
    query = params[:q].to_s.downcase
    countries = all_countries.select { |c| c[:text].downcase.include?(query) }
    render json: countries.first(50)
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

  def all_countries
    [
      { value: "AF", text: "Afghanistan" }, { value: "AL", text: "Albanie" }, { value: "DZ", text: "Algérie" },
      { value: "DE", text: "Allemagne" }, { value: "AD", text: "Andorre" }, { value: "AO", text: "Angola" },
      { value: "AR", text: "Argentine" }, { value: "AM", text: "Arménie" }, { value: "AU", text: "Australie" },
      { value: "AT", text: "Autriche" }, { value: "AZ", text: "Azerbaïdjan" }, { value: "BS", text: "Bahamas" },
      { value: "BH", text: "Bahreïn" }, { value: "BD", text: "Bangladesh" }, { value: "BE", text: "Belgique" },
      { value: "BZ", text: "Belize" }, { value: "BJ", text: "Bénin" }, { value: "BT", text: "Bhoutan" },
      { value: "BY", text: "Biélorussie" }, { value: "BO", text: "Bolivie" }, { value: "BA", text: "Bosnie-Herzégovine" },
      { value: "BW", text: "Botswana" }, { value: "BR", text: "Brésil" }, { value: "BN", text: "Brunei" },
      { value: "BG", text: "Bulgarie" }, { value: "BF", text: "Burkina Faso" }, { value: "BI", text: "Burundi" },
      { value: "KH", text: "Cambodge" }, { value: "CM", text: "Cameroun" }, { value: "CA", text: "Canada" },
      { value: "CV", text: "Cap-Vert" }, { value: "CF", text: "Centrafrique" }, { value: "CL", text: "Chili" },
      { value: "CN", text: "Chine" }, { value: "CY", text: "Chypre" }, { value: "CO", text: "Colombie" },
      { value: "KM", text: "Comores" }, { value: "CG", text: "Congo" }, { value: "KR", text: "Corée du Sud" },
      { value: "KP", text: "Corée du Nord" }, { value: "CR", text: "Costa Rica" }, { value: "CI", text: "Côte d'Ivoire" },
      { value: "HR", text: "Croatie" }, { value: "CU", text: "Cuba" }, { value: "DK", text: "Danemark" },
      { value: "DJ", text: "Djibouti" }, { value: "DM", text: "Dominique" }, { value: "EG", text: "Égypte" },
      { value: "AE", text: "Émirats arabes unis" }, { value: "EC", text: "Équateur" }, { value: "ER", text: "Érythrée" },
      { value: "ES", text: "Espagne" }, { value: "EE", text: "Estonie" }, { value: "US", text: "États-Unis" },
      { value: "ET", text: "Éthiopie" }, { value: "FJ", text: "Fidji" }, { value: "FI", text: "Finlande" },
      { value: "FR", text: "France" }, { value: "GA", text: "Gabon" }, { value: "GM", text: "Gambie" },
      { value: "GE", text: "Géorgie" }, { value: "GH", text: "Ghana" }, { value: "GR", text: "Grèce" },
      { value: "GD", text: "Grenade" }, { value: "GT", text: "Guatemala" }, { value: "GN", text: "Guinée" },
      { value: "GW", text: "Guinée-Bissau" }, { value: "GQ", text: "Guinée équatoriale" }, { value: "GY", text: "Guyana" },
      { value: "HT", text: "Haïti" }, { value: "HN", text: "Honduras" }, { value: "HU", text: "Hongrie" },
      { value: "IN", text: "Inde" }, { value: "ID", text: "Indonésie" }, { value: "IQ", text: "Irak" },
      { value: "IR", text: "Iran" }, { value: "IE", text: "Irlande" }, { value: "IS", text: "Islande" },
      { value: "IL", text: "Israël" }, { value: "IT", text: "Italie" }, { value: "JM", text: "Jamaïque" },
      { value: "JP", text: "Japon" }, { value: "JO", text: "Jordanie" }, { value: "KZ", text: "Kazakhstan" },
      { value: "KE", text: "Kenya" }, { value: "KG", text: "Kirghizistan" }, { value: "KI", text: "Kiribati" },
      { value: "KW", text: "Koweït" }, { value: "LA", text: "Laos" }, { value: "LS", text: "Lesotho" },
      { value: "LV", text: "Lettonie" }, { value: "LB", text: "Liban" }, { value: "LR", text: "Liberia" },
      { value: "LY", text: "Libye" }, { value: "LI", text: "Liechtenstein" }, { value: "LT", text: "Lituanie" },
      { value: "LU", text: "Luxembourg" }, { value: "MK", text: "Macédoine du Nord" }, { value: "MG", text: "Madagascar" },
      { value: "MY", text: "Malaisie" }, { value: "MW", text: "Malawi" }, { value: "MV", text: "Maldives" },
      { value: "ML", text: "Mali" }, { value: "MT", text: "Malte" }, { value: "MA", text: "Maroc" },
      { value: "MU", text: "Maurice" }, { value: "MR", text: "Mauritanie" }, { value: "MX", text: "Mexique" },
      { value: "FM", text: "Micronésie" }, { value: "MD", text: "Moldavie" }, { value: "MC", text: "Monaco" },
      { value: "MN", text: "Mongolie" }, { value: "ME", text: "Monténégro" }, { value: "MZ", text: "Mozambique" },
      { value: "MM", text: "Myanmar" }, { value: "NA", text: "Namibie" }, { value: "NR", text: "Nauru" },
      { value: "NP", text: "Népal" }, { value: "NI", text: "Nicaragua" }, { value: "NE", text: "Niger" },
      { value: "NG", text: "Nigeria" }, { value: "NO", text: "Norvège" }, { value: "NZ", text: "Nouvelle-Zélande" },
      { value: "OM", text: "Oman" }, { value: "UG", text: "Ouganda" }, { value: "UZ", text: "Ouzbékistan" },
      { value: "PK", text: "Pakistan" }, { value: "PW", text: "Palaos" }, { value: "PS", text: "Palestine" },
      { value: "PA", text: "Panama" }, { value: "PG", text: "Papouasie-Nouvelle-Guinée" }, { value: "PY", text: "Paraguay" },
      { value: "NL", text: "Pays-Bas" }, { value: "PE", text: "Pérou" }, { value: "PH", text: "Philippines" },
      { value: "PL", text: "Pologne" }, { value: "PT", text: "Portugal" }, { value: "QA", text: "Qatar" },
      { value: "RO", text: "Roumanie" }, { value: "GB", text: "Royaume-Uni" }, { value: "RU", text: "Russie" },
      { value: "RW", text: "Rwanda" }, { value: "KN", text: "Saint-Kitts-et-Nevis" }, { value: "LC", text: "Sainte-Lucie" },
      { value: "VC", text: "Saint-Vincent-et-les-Grenadines" }, { value: "SB", text: "Salomon" }, { value: "SV", text: "Salvador" },
      { value: "WS", text: "Samoa" }, { value: "ST", text: "Sao Tomé-et-Príncipe" }, { value: "SN", text: "Sénégal" },
      { value: "RS", text: "Serbie" }, { value: "SC", text: "Seychelles" }, { value: "SL", text: "Sierra Leone" },
      { value: "SG", text: "Singapour" }, { value: "SK", text: "Slovaquie" }, { value: "SI", text: "Slovénie" },
      { value: "SO", text: "Somalie" }, { value: "SD", text: "Soudan" }, { value: "SS", text: "Soudan du Sud" },
      { value: "LK", text: "Sri Lanka" }, { value: "SE", text: "Suède" }, { value: "CH", text: "Suisse" },
      { value: "SR", text: "Suriname" }, { value: "SZ", text: "Swaziland" }, { value: "SY", text: "Syrie" },
      { value: "TJ", text: "Tadjikistan" }, { value: "TZ", text: "Tanzanie" }, { value: "TD", text: "Tchad" },
      { value: "CZ", text: "Tchéquie" }, { value: "TH", text: "Thaïlande" }, { value: "TL", text: "Timor oriental" },
      { value: "TG", text: "Togo" }, { value: "TO", text: "Tonga" }, { value: "TT", text: "Trinité-et-Tobago" },
      { value: "TN", text: "Tunisie" }, { value: "TM", text: "Turkménistan" }, { value: "TR", text: "Turquie" },
      { value: "TV", text: "Tuvalu" }, { value: "UA", text: "Ukraine" }, { value: "UY", text: "Uruguay" },
      { value: "VU", text: "Vanuatu" }, { value: "VA", text: "Vatican" }, { value: "VE", text: "Venezuela" },
      { value: "VN", text: "Vietnam" }, { value: "YE", text: "Yémen" }, { value: "ZM", text: "Zambie" },
      { value: "ZW", text: "Zimbabwe" }
    ]
  end
end
