# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

# Les contrôleurs chalky_layout sont chargés directement depuis la gem via son importmap.rb
# (voir config/importmap.rb dans la gem qui est ajouté automatiquement par l'engine)
