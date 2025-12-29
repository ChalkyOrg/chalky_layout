# Project Instructions for Claude

## UI Components & Frontend

This project uses **ChalkyLayout** for all UI components and frontend work.

### ⚠️ Critical Rules

1. **Forms**: ALWAYS use `simple_form_for` - NEVER use `form_with` or `form_for`
2. **Components**: Prefer `chalky_*` helpers when a component exists (cards, grids, buttons, etc.)
3. **Templates**: Use Slim syntax for new views
4. **Layout**: Use `chalky_layout_stylesheets` to load all CSS in the layout's `<head>`

### Layout Configuration

The application layout should include:

```slim
head
  = chalky_sidebar_head_script          /! FIRST - Anti-FOUC script
  = stylesheet_link_tag "tailwind"      /! Tailwind CSS
  = chalky_layout_stylesheets           /! All ChalkyLayout CSS
  = javascript_importmap_tags
```

### When Working on Frontend

**ALWAYS read `.claude/skills/chalky-layout/SKILL.md` first** - it contains:
- Layout configuration examples
- Page templates (Index, Show, Form, Dashboard) you can copy
- Anti-patterns to avoid
- All available helpers

### Quick Examples

```slim
/ Page with header and grid
= chalky_page do |page|
  - page.with_header(title: "Users") do |header|
    - header.with_actions do
      = link_to new_user_path do
        = chalky_icon_button(label: "Add", icon: "fa-solid fa-plus")
  - page.with_body do
    = chalky_card do
      = chalky_grid(rows: @users, details_path: :user_path) do |grid|
        - grid.text(label: "Name", method: :name, priority: :primary)
        - grid.text(label: "Email", method: :email)

/ Form - ALWAYS use simple_form_for
= simple_form_for @user, html: { class: "chalky-form" } do |f|
  = f.input :name
  = f.input :country, collection: Country::ALL, include_blank: "Select..."
  = f.button :submit, "Save", class: "chalky-button chalky-button--primary"
```

### Documentation

- **SKILL.md**: Rules, templates, quick reference
- **reference.md**: Complete API with all parameters
