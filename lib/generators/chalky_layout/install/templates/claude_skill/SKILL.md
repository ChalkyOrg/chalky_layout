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

### Data Display
```slim
= chalky_grid(rows: @items, details_path: :item_path) do |grid|
  - grid.text(label: "Name", method: :name, priority: :primary)
  - grid.badge(label: "Status", method: :status, color: :green)
  - grid.date(label: "Created", method: :created_at)
  - grid.action(name: "Edit", path: :edit_item_path, icon: "fa-solid fa-pen")
```

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
= chalky_tooltip(text: "Help text") do
  / Trigger element
= chalky_info_row(label: "Name", value: @user.name)
```

### Buttons
```slim
= link_to path do
  = chalky_icon_button(label: "Action", icon: "fa-solid fa-plus")

= chalky_button(label: "Save", variant: :primary)
= chalky_back(fallback_url: "/admin")
```

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

### Sidebar (Admin layouts)
```slim
= chalky_sidebar_container do
  = chalky_sidebar_section do
    = chalky_sidebar_section_header(title: "Navigation", icon_path: "M3 12l2-2m0...")
    ul.space-y-1.mt-3
      = chalky_sidebar_menu_item(path: "/admin", title: "Dashboard", icon_classes: "fa-solid fa-home")

  = chalky_sidebar_footer(
    user_name: current_user.name,
    user_email: current_user.email,
    logout_path: logout_path
  )
```

## Available Helpers

| Helper | Purpose |
|--------|---------|
| `chalky_page` | Page wrapper with header/body slots |
| `chalky_title_bar` | Standalone header bar |
| `chalky_card` | Card container |
| `chalky_panel` | Collapsible section |
| `chalky_heading` | Section title |
| `chalky_grid` | Data table |
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
| `chalky_sidebar_container` | Sidebar wrapper |
| `chalky_sidebar_section` | Sidebar card |
| `chalky_sidebar_section_header` | Sidebar header |
| `chalky_sidebar_menu_item` | Sidebar link |
| `chalky_sidebar_footer` | User profile section |

## Full Documentation

See `reference.md` in this skill folder for complete parameter documentation.
