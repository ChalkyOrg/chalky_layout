---
name: chalky-layout
description: |
  Rails UI component library for admin interfaces. Use this skill for ANY frontend work:
  views, templates, pages, forms, buttons, grids, cards, sidebars, headers, alerts,
  badges, tooltips, tabs, dropdowns, or any HTML/Slim template modifications.
  Also covers Simple Form integration with TomSelect for enhanced select inputs.
triggers:
  - views
  - templates
  - forms
  - simple_form
  - frontend
  - ui
  - components
  - page layout
  - admin interface
  - buttons
  - grids
  - tables
  - cards
  - sidebars
  - navigation
  - alerts
  - badges
  - tooltips
  - dropdowns
  - tabs
  - tailwind
  - styling
  - css
  - tom-select
  - select inputs
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
---

# Chalky Layout - Rails UI Components

This project uses the **chalky_layout** gem for all frontend UI components.

## When to Use This Skill

Use this skill for ANY of the following tasks:

**Page Structure:**
- Creating or modifying views (`.html.slim`, `.html.erb`)
- Building admin pages or dashboards
- Adding page headers, footers, or content sections

**Components:**
- Adding buttons, cards, panels, or containers
- Displaying data in tables/grids
- Creating navigation (sidebars, tabs, dropdowns)
- Adding alerts, badges, tooltips, or other UI feedback

**Forms (Simple Form + TomSelect):**
- Building forms with Simple Form
- Adding select inputs (single or multiple)
- Using TomSelect for enhanced dropdowns
- Styling form inputs with Chalky classes

**Styling:**
- Applying Tailwind CSS with Chalky design tokens
- Customizing component appearance
- Using CSS custom properties for theming

## IMPORTANT: Always Use Chalky Helpers

When working on ANY frontend task, you MUST:
1. Use `chalky_*` helper methods instead of raw HTML
2. Follow the component patterns documented below
3. Use Slim templates (not ERB) unless the project uses ERB
4. Use Tailwind CSS classes for custom styling
5. For forms, use Simple Form with Chalky wrappers

## Quick Reference

### Page Structure
```slim
= chalky_page do |page|
  - page.with_header(title: "Page Title", subtitle: "Description") do |header|
    - header.with_actions do
      = link_to path do
        = chalky_icon_button(label: "Action", icon: "fa-solid fa-plus")
  - page.with_body do
    = chalky_card do
      / Content here
```

### Data Display (Grid)
```slim
= chalky_grid(rows: @items, details_path: :item_path) do |grid|
  - grid.text(label: "Name", method: :name, priority: :primary)
  - grid.badge(label: "Status", method: :status, color: :green)
  - grid.number(label: "Qty", method: :quantity, unit: "pcs")
  - grid.boolean(label: "Active", method: :active?)
  - grid.date(label: "Created", method: :created_at)
  - grid.action(name: "Edit", path: :edit_item_path, icon: "fa-solid fa-pen")
```

### Containers
```slim
= chalky_card do
  / Content

= chalky_panel(title: "Section", icon: "fa-solid fa-cog") do
  / Collapsible content

= chalky_heading(title: "Title", subtitle: "Description")
```

### UI Elements
```slim
= chalky_badge(label: "Active", color: :green)
= chalky_stat(label: "Total", value: 1234, icon: "fa-solid fa-users")
= chalky_alert(message: "Success!", variant: :success)
= chalky_tooltip do |tooltip|
  - tooltip.with_trigger do
    / Trigger element
  - tooltip.with_tooltip_content do
    | Help text
```

### Buttons
```slim
= link_to path do
  = chalky_icon_button(label: "Action", icon: "fa-solid fa-plus")

= chalky_button(label: "Save", variant: :primary)
= chalky_button(label: "Cancel", variant: :secondary)
= chalky_button(label: "Delete", variant: :danger)
= chalky_back(fallback_url: "/admin")
```

### Navigation
```slim
= chalky_tabs(tabs: [
  {name: "Tab 1", path: path1},
  {name: "Tab 2", path: path2}
])

= chalky_dropdown do |dropdown|
  - dropdown.with_trigger do
    = chalky_icon_button(label: "Menu", icon: "fa-solid fa-ellipsis-v")
  - dropdown.with_menu do
    = link_to "Option 1", path1
```

### Sidebar Layout
```slim
= chalky_sidebar_layout(menu_title: "Menu") do |layout|
  - layout.with_header do
    = image_tag "logo.png", class: "h-8"

  - layout.with_section(title: "Navigation", icon_path: "M3 12l2-2m0...", icon_color: :blue) do |section|
    - section.with_menu_item(path: "/admin", title: "Dashboard", icon_classes: "fa-solid fa-gauge")

  - layout.with_footer(user_name: current_user.name, user_email: current_user.email, logout_path: logout_path)

  = yield
```

### Simple Form (with TomSelect)

```slim
= simple_form_for @model, html: { class: "chalky-form" } do |f|
  = f.input :name
  = f.input :email, as: :email
  = f.input :country, collection: Country::ALL, include_blank: "Select..."
  = f.input :skills, collection: Skill::ALL, input_html: { multiple: true }, wrapper: :select_multiple
  = f.input :role, as: :radio_buttons, collection: Role::ALL
  = f.input :interests, as: :check_boxes, collection: Interest::ALL
  = f.input :terms, as: :boolean, label: "I accept the terms"
  = f.input :birth_date, as: :string, input_html: { type: "date" }
  = f.input :avatar, as: :file
  = f.button :submit, "Save", class: "chalky-button chalky-button--primary"
```

**Wrappers:** `:default`, `:select` (auto with TomSelect), `:select_multiple`, `:radio_buttons`, `:check_boxes`, `:boolean`, `:file`

## Available Helpers

| Helper | Purpose |
|--------|---------|
| `chalky_page` | Page wrapper with header/body slots |
| `chalky_title_bar` | Standalone header bar |
| `chalky_card` | Card container |
| `chalky_panel` | Collapsible section |
| `chalky_heading` | Section title |
| `chalky_grid` | Data table (supports `pagy:` for pagination) |
| `chalky_pagination` | Standalone pagination |
| `chalky_dropdown` | Dropdown menu |
| `chalky_icon_button` | Button with icon |
| `chalky_button` | Form button |
| `chalky_back` | Back navigation |
| `chalky_badge` | Status label |
| `chalky_stat` | KPI card |
| `chalky_tooltip` | Hover tooltip |
| `chalky_hint` | Help text |
| `chalky_alert` | Message box |
| `chalky_info_row` | Label/value pair |
| `chalky_tabs` | Navigation tabs |
| `chalky_sidebar_layout` | Complete sidebar layout |

## Full Documentation

See `reference.md` in this skill folder for complete parameter documentation.
