# ChalkyLayout

Simple Rails admin UI components with intuitive helper methods.

## Installation

Add to your Gemfile:

```ruby
gem 'chalky_layout', path: '../chalky_layout'

# Required dependencies
gem 'view_component'
gem 'slim-rails'
```

Then run:

```bash
bundle install
rails generate chalky_layout:install
```

## Quick Start

Helper methods are automatically available in all views:

```slim
= chalky_page do |page|
  - page.with_header(title: "Utilisateurs", subtitle: "Gestion des comptes") do |header|
    - header.with_actions do
      = link_to new_user_path do
        = chalky_icon_button(label: "Nouveau", icon: "fa-solid fa-plus")

  - page.with_body do
    = chalky_card do
      = chalky_heading(title: "Liste des utilisateurs")
      = chalky_grid(rows: @users) do |grid|
        - grid.text(label: "Nom", method: :name, priority: :primary)
        - grid.text(label: "Email", method: :email)
        - grid.badge(label: "Rôle", method: :role, color: :blue)
```

## Page Layout

### `chalky_page`

Main page wrapper with header and body slots.

```slim
= chalky_page do |page|
  - page.with_header(title: "Page Title", subtitle: "Optional subtitle") do |header|
    - header.with_actions do
      / Action buttons here

  - page.with_body do
    / Main content here
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | String | `nil` | Page title (used if no header slot) |
| `subtitle` | String | `nil` | Page subtitle |
| `css_classes` | String | `""` | Additional CSS classes |
| `data_attributes` | Hash | `{}` | Data attributes |

### Header Slot

The header is a sticky title bar with back button, title, subtitle, and actions.

```slim
- page.with_header(title: "Users", subtitle: "Manage accounts", backlink: true) do |header|
  - header.with_actions do
    = link_to new_user_path do
      = chalky_icon_button(label: "Add", icon: "fa-solid fa-plus")
    = link_to export_users_path do
      = chalky_icon_button(label: "Export", icon: "fa-solid fa-download")
```

**Header Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | String | `nil` | Header title |
| `subtitle` | String | `nil` | Header subtitle |
| `backlink` | Boolean | `true` | Show back button |
| `backlink_fallback_url` | String | `"/"` | Fallback URL if no browser history |
| `spacing` | String | `"mb-0"` | Margin classes |

### Body Slot

The body is the main content area with optional full-width mode.

```slim
- page.with_body(full_width: false) do
  = chalky_card do
    / Content here
```

**Body Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `full_width` | Boolean | `false` | Use full width layout |

### Standalone Components

For custom layouts, use standalone helpers:

```slim
/ Custom layout without chalky_page
= chalky_title_bar(title: "Custom Page", backlink: false) do |header|
  - header.with_actions do
    = link_to path do
      = chalky_icon_button(label: "Action", icon: "fa-solid fa-cog")

= chalky_content(full_width: true) do
  / Full-width content

= chalky_actions(layout: :center) do
  = link_to path do
    = chalky_icon_button(label: "Centered Action", icon: "fa-solid fa-star")
```

## Containers

### `chalky_card`

Simple container with shadow and border.

```slim
= chalky_card do
  p Content inside card

= chalky_card(spacing: "mb-2", css_classes: "bg-blue-50") do
  p Custom spacing and classes
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `spacing` | String | `"mb-4 md:mb-8"` | Margin classes |
| `css_classes` | String | `""` | Additional CSS classes |
| `data_attributes` | Hash | `{}` | Data attributes |

### `chalky_panel`

Collapsible section with icon.

```slim
= chalky_panel(title: "Settings", icon: "fa-solid fa-cog", icon_color: :blue) do
  p Panel content here

= chalky_panel(title: "Advanced", icon: "fa-solid fa-wrench", open: false) do
  p Initially collapsed
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | String | **required** | Panel title |
| `icon` | String | **required** | Font Awesome icon class |
| `subtitle` | String | `nil` | Optional subtitle |
| `icon_color` | Symbol | `:blue` | Icon color (`:blue`, `:green`, `:red`, etc.) |
| `dom_id` | String | `nil` | DOM ID for the panel |
| `open` | Boolean | `true` | Initially open |

### `chalky_heading`

Section title with optional description.

```slim
= chalky_heading(title: "Section Title")

= chalky_heading(title: "Users", subtitle: "Active accounts only")
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | String | **required** | Heading title |
| `subtitle` | String | `nil` | Optional description |
| `description` | String | `nil` | Alias for subtitle |

## Buttons

### `chalky_icon_button`

Button with icon and label, typically used in header actions.

```slim
= link_to users_path do
  = chalky_icon_button(label: "Users", icon: "fa-solid fa-users")

= link_to new_user_path do
  = chalky_icon_button(label: "Add", icon: "fa-solid fa-plus")
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | String | **required** | Button label |
| `icon` | String | `nil` | Font Awesome icon class |

### `chalky_button`

Form submit button.

```slim
= chalky_button(label: "Save")

= chalky_button(label: "Delete", variant: :danger)
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | String | `nil` | Button label |
| `variant` | Symbol | `:primary` | Button style |
| `type` | Symbol | `:submit` | Button type |

### `chalky_back`

Back navigation button with JavaScript history support.

```slim
= chalky_back(fallback_url: "/admin")
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `fallback_url` | String | `"/"` | URL if no browser history |

## Data Display

### `chalky_grid`

Responsive data table with multiple column types.

```slim
= chalky_grid(rows: @users, details_path: :admin_user_path) do |grid|
  - grid.text(label: "Name", method: :name, priority: :primary)
  - grid.text(label: "Email", method: :email, priority: :secondary)
  - grid.badge(label: "Role", method: :role, color: :blue)
  - grid.boolean(label: "Active", method: :active?)
  - grid.date(label: "Created", method: :created_at, priority: :optional)
```

**Grid Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `rows` | Array | **required** | Data rows to display |
| `details_path` | Symbol | `nil` | Path helper for row links |
| `variant` | Symbol | `:default` | Grid variant |
| `responsive` | Boolean | `true` | Enable responsive mode |
| `horizontal_scroll` | Boolean | `false` | Enable horizontal scroll |

**Column Types:**

| Type | Description | Extra Parameters |
|------|-------------|------------------|
| `text` | Plain text | - |
| `badge` | Colored badge | `color:` |
| `number` | Formatted number | `unit:` |
| `date` | Date format | - |
| `datetime` | Date and time | - |
| `boolean` | Yes/No indicator | - |
| `link` | Clickable link | `path:` |
| `custom` | Custom block | Block required |

**Badge Colors:** `:green`, `:red`, `:blue`, `:yellow`, `:purple`, `:orange`, `:gray`

**Column Priority:**
- `:primary` - Always visible
- `:secondary` - Hidden on mobile
- `:optional` - Only on large screens

### Custom Column Example

```slim
= chalky_grid(rows: @orders) do |grid|
  - grid.text(label: "ID", method: :id)
  - grid.custom(label: "Total") do |order|
    span.font-bold = number_to_currency(order.total)
  - grid.custom(label: "Actions") do |order|
    = link_to "View", admin_order_path(order)
```

## Interactive

### `chalky_dropdown`

Dropdown menu component.

```slim
= chalky_dropdown(pop_direction: :left) do |dropdown|
  - dropdown.with_trigger do
    = chalky_icon_button(label: "Options", icon: "fa-solid fa-ellipsis-v")
  - dropdown.with_menu do
    = link_to "Edit", edit_path, class: "dropdown-item"
    = link_to "Delete", delete_path, class: "dropdown-item text-red-600"
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `variant` | Symbol | `:admin` | Dropdown variant |
| `pop_direction` | Symbol | `:right` | Menu direction (`:right`, `:left`) |
| `css_classes` | String | `""` | Additional CSS classes |

## Requirements

- Rails 7.0+
- Ruby 3.0+
- ViewComponent gem
- Slim templates
- Tailwind CSS
- Stimulus.js
- Font Awesome (for icons)

## Post-Installation Setup

### 1. Register Stimulus Controllers

Add to `app/javascript/controllers/index.js`:

```javascript
import DropdownController from './dropdown_controller'
import GridController from './grid_controller'
import BackController from './back_controller'
import StopPropagationController from './stop_propagation_controller'

application.register('dropdown', DropdownController)
application.register('grid', GridController)
application.register('back', BackController)
application.register('stop-propagation', StopPropagationController)
```

### 2. Configure Tailwind

Add to `tailwind.config.js`:

```javascript
module.exports = {
  content: [
    './app/views/**/*.{html,html.erb,erb,slim}',
    './app/components/**/*.{rb,slim,html.erb}',
    // ChalkyLayout gem components
    './vendor/bundle/ruby/*/gems/chalky_layout-*/app/components/**/*.{rb,slim}',
  ],
  theme: {
    extend: {
      colors: {
        primary: '#3b82f6',
        secondary: '#6b7280',
        light: '#f9fafb',
        content: '#374151',
        contrast: '#111827',
        midgray: '#6b7280',
        contour: '#e5e7eb',
      }
    }
  }
}
```

### 3. Include Font Awesome

```html
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
```

## Helper Reference

| Helper | Description |
|--------|-------------|
| `chalky_page` | Page wrapper with `with_header` and `with_body` slots |
| `chalky_title_bar` | Standalone title bar |
| `chalky_actions` | Standalone action buttons container |
| `chalky_content` | Standalone content wrapper |
| `chalky_card` | Simple card container |
| `chalky_panel` | Collapsible section with icon |
| `chalky_heading` | Section title |
| `chalky_grid` | Responsive data table |
| `chalky_dropdown` | Dropdown menu |
| `chalky_icon_button` | Button with icon |
| `chalky_button` | Form button |
| `chalky_back` | Back navigation |

## License

MIT License
