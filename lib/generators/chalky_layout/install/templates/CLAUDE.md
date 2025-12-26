# Project Instructions for Claude

## UI Components & Frontend

This project uses **ChalkyLayout** for all UI components and frontend work.

### When to Consult the ChalkyLayout Skill

Always read `.claude/skills/chalky-layout/SKILL.md` when working on:

- **Views & Templates**: Creating or modifying `.html.slim` or `.html.erb` files
- **Page Layouts**: Headers, content sections, sidebars, navigation
- **Components**: Cards, panels, buttons, badges, alerts, tooltips
- **Data Display**: Tables, grids, lists with `chalky_grid`
- **Forms**: Building forms with Simple Form and TomSelect
- **Styling**: Tailwind CSS with Chalky design tokens

### Key Rules

1. **Use Chalky Helpers**: Always use `chalky_*` helpers instead of raw HTML
2. **Slim Templates**: Use Slim syntax for new views
3. **Simple Form**: Use Simple Form with Chalky wrappers for all forms
4. **Design Tokens**: Use CSS custom properties (`--chalky-*`) for theming

### Quick Examples

```slim
/ Page with header
= chalky_page do |page|
  - page.with_header(title: "Users") do |header|
    - header.with_actions do
      = link_to new_user_path do
        = chalky_icon_button(label: "Add", icon: "fa-solid fa-plus")
  - page.with_body do
    = chalky_grid(rows: @users) do |grid|
      - grid.text(label: "Name", method: :name)

/ Form with Simple Form
= simple_form_for @user, html: { class: "chalky-form" } do |f|
  = f.input :name
  = f.input :country, collection: Country::ALL, include_blank: "Select..."
  = f.button :submit, "Save", class: "chalky-button chalky-button--primary"
```

### Full Documentation

See `.claude/skills/chalky-layout/reference.md` for complete API documentation.
