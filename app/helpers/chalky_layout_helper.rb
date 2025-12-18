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
  # @param pagy [Pagy] optional Pagy object for automatic pagination
  def chalky_grid(rows:, **options, &block)
    render Chalky::Grid::Component.new(rows: rows, **options), &block
  end

  # Pagination - navigation component for paginated data (requires Pagy gem)
  # @param pagy [Pagy] Pagy object with pagination info
  # @param url_builder [Proc] optional proc to build page URLs, receives page number
  #
  # Usage:
  #   = chalky_pagination(pagy: @pagy)
  #
  # With custom URL builder:
  #   = chalky_pagination(pagy: @pagy, url_builder: ->(page) { users_path(page: page) })
  def chalky_pagination(pagy:, url_builder: nil)
    url_builder ||= ->(page) { url_for(request.query_parameters.merge(page: page)) }
    render Chalky::Pagination::Component.new(pagy: pagy, url_builder: url_builder)
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
    component = Chalky::AdminForms::Button::Component.new(**options)
    if block_given?
      render(component, &block)
    elsif label
      render(component) { label }
    else
      render(component)
    end
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

  # ============================================
  # UI Elements
  # ============================================

  # Badge - colored label for status, tags, etc.
  # @param label [String] badge text
  # @param color [Symbol] :gray, :green, :red, :blue, :yellow, :orange, :purple
  # @param size [Symbol] :xs, :sm, :md
  # @param style [Symbol] :rounded, :pill
  # @param icon [String] optional Font Awesome icon class
  def chalky_badge(label:, color: :gray, size: :sm, style: :rounded, icon: nil)
    render Chalky::Ui::Badge::Component.new(
      label: label,
      color: color,
      size: size,
      style: style,
      icon: icon
    )
  end

  # Stat card - KPI display for dashboards
  # @param label [String] metric label
  # @param value [String, Number] metric value
  # @param icon [String] optional Font Awesome icon class
  # @param icon_color [Symbol] :gray, :green, :red, :blue, :yellow, :orange, :purple
  # @param subtitle [String] optional additional text
  # @param trend [Symbol] :up, :down, or nil
  def chalky_stat(label:, value:, icon: nil, icon_color: :blue, subtitle: nil, trend: nil)
    render Chalky::Ui::Stat::Component.new(
      label: label,
      value: value,
      icon: icon,
      icon_color: icon_color,
      subtitle: subtitle,
      trend: trend
    )
  end

  # Hint - small help text
  # @param text [String] hint text (or use block)
  # @param size [Symbol] :xs, :sm
  # @param icon [String] optional Font Awesome icon class
  def chalky_hint(text: nil, size: :xs, icon: nil, &block)
    render Chalky::Ui::Hint::Component.new(
      text: text,
      size: size,
      icon: icon
    ), &block
  end

  # Tooltip - hover tooltip with text
  # @param text [String] tooltip text to display
  # @param position [Symbol] :top, :bottom, :left, :right
  # @param variant [Symbol] :dark, :light
  # @param delay [Integer] delay in ms before showing
  def chalky_tooltip(text:, position: :top, variant: :dark, delay: 0, &block)
    render Chalky::Ui::Tooltip::Component.new(
      text: text,
      position: position,
      variant: variant,
      delay: delay
    ), &block
  end

  # Alert - info/warning/error message box
  # @param message [String] alert message (or use block)
  # @param title [String] optional alert title
  # @param variant [Symbol] :info, :success, :warning, :error
  # @param style [Symbol] :default, :left_border
  # @param icon [String] optional custom icon (defaults based on variant)
  # @param dismissible [Boolean] show dismiss button
  def chalky_alert(message: nil, title: nil, variant: :info, style: :default, icon: nil, dismissible: false, &block)
    render Chalky::Ui::Alert::Component.new(
      message: message,
      title: title,
      variant: variant,
      style: style,
      icon: icon,
      dismissible: dismissible
    ), &block
  end

  # Info row - label/value display pair
  # @param label [String] row label
  # @param value [String] row value (or use block)
  # @param separator [Boolean] add top border separator
  # @param bold_value [Boolean] make value bold (for totals, etc.)
  def chalky_info_row(label:, value: nil, separator: false, bold_value: false, &block)
    render Chalky::Ui::InfoRow::Component.new(
      label: label,
      value: value,
      separator: separator,
      bold_value: bold_value
    ), &block
  end

  # Tabs - navigation tabs for page sections
  # @param tabs [Array<Hash>] Array of tab definitions
  #   - :name [String] Tab label (required)
  #   - :path [String] Tab URL (required)
  #   - :icon [String] Optional Font Awesome icon class
  #   - :badge [Integer] Optional badge count
  #   - :active_param [String] Query param name for active detection
  #   - :active_value [String] Query param value for active detection
  def chalky_tabs(tabs:)
    render Chalky::Ui::Tabs::Component.new(tabs: tabs)
  end

  # ============================================
  # Sidebar Components
  # ============================================

  # Sidebar layout - complete sidebar with mobile/desktop support
  # Renders the full sidebar structure including:
  # - Mobile hamburger button
  # - Mobile overlay and slide-in menu
  # - Desktop fixed sidebar with collapse toggle
  # - Main content wrapper
  #
  # @param menu_title [String] Title shown in mobile menu header (default: "Menu")
  #
  # Usage:
  #   = chalky_sidebar_layout(menu_title: "Menu") do |layout|
  #     - layout.with_header do
  #       / Your logo here
  #
  #     - layout.with_section(title: "Boutique", icon_path: "M16 11V7...", icon_color: :blue) do |section|
  #       - section.with_menu_item(path: "/admin", title: "Dashboard", icon_classes: "fa-solid fa-gauge")
  #
  #     - layout.with_footer(user_name: "Admin", user_email: "admin@example.com", logout_path: "/logout") do |footer|
  #       - footer.with_menu_item(path: "/profile", title: "Mon profil", icon_classes: "fa-solid fa-user")
  #
  #     = yield
  def chalky_sidebar_layout(menu_title: "Menu", &block)
    render Chalky::Sidebar::Layout::Component.new(
      menu_title: menu_title
    ), &block
  end

  # Script to prevent FOUC (Flash of Unstyled Content) for sidebar
  # Must be placed in the <head> section of your layout
  # Reads localStorage to apply collapsed state before first render
  def chalky_sidebar_head_script
    content_tag(:script) do
      <<~JS.html_safe
        (function() {
          var collapsed = localStorage.getItem('chalky_sidebar_collapsed') === 'true';
          if (collapsed) {
            document.documentElement.classList.add('sidebar-starts-collapsed');
          }
        })();
      JS
    end
  end
end
