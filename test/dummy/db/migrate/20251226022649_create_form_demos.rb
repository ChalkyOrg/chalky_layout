# frozen_string_literal: true

class CreateFormDemos < ActiveRecord::Migration[7.0]
  def change
    create_table :form_demos do |t|
      # Text inputs
      t.string :name
      t.string :email
      t.string :password_digest

      # Textarea
      t.text :bio

      # Numbers
      t.integer :age
      t.decimal :salary, precision: 10, scale: 2

      # Select (stored as string)
      t.string :country

      # Radio buttons (stored as string)
      t.string :role

      # Boolean (checkbox)
      t.boolean :terms_accepted, default: false
      t.boolean :newsletter, default: false

      # Date and time
      t.date :birth_date
      t.datetime :appointment

      # Multiple choices (stored as JSON array)
      t.json :interests

      # File attachment handled separately via Active Storage or string placeholder
      t.string :avatar

      t.timestamps
    end
  end
end
