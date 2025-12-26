---
name: chalky-layout
description: |
  UI components library for Rails admin interfaces using ViewComponent.
  Use this skill for ANY frontend work: creating views, templates, pages,
  layouts, forms, buttons, grids, cards, sidebars, headers, alerts, badges,
  tooltips, tabs, dropdowns, or any HTML/Slim template modifications.
  Always use chalky_* helpers instead of raw HTML for consistent UI.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
---

# Chalky Layout - Rails UI Components

This project uses **chalky_layout** gem for all frontend UI components.

## IMPORTANT: Always use Chalky helpers

When working on ANY frontend task (views, templates, pages, components), you MUST:
1. Use `chalky_*` helper methods instead of raw HTML
2. Follow the component patterns documented below
3. Use Slim templates (not ERB)
4. Use Tailwind CSS classes for custom styling

## When to use this skill

This skill applies to ALL frontend work including:
- Creating or modifying views (`.html.slim`, `.html.erb`)
- Building admin pages or dashboards
- Adding forms, buttons, or interactive elements
- **Building forms with Simple Form** (use Chalky wrappers and TomSelect)
- Displaying data in tables or grids
- Creating navigation (sidebars, tabs, headers)
- Adding alerts, badges, tooltips, or other UI feedback
- Structuring page layouts

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
  / Basic columns
  - grid.text(label: "Name", method: :name, priority: :primary)
  - grid.badge(label: "Status", method: :status, color: :green)
  - grid.number(label: "Qty", method: :quantity, unit: "pcs")
  - grid.boolean(label: "Active", method: :active?)

  / Date/time columns
  - grid.date(label: "Created", method: :created_at)
  - grid.datetime(label: "Updated", method: :updated_at, formatted_as: :relative)

  / Interactive columns
  - grid.link(label: "Website", method: :name, path: :website_path)
  - grid.image(label: "Photo", method: :avatar, size: :small)
  - grid.icon(method: :featured?, icon: "fa-solid fa-star")

  / Custom column with block
  - grid.custom(label: "Total") do |item|
    span.font-bold = number_to_currency(item.total)

  / Row actions
  - grid.action(name: "Edit", path: :edit_item_path, icon: "fa-solid fa-pen")
  - grid.action(name: "Delete", path: :item_path, icon: "fa-solid fa-trash", data: { turbo_method: :delete, turbo_confirm: "Sure?" }, options: { variant: :danger })

/ Grid with pagination (requires Pagy gem)
= chalky_grid(rows: @users, pagy: @pagy) do |grid|
  - grid.text(label: "Name", method: :name)

/ Advanced: nested attributes and procs
= chalky_grid(rows: @orders) do |grid|
  - grid.text(label: "Customer", method: "user.full_name")  / dot notation
  - grid.text(label: "Total", method: ->(o) { number_to_currency(o.total) })  / proc

/ Advanced: custom row styling
= chalky_grid(rows: @orders, row_classes_proc: ->(row) { row.urgent? ? "bg-red-50" : "" }) do |grid|
  - grid.text(label: "Order", method: :number)

/ Standalone pagination
= chalky_pagination(pagy: @pagy)
```

**Grid Column Types:**
| Type | Description | Key Params |
|------|-------------|------------|
| `text` | Plain text | `priority:` |
| `badge` | Colored badge | `color:` |
| `number` | Formatted number | `unit:` |
| `boolean` | Yes/No icons | - |
| `date` | Localized date | `formatted_as:` |
| `datetime` | Date & time | `formatted_as:` (`:relative`) |
| `link` | Clickable link | `path:` |
| `image` | Thumbnail | `size:` (`:small`/`:medium`/`:large`) |
| `icon` | Conditional icon | `icon:` |
| `custom` | Custom block | Block required |
| `select` | Dropdown | - |
| `references` | Associated records | - |
| `users` | User avatars | - |

**Priority:** `:primary` (always visible), `:secondary` (default), `:optional` (large screens only)
**Colors:** `:green`, `:red`, `:blue`, `:yellow`, `:purple`, `:orange`, `:gray`

### Containers
```slim
/ Card container
= chalky_card do
  / Content

/ Collapsible panel
= chalky_panel(title: "Section", icon: "fa-solid fa-cog") do
  / Content

/ Section heading
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
    | Help text or rich HTML
= chalky_info_row(label: "Name", value: @user.name)
```

### Buttons
```slim
/ Icon button (for header actions) - must be wrapped in link_to
= link_to path do
  = chalky_icon_button(label: "Action", icon: "fa-solid fa-plus")

/ Form button with variants
= chalky_button(label: "Save", variant: :primary)
= chalky_button(label: "Cancel", variant: :secondary)
= chalky_button(label: "Confirm", variant: :success)
= chalky_button(label: "Delete", variant: :danger)

/ Button with different sizes
= chalky_button(label: "Small", size: :sm)
= chalky_button(label: "Large", size: :lg)

/ Back navigation
= chalky_back(fallback_url: "/admin")
```

**Button Variants:** `:primary` (blue), `:secondary` (gray), `:success` (green), `:danger` (red)
**Button Sizes:** `:sm`, `:md` (default), `:lg`

### Navigation
```slim
/ Tabs
= chalky_tabs(tabs: [
  {name: "Tab 1", path: path1},
  {name: "Tab 2", path: path2}
])

/ Dropdown
= chalky_dropdown do |dropdown|
  - dropdown.with_trigger do
    = chalky_icon_button(label: "Menu", icon: "fa-solid fa-ellipsis-v")
  - dropdown.with_menu do
    = link_to "Option 1", path1
```

### Sidebar Layout (Recommended)
```slim
/ In your layout file (e.g., admin.html.slim)
doctype html
html.h-full
  head
    = chalky_sidebar_head_script  / IMPORTANT: Prevents flash of unstyled content

  body.h-full
    = chalky_sidebar_layout(menu_title: "Menu") do |layout|
      - layout.with_header do
        = image_tag "logo.png", class: "h-8"

      - layout.with_section(title: "Navigation", icon_path: "M3 12l2-2m0...", icon_color: :blue) do |section|
        - section.with_menu_item(path: "/admin", title: "Dashboard", icon_classes: "fa-solid fa-gauge")
        - section.with_menu_item(path: "/admin/orders", title: "Orders", icon_classes: "fa-solid fa-shopping-cart")

      - layout.with_footer(user_name: current_user.name, user_email: current_user.email, logout_path: logout_path) do |footer|
        - footer.with_menu_item(path: profile_path, title: "Profile", icon_classes: "fa-solid fa-user")

      = yield
```

### Simple Form (with TomSelect)

Install with: `rails generate chalky_layout:simple_form`

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
| `chalky_actions` | Standalone action buttons container |
| `chalky_content` | Standalone content wrapper |
| `chalky_card` | Card container |
| `chalky_panel` | Collapsible section |
| `chalky_heading` | Section title |
| `chalky_grid` | Data table (supports `pagy:` for pagination) |
| `chalky_pagination` | Standalone pagination (requires Pagy) |
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
| `chalky_sidebar_layout` | Complete sidebar with mobile/desktop support (recommended) |
| `chalky_sidebar_head_script` | Anti-FOUC script for sidebar (place in `<head>`) |

## Tailwind & Theming Setup

ChalkyLayout works with both **Tailwind v3** and **Tailwind v4**.

### Tailwind v3
```css
/* application.css */
@tailwind base;
@tailwind components;
@tailwind utilities;

@import "chalky_layout/tokens.css";
@import "chalky_layout/utilities.css";
```

### Tailwind v4
```css
/* application.css */
@import "tailwindcss";

@source "../../../vendor/bundle/ruby/*/gems/chalky_layout-*/app/**/*.{slim,rb}";

@import "chalky_layout/tokens.css";
@import "chalky_layout/utilities.css";
```

### Customizing the Theme

Override CSS custom properties AFTER the imports:

```css
:root {
  /* Primary brand color - change to purple */
  --chalky-primary: #8b5cf6;
  --chalky-primary-hover: #7c3aed;
  --chalky-primary-light: #f5f3ff;
  --chalky-primary-text: #6d28d9;

  /* Semantic colors */
  --chalky-success: #16a34a;
  --chalky-danger: #dc2626;
  --chalky-warning: #ca8a04;
  --chalky-info: #0284c7;

  /* Accent colors for badges/icons */
  --chalky-accent-blue: #3b82f6;
  --chalky-accent-green: #22c55e;
  --chalky-accent-red: #ef4444;
  --chalky-accent-purple: #a855f7;
}
```

**Where to put theme overrides:**
- `app/assets/stylesheets/application.css` - after ChalkyLayout imports
- `app/assets/stylesheets/theme.css` - dedicated file (import last)

See `app/assets/stylesheets/chalky_layout/tokens.css` for all available tokens.

## Full Documentation

See `reference.md` in this skill folder for complete parameter documentation.
