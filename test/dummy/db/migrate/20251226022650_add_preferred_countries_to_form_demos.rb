class AddPreferredCountriesToFormDemos < ActiveRecord::Migration[8.1]
  def change
    add_column :form_demos, :preferred_countries, :json
  end
end
