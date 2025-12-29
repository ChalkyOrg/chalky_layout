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

---

## 🚀 Installation & Layout Configuration

### Layout Setup (Required)

Your application layout must include ChalkyLayout assets in the `<head>`:

```slim
doctype html
html
  head
    title = content_for(:title) || "My App"
    meta name="viewport" content="width=device-width,initial-scale=1"
    = csrf_meta_tags

    /! CRITICAL: Anti-FOUC script MUST be before stylesheets
    = chalky_sidebar_head_script

    /! Your Tailwind CSS
    = stylesheet_link_tag "tailwind", "data-turbo-track": "reload"

    /! ChalkyLayout - loads all CSS automatically (forms, sidebar, tabs, grid, tokens, utilities)
    = chalky_layout_stylesheets

    = javascript_importmap_tags

  body
    = chalky_sidebar_layout(menu_title: "Menu") do |layout|
      - layout.with_header do
        / Your logo
      - layout.with_section(title: "Menu", icon_color: :blue) do |section|
        - section.with_menu_item(path: "/", title: "Home", icon_classes: "fa-solid fa-home")
      - layout.with_footer(user_name: current_user&.name, logout_path: destroy_user_session_path)

      = yield
```

### JavaScript Setup

In `app/javascript/controllers/index.js`:

```javascript
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// ChalkyLayout - auto-registers all Stimulus controllers
import "chalky_layout"
```

**Note:** No manual importmap configuration needed - the gem handles it automatically!

---

## ⚠️ CRITICAL RULES - READ FIRST

### Forms: ALWAYS use Simple Form

```slim
/ ✅ CORRECT - Always use simple_form_for
= simple_form_for @user, html: { class: "chalky-form" } do |f|
  = f.input :name
  = f.input :email
  = f.button :submit, "Save", class: "chalky-button chalky-button--primary"

/ ❌ WRONG - Never use form_with or form_for
= form_with model: @user do |f|   # DON'T DO THIS
= form_for @user do |f|           # DON'T DO THIS
```

### Components: Prefer Chalky helpers when they exist

Before writing HTML for UI elements, check if a `chalky_*` helper exists:

| Need this? | Use this helper |
|------------|-----------------|
| Card/container | `chalky_card` |
| Data table | `chalky_grid` |
| Page with header | `chalky_page` |
| Status label | `chalky_badge` |
| Button in header | `chalky_icon_button` |
| Form button | `chalky_button` |
| Collapsible section | `chalky_panel` |
| Dropdown menu | `chalky_dropdown` |
| Tabs navigation | `chalky_tabs` |
| Tooltip | `chalky_tooltip` |
| Alert message | `chalky_alert` |
| KPI/stat card | `chalky_stat` |

Raw HTML is fine for content **inside** components or for elements not covered by the gem.

---

## 🎯 Think Before You Build

**Don't just fill templates mechanically.** Before building a page, ask yourself:

### What's the purpose of this page?

| Page type | Ask yourself |
|-----------|--------------|
| **Index** | What columns help users find/identify items quickly? Don't show everything, show what matters for scanning. |
| **Show** | What information does the user actually need? Group related info logically. |
| **Form** | What's required vs optional? What order makes sense for the workflow? |
| **Dashboard** | Which KPIs drive decisions? Don't add stats just because you can. |

### Guidelines for thoughtful UI

**Stats/KPIs** - Only use `chalky_stat` when:
- The number drives a business decision
- Users need to monitor this value regularly
- It answers "how are we doing?"

❌ Don't add stats just to fill space or "look professional"

**Info rows** - On show pages, ask:
- Does the user need this information right now?
- Is this information actionable?
- Should this be grouped with related fields?

❌ Don't display every model attribute - display what's useful

**Grid columns** - On index pages, ask:
- Can users identify the right row with these columns?
- What do users typically search/filter by?
- What's the primary action they'll take?

❌ Don't show 10 columns - show 3-5 that matter most

**Actions** - Ask:
- What's the primary action? (Make it prominent)
- What's dangerous? (Put in dropdown, use danger variant)
- What's rarely used? (Hide in dropdown)

### Example: Good vs Bad thinking

```slim
/ ❌ BAD - Mechanical, shows everything
= chalky_page do |page|
  - page.with_header(title: "Order ##{@order.id}")
  - page.with_body do
    .grid.grid-cols-4.gap-4.mb-6
      = chalky_stat(label: "ID", value: @order.id)           / Useless - already in title
      = chalky_stat(label: "Created", value: @order.created_at)  / Not a KPI
      = chalky_stat(label: "Updated", value: @order.updated_at)  / Nobody cares
      = chalky_stat(label: "User ID", value: @order.user_id)     / Raw ID, meaningless

/ ✅ GOOD - Thoughtful, shows what matters
= chalky_page do |page|
  - page.with_header(title: "Order ##{@order.number}", subtitle: @order.customer.name)
  - page.with_body do
    / Only show stats if this is a dashboard-like view where KPIs matter
    / For a simple order show page, just use info_rows instead:
    = chalky_card do
      = chalky_info_row(label: "Customer", value: @order.customer.name)
      = chalky_info_row(label: "Status") do
        = chalky_badge(label: @order.status, color: @order.paid? ? :green : :yellow)
      = chalky_info_row(label: "Total", value: number_to_currency(@order.total), bold_value: true)
```

---

## ❌ Anti-Patterns to Avoid

### Don't recreate components manually

```slim
/ ❌ WRONG - Manual card
.bg-white.rounded-lg.shadow.p-4
  h2.text-lg.font-bold Title
  p Content here

/ ✅ CORRECT - Use the helper
= chalky_card do
  h2.text-lg.font-bold Title
  p Content here
```

### Don't build tables manually for data display

```slim
/ ❌ WRONG - Manual table
table.min-w-full
  thead
    tr
      th Name
      th Email
  tbody
    - @users.each do |user|
      tr
        td = user.name
        td = user.email

/ ✅ CORRECT - Use chalky_grid
= chalky_grid(rows: @users) do |grid|
  - grid.text(label: "Name", method: :name)
  - grid.text(label: "Email", method: :email)
```

### Don't use form_with or form_for

```slim
/ ❌ WRONG
= form_with model: @product, local: true do |f|
  .mb-4
    = f.label :name
    = f.text_field :name, class: "border rounded px-3 py-2"

/ ✅ CORRECT
= simple_form_for @product, html: { class: "chalky-form" } do |f|
  = f.input :name
```

---

## 📋 Page Templates - Copy and Adapt

### Index Page (list with grid)

```slim
= chalky_page do |page|
  - page.with_header(title: "Products", subtitle: "Manage your catalog") do |header|
    - header.with_actions do
      = link_to new_product_path do
        = chalky_icon_button(label: "Add Product", icon: "fa-solid fa-plus")

  - page.with_body do
    = chalky_card do
      = chalky_grid(rows: @products, details_path: :product_path, pagy: @pagy) do |grid|
        - grid.text(label: "Name", method: :name, priority: :primary)
        - grid.badge(label: "Status", method: :status, color: :green)
        - grid.number(label: "Price", method: :price, unit: "€")
        - grid.date(label: "Created", method: :created_at)
        - grid.action(name: "Edit", path: :edit_product_path, icon: "fa-solid fa-pen")
```

### Show Page (detail view)

```slim
= chalky_page do |page|
  - page.with_header(title: @product.name) do |header|
    - header.with_actions do
      = link_to edit_product_path(@product) do
        = chalky_icon_button(label: "Edit", icon: "fa-solid fa-pen")
      = chalky_dropdown do |dropdown|
        - dropdown.with_trigger do
          = chalky_icon_button(label: "More", icon: "fa-solid fa-ellipsis-v")
        - dropdown.with_item(href: product_path(@product), method: :delete, variant: :danger, confirm: "Delete this product?") do
          | Delete

  - page.with_body do
    = chalky_card do
      = chalky_heading(title: "Details", icon_path: "fa-solid fa-info-circle", icon_color: :blue)
      = chalky_info_row(label: "Name", value: @product.name)
      = chalky_info_row(label: "Price", value: number_to_currency(@product.price))
      = chalky_info_row(label: "Status") do
        = chalky_badge(label: @product.status, color: :green)
      = chalky_info_row(label: "Created at", value: l(@product.created_at, format: :long))
```

### Form Page (new/edit)

```slim
= chalky_page do |page|
  - page.with_header(title: @product.new_record? ? "New Product" : "Edit #{@product.name}")

  - page.with_body do
    = chalky_card do
      = simple_form_for @product, html: { class: "chalky-form" } do |f|
        = chalky_heading(title: "Product Information", icon_path: "fa-solid fa-box", icon_color: :blue)

        = f.input :name, placeholder: "Product name"
        = f.input :description, as: :text, input_html: { rows: 4 }
        = f.input :price, as: :decimal
        = f.input :category, collection: Category.all, include_blank: "Select a category..."
        = f.input :tags, collection: Tag.all, input_html: { multiple: true }, wrapper: :select_multiple
        = f.input :status, as: :radio_buttons, collection: Product::STATUSES
        = f.input :featured, as: :boolean, label: "Feature this product"

        .flex.gap-3.mt-6
          = f.button :submit, "Save", class: "chalky-button chalky-button--primary"
          = link_to "Cancel", products_path, class: "chalky-button chalky-button--secondary"
```

### Dashboard Page

```slim
= chalky_page do |page|
  - page.with_header(title: "Dashboard", subtitle: "Overview of your store", backlink: false)

  - page.with_body do
    / Stats row
    .grid.grid-cols-1.md:grid-cols-4.gap-4.mb-6
      = chalky_stat(label: "Total Orders", value: @total_orders, icon: "fa-solid fa-shopping-cart", icon_color: :blue)
      = chalky_stat(label: "Revenue", value: number_to_currency(@revenue), icon: "fa-solid fa-dollar-sign", icon_color: :green, trend: :up, subtitle: "+12%")
      = chalky_stat(label: "Customers", value: @customers_count, icon: "fa-solid fa-users", icon_color: :purple)
      = chalky_stat(label: "Products", value: @products_count, icon: "fa-solid fa-box", icon_color: :orange)

    / Recent orders
    = chalky_card do
      = chalky_heading(title: "Recent Orders", icon_path: "fa-solid fa-clock", icon_color: :blue)
      = chalky_grid(rows: @recent_orders, details_path: :order_path) do |grid|
        - grid.text(label: "Order #", method: :number, priority: :primary)
        - grid.text(label: "Customer", method: "customer.name")
        - grid.badge(label: "Status", method: :status, color: :blue)
        - grid.number(label: "Total", method: :total, unit: "€")
        - grid.datetime(label: "Date", method: :created_at)
```

---

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
  - dropdown.with_item(href: edit_path, icon: "fa-solid fa-pen") do
    | Edit
  - dropdown.with_item(href: delete_path, variant: :danger, method: :delete) do
    | Delete
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

⚠️ **ALWAYS use `simple_form_for`** - Never use `form_with` or `form_for`

```slim
= simple_form_for @model, html: { class: "chalky-form" } do |f|
  / Text inputs - just use f.input
  = f.input :name
  = f.input :email, as: :email
  = f.input :description, as: :text

  / Select (TomSelect auto-applied)
  = f.input :country, collection: Country::ALL, include_blank: "Select..."

  / Multiple select (must specify wrapper)
  = f.input :skills, collection: Skill::ALL, input_html: { multiple: true }, wrapper: :select_multiple

  / Radio buttons (card-style)
  = f.input :role, as: :radio_buttons, collection: Role::ALL

  / Checkboxes (pill-style)
  = f.input :interests, as: :check_boxes, collection: Interest::ALL

  / Boolean checkbox
  = f.input :terms, as: :boolean, label: "I accept the terms"

  / Date input (HTML5)
  = f.input :birth_date, as: :string, input_html: { type: "date" }

  / File upload
  = f.input :avatar, as: :file

  / Submit button
  = f.button :submit, "Save", class: "chalky-button chalky-button--primary"
```

**Available Wrappers:**
| Wrapper | When to use |
|---------|-------------|
| `:default` | Text, email, password, textarea (automatic) |
| `:select` | Single select with TomSelect (automatic) |
| `:select_multiple` | Multiple select - **must specify explicitly** |
| `:radio_buttons` | Radio button group |
| `:check_boxes` | Checkbox collection |
| `:boolean` | Single checkbox |
| `:file` | File upload |

## Available Helpers

### Layout & Assets (put in your layout file)

| Helper | Purpose |
|--------|---------|
| `chalky_layout_stylesheets` | **Load all CSS** (forms, sidebar, tabs, grid, tokens, utilities) |
| `chalky_sidebar_head_script` | Anti-FOUC script for sidebar (place BEFORE stylesheets) |
| `chalky_sidebar_layout` | Complete sidebar layout with menu |

### Page Structure

| Helper | Purpose |
|--------|---------|
| `chalky_page` | Page wrapper with header/body slots |
| `chalky_title_bar` | Standalone header bar |
| `chalky_actions` | Standalone action buttons container |
| `chalky_content` | Standalone content wrapper |

### Containers

| Helper | Purpose |
|--------|---------|
| `chalky_card` | Card container |
| `chalky_panel` | Collapsible section |
| `chalky_heading` | Section title |

### Data Display

| Helper | Purpose |
|--------|---------|
| `chalky_grid` | Data table (supports `pagy:` for pagination) |
| `chalky_pagination` | Standalone pagination |
| `chalky_info_row` | Label/value pair |
| `chalky_stat` | KPI card |

### UI Elements

| Helper | Purpose |
|--------|---------|
| `chalky_badge` | Status label |
| `chalky_alert` | Message box |
| `chalky_tooltip` | Hover tooltip |
| `chalky_hint` | Help text |

### Navigation & Buttons

| Helper | Purpose |
|--------|---------|
| `chalky_tabs` | Navigation tabs |
| `chalky_dropdown` | Dropdown menu (use `with_item` for menu items) |
| `chalky_icon_button` | Button with icon |
| `chalky_button` | Form button |
| `chalky_back` | Back navigation |

## Full Documentation

See `reference.md` in this skill folder for complete parameter documentation.
