# frozen_string_literal: true

# ChalkyLayout Simple Form Configuration
#
# This configuration provides plug-and-play form styling using Chalky design tokens.
# All inputs are styled by default - no additional classes needed in your views.
#
# Usage:
#   = simple_form_for @model do |f|
#     = f.input :name
#     = f.input :email
#     = f.input :role, collection: ['Admin', 'User'], as: :radio_buttons
#     = f.input :terms, as: :boolean
#     = f.button :submit
#
# Requires: chalky_layout/forms.css stylesheet

SimpleForm.setup do |config|
  # =============================================================================
  # WRAPPERS
  # =============================================================================

  # Default wrapper - vertical layout with label above input
  config.wrappers :default, class: "chalky-form-group mb-4" do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label, class: "chalky-label block text-sm font-medium mb-1"
    b.use :input, class: "chalky-input w-full px-3 py-2 rounded-md border transition-colors focus:outline-none focus:ring-2", error_class: "chalky-input--error"
    b.use :hint, wrap_with: { tag: :p, class: "chalky-hint mt-1 text-sm" }
    b.use :error, wrap_with: { tag: :p, class: "chalky-error mt-1 text-sm" }
  end

  # Boolean wrapper (single checkbox)
  config.wrappers :boolean, class: "chalky-form-group chalky-checkbox-wrapper mb-4" do |b|
    b.use :html5
    b.optional :readonly

    b.wrapper tag: :label, class: "chalky-checkbox-label flex items-start gap-3 cursor-pointer" do |ba|
      ba.use :input, class: "chalky-checkbox"
      ba.wrapper tag: :span, class: "chalky-checkbox-text" do |bb|
        bb.use :label_text
      end
    end
    b.use :hint, wrap_with: { tag: :p, class: "chalky-hint mt-1 text-sm ml-7" }
    b.use :error, wrap_with: { tag: :p, class: "chalky-error mt-1 text-sm ml-7" }
  end

  # Radio buttons collection wrapper
  config.wrappers :radio_buttons, class: "chalky-form-group chalky-radio-group mb-4" do |b|
    b.use :html5
    b.optional :readonly

    b.use :label, class: "chalky-label block text-sm font-medium mb-2"
    b.wrapper tag: :div, class: "chalky-radio-options" do |ba|
      ba.use :input, class: "chalky-radio-collection"
    end
    b.use :hint, wrap_with: { tag: :p, class: "chalky-hint mt-1 text-sm" }
    b.use :error, wrap_with: { tag: :p, class: "chalky-error mt-1 text-sm" }
  end

  # Check boxes collection wrapper
  config.wrappers :check_boxes, class: "chalky-form-group chalky-checkbox-group mb-4" do |b|
    b.use :html5
    b.optional :readonly

    b.use :label, class: "chalky-label block text-sm font-medium mb-2"
    b.wrapper tag: :div, class: "chalky-checkbox-options" do |ba|
      ba.use :input, class: "chalky-checkbox-collection"
    end
    b.use :hint, wrap_with: { tag: :p, class: "chalky-hint mt-1 text-sm" }
    b.use :error, wrap_with: { tag: :p, class: "chalky-error mt-1 text-sm" }
  end

  # File input wrapper
  config.wrappers :file, class: "chalky-form-group chalky-file-group mb-4" do |b|
    b.use :html5
    b.optional :readonly

    b.use :label, class: "chalky-label block text-sm font-medium mb-1"
    b.use :input, class: "chalky-file-input"
    b.use :hint, wrap_with: { tag: :p, class: "chalky-hint mt-1 text-sm" }
    b.use :error, wrap_with: { tag: :p, class: "chalky-error mt-1 text-sm" }
  end

  # Select wrapper with TomSelect integration
  config.wrappers :select, class: "chalky-form-group chalky-select-group mb-4" do |b|
    b.use :html5
    b.optional :readonly

    b.use :label, class: "chalky-label block text-sm font-medium mb-1"
    b.use :input, class: "chalky-select", data: { controller: "tom-select" }, error_class: "chalky-select--error"
    b.use :hint, wrap_with: { tag: :p, class: "chalky-hint mt-1 text-sm" }
    b.use :error, wrap_with: { tag: :p, class: "chalky-error mt-1 text-sm" }
  end

  # Select multiple wrapper with TomSelect integration
  config.wrappers :select_multiple, class: "chalky-form-group chalky-select-group mb-4" do |b|
    b.use :html5
    b.optional :readonly

    b.use :label, class: "chalky-label block text-sm font-medium mb-1"
    b.use :input, class: "chalky-select chalky-select--multiple", data: { controller: "tom-select", "tom-select-multiple-value": true }, error_class: "chalky-select--error"
    b.use :hint, wrap_with: { tag: :p, class: "chalky-hint mt-1 text-sm" }
    b.use :error, wrap_with: { tag: :p, class: "chalky-error mt-1 text-sm" }
  end

  # =============================================================================
  # INPUT MAPPINGS
  # =============================================================================

  config.default_wrapper = :default
  config.boolean_style = :nested
  config.button_class = "chalky-button chalky-button--primary"
  config.boolean_label_class = nil

  # Map input types to wrappers
  config.wrapper_mappings = {
    boolean: :boolean,
    check_boxes: :check_boxes,
    radio_buttons: :radio_buttons,
    file: :file,
    select: :select,
    grouped_select: :select
  }

  # =============================================================================
  # LABELS & ERRORS
  # =============================================================================

  config.required_by_default = true
  config.browser_validations = false

  # Error notification (for form-level errors)
  config.error_notification_tag = :div
  config.error_notification_class = "chalky-alert chalky-alert--error mb-4 p-4 rounded-md"

  # Show asterisk for required fields
  config.label_text = lambda { |label, required, explicit_label|
    if required
      "#{label} <span class=\"chalky-required\">*</span>".html_safe
    else
      label
    end
  }

  # =============================================================================
  # COLLECTION OPTIONS
  # =============================================================================

  # Don't wrap collection items - let CSS handle the layout
  config.collection_wrapper_tag = nil
  config.collection_wrapper_class = nil
  config.item_wrapper_tag = :div
  config.item_wrapper_class = "chalky-collection-item"
end
