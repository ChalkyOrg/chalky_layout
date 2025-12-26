# frozen_string_literal: true

# =============================================================================
# ChalkyLayout Importmap Configuration
# =============================================================================
#
# Pour utiliser les contrôleurs Stimulus de la gem, ajoutez dans votre application.js :
#   import "chalky_layout"
#
# Cela enregistrera automatiquement tous les contrôleurs avec les bons noms.
# =============================================================================

# Point d'entrée principal - auto-registration de tous les contrôleurs
pin "chalky_layout", to: "chalky_layout.js"

# Contrôleurs individuels (utilisés par le fichier chalky_layout.js)
pin "controllers/chalky_layout/back_controller", to: "chalky_layout/controllers/back_controller.js"
pin "controllers/chalky_layout/dropdown_controller", to: "chalky_layout/controllers/dropdown_controller.js"
pin "controllers/chalky_layout/grid_controller", to: "chalky_layout/controllers/grid_controller.js"
pin "controllers/chalky_layout/stop_propagation_controller", to: "chalky_layout/controllers/stop_propagation_controller.js"
pin "controllers/chalky_layout/tabs_controller", to: "chalky_layout/controllers/tabs_controller.js"
pin "controllers/chalky_layout/tooltip_controller", to: "chalky_layout/controllers/tooltip_controller.js"
pin "controllers/chalky_layout/scroll_shadow_controller", to: "chalky_layout/controllers/scroll_shadow_controller.js"
pin "controllers/chalky_layout/sidebar_controller", to: "chalky_layout/controllers/sidebar_controller.js"
pin "controllers/chalky_layout/mobile_menu_controller", to: "chalky_layout/controllers/mobile_menu_controller.js"
pin "controllers/chalky_layout/tom_select_controller", to: "chalky_layout/controllers/tom_select_controller.js"

# External dependencies (loaded from CDN via ESM)
pin "tom-select", to: "https://cdn.jsdelivr.net/npm/tom-select@2.4.3/+esm"
