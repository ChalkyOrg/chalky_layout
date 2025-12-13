# frozen_string_literal: true

##
# Helper methods for ChalkyLayout components
# Provides simple snake_case methods to render components
#
# Usage:
#   = chalky_page do |page|
#     - page.with_header(title: "Users") do |header|
#       - header.with_actions do
#         = link_to ... do
#           = chalky_icon_button(label: "New")
#     - page.with_body do
#       = chalky_card do
#         ...
#
module ChalkyLayoutHelper
  # ============================================
  # Page Layout Components
  # ============================================

  # Page wrapper - main container for admin pages
  # @param title [String] optional title
  # @param subtitle [String] optional subtitle
  # @param css_classes [String] additional CSS classes
  # @param data_attributes [Hash] data attributes
  def chalky_page(title: nil, subtitle: nil, css_classes: "", data_attributes: {}, &block)
    render Chalky::Page::Component.new(
      title: title,
      subtitle: subtitle,
      css_classes: css_classes,
      data_attributes: data_attributes
    ), &block
  end

  # Title bar - sticky header with title, subtitle, and actions (standalone)
  # @param title [String] page title
  # @param subtitle [String] optional subtitle
  # @param spacing [String] margin classes
  # @param backlink [Boolean] show back button
  # @param backlink_fallback_url [String] fallback URL for back button
  def chalky_title_bar(title: nil, subtitle: nil, spacing: "mb-0", backlink: true, backlink_fallback_url: "/", &block)
    render Chalky::Page::Header::Component.new(
      title: title,
      subtitle: subtitle,
      spacing: spacing,
      backlink: backlink,
      backlink_fallback_url: backlink_fallback_url
    ), &block
  end

  # Actions container - groups action buttons (standalone)
  # @param layout [Symbol] :right, :left, or :center
  # @param spacing [String] additional spacing classes
  def chalky_actions(layout: :right, spacing: "", &block)
    render Chalky::Page::Actions::Component.new(
      layout: layout,
      spacing: spacing
    ), &block
  end

  # Content area - main content zone (standalone)
  # @param full_width [Boolean] use full width
  def chalky_content(full_width: false, **options, &block)
    render Chalky::Page::Body::Component.new(full_width: full_width, **options), &block
  end

  # ============================================
  # Data Display
  # ============================================

  # Grid - responsive data table
  # @param rows [Array] data rows to display
  # @param variant [Symbol] :default, :simple, or :admin
  # @param details_path [Symbol] path helper for row links
  # @param responsive [Boolean] enable responsive mode
  # @param horizontal_scroll [Boolean] enable horizontal scroll
  def chalky_grid(rows:, **options, &block)
    render Chalky::Grid::Component.new(rows: rows, **options), &block
  end

  # ============================================
  # Interactive Components
  # ============================================

  # Dropdown menu
  # @param variant [Symbol] :primary, :secondary, or :admin
  # @param pop_direction [Symbol] :right or :left
  # @param css_classes [String] additional CSS classes
  def chalky_dropdown(variant: :admin, pop_direction: :right, css_classes: "", **data_attributes, &block)
    render Chalky::AdminForms::Dropdown::Component.new(
      variant: variant,
      pop_direction: pop_direction,
      css_classes: css_classes,
      **data_attributes
    ), &block
  end

  # ============================================
  # Buttons
  # ============================================

  # Icon button - button with icon and label (for header actions)
  # @param label [String] button label
  # @param icon [String] Font Awesome icon class
  def chalky_icon_button(label:, icon: nil, &block)
    render Chalky::Buttons::Option::Component.new(label: label, icon: icon), &block
  end

  # Back button - navigates to previous page with JS history support
  # @param fallback_url [String] fallback URL if no browser history
  def chalky_back(fallback_url: "/", &block)
    render Chalky::Buttons::Back::Component.new(fallback_url: fallback_url), &block
  end

  # Form button
  # @param label [String] button label
  # @param variant [Symbol] button variant
  # @param type [Symbol] button type (:submit, :button)
  def chalky_button(label: nil, **options, &block)
    render Chalky::AdminForms::Button::Component.new(label: label, **options), &block
  end

  # ============================================
  # Containers
  # ============================================

  # Panel - collapsible section with icon
  # @param title [String] panel title
  # @param icon [String] Font Awesome icon class
  # @param subtitle [String] optional subtitle
  # @param icon_color [Symbol] :blue, :green, :red, etc.
  # @param dom_id [String] DOM ID for the panel
  # @param open [Boolean] initially open
  def chalky_panel(title:, icon:, subtitle: nil, icon_color: :blue, dom_id: nil, open: true, &block)
    render Chalky::Admin::Section::Component.new(
      title: title,
      icon: icon,
      subtitle: subtitle,
      icon_color: icon_color,
      dom_id: dom_id,
      open: open
    ), &block
  end

  # Card - simple container with shadow and border
  # @param css_classes [String] additional CSS classes
  # @param data_attributes [Hash] data attributes
  # @param spacing [String] margin classes
  def chalky_card(css_classes: "", data_attributes: {}, spacing: "mb-4 md:mb-8", &block)
    render Chalky::AdminForms::FormSection::Component.new(
      css_classes: css_classes,
      data_attributes: data_attributes,
      spacing: spacing
    ), &block
  end

  # Heading - section title with optional description
  # @param title [String] heading title
  # @param subtitle [String] optional description (alias for description)
  # @param description [String] optional description
  def chalky_heading(title:, subtitle: nil, description: nil, **options, &block)
    render Chalky::AdminForms::SectionHeader::Component.new(
      title: title,
      description: subtitle || description,
      **options
    ), &block
  end
end
