// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// ChalkyLayout controllers
import DropdownController from "controllers/chalky_layout/dropdown_controller"
import GridController from "controllers/chalky_layout/grid_controller"
import BackController from "controllers/chalky_layout/back_controller"
import StopPropagationController from "controllers/chalky_layout/stop_propagation_controller"
import TooltipController from "controllers/chalky_layout/tooltip_controller"
import SidebarController from "controllers/chalky_layout/sidebar_controller"
import MobileMenuController from "controllers/chalky_layout/mobile_menu_controller"

application.register("dropdown", DropdownController)
application.register("grid", GridController)
application.register("back", BackController)
application.register("stop-propagation", StopPropagationController)
application.register("tooltip", TooltipController)
application.register("chalky-sidebar", SidebarController)
application.register("chalky-mobile-menu", MobileMenuController)
