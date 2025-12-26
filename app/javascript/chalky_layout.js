// =============================================================================
// ChalkyLayout - Auto-registration des contrôleurs Stimulus
// =============================================================================
//
// Ce fichier enregistre automatiquement tous les contrôleurs Stimulus de la gem.
//
// Usage dans l'application hôte (dans application.js) :
//   import "chalky_layout"
//
// Prérequis : L'application doit avoir un fichier controllers/application.js
// qui exporte l'application Stimulus (convention Rails par défaut).
// =============================================================================

import { application } from "controllers/application"

// Contrôleurs avec noms simples (utilisés par les composants internes)
import BackController from "controllers/chalky_layout/back_controller"
import DropdownController from "controllers/chalky_layout/dropdown_controller"
import GridController from "controllers/chalky_layout/grid_controller"
import StopPropagationController from "controllers/chalky_layout/stop_propagation_controller"
import TabsController from "controllers/chalky_layout/tabs_controller"
import TooltipController from "controllers/chalky_layout/tooltip_controller"
import ScrollShadowController from "controllers/chalky_layout/scroll_shadow_controller"
import TomSelectController from "controllers/chalky_layout/tom_select_controller"

// Contrôleurs sidebar avec nommage Stimulus standard (namespace--controller)
import SidebarController from "controllers/chalky_layout/sidebar_controller"
import MobileMenuController from "controllers/chalky_layout/mobile_menu_controller"

// Enregistrement des contrôleurs
application.register("back", BackController)
application.register("dropdown", DropdownController)
application.register("grid", GridController)
application.register("stop-propagation", StopPropagationController)
application.register("tabs", TabsController)
application.register("tooltip", TooltipController)
application.register("scroll-shadow", ScrollShadowController)
application.register("chalky-layout--sidebar", SidebarController)
application.register("chalky-layout--mobile-menu", MobileMenuController)
application.register("tom-select", TomSelectController)
