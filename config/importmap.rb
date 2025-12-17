# frozen_string_literal: true

# ChalkyLayout Stimulus controllers
controllers_path = ChalkyLayout::Engine.root.join("app/javascript/chalky_layout/controllers")
Dir[controllers_path.join("*_controller.js")].each do |controller_file|
  controller_name = File.basename(controller_file, ".js")
  pin "controllers/chalky_layout/#{controller_name}", to: controller_file
end
