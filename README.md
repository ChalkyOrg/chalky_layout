# ChalkyLayout

Simple Rails admin UI components with intuitive helper methods.

## Installation

Add to your Gemfile:

```ruby
gem 'chalky_layout', git: 'https://github.com/ChalkyOrg/chalky_layout.git'

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

![Page Layout](docs/screenshots/page.png)

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

![Header](docs/screenshots/header.png)

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

![Card](docs/screenshots/card.png)

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

![Panel](docs/screenshots/panel.png)

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

Section title with optional description and icon.

```slim
= chalky_heading(title: "Section Title")

= chalky_heading(title: "Users", subtitle: "Active accounts only")

= chalky_heading(title: "Settings", icon_path: "fa-solid fa-cog", icon_color: :blue)

= chalky_heading(title: "Products", icon_path: "M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4...", icon_color: :purple)
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | String | **required** | Heading title |
| `subtitle` | String | `nil` | Optional description |
| `description` | String | `nil` | Alias for subtitle |
| `icon_path` | String | `nil` | Font Awesome class (e.g., `"fa-solid fa-cog"`) or SVG path data |
| `icon_color` | Symbol | `:blue` | Icon background color (`:blue`, `:green`, `:purple`, `:orange`, `:red`, `:gray`) |
| `spacing` | String | `"mb-6"` | Margin classes |

## Buttons

### `chalky_icon_button`

Button with icon and label, typically used in header actions.

```slim
= link_to users_path do
  = chalky_icon_button(label: "Users", icon: "fa-solid fa-users")

= link_to new_user_path do
  = chalky_icon_button(label: "Add", icon: "fa-solid fa-plus")
```

![Buttons](docs/screenshots/buttons.png)

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

![Button](docs/screenshots/button.png)

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

![Back](docs/screenshots/back.png)

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

![Data Grid](docs/screenshots/grid.png)

**Grid Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `rows` | Array | **required** | Data rows to display |
| `details_path` | Symbol | `nil` | Path helper for row links |
| `variant` | Symbol | `:default` | Grid variant |
| `responsive` | Boolean | `true` | Enable responsive mode |
| `horizontal_scroll` | Boolean | `false` | Enable horizontal scroll |
| `pagy` | Pagy | `nil` | Pagy object for automatic pagination (displays pagination below grid) |

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
| `image` | Image thumbnail | `size:` (`:small`, `:medium`, `:large`) |
| `icon` | Conditional icon | `icon:` (Font Awesome class) |
| `custom` | Custom block | Block required |

**Badge Colors:** `:green`, `:red`, `:blue`, `:yellow`, `:purple`, `:orange`, `:gray`

**Column Priority:**
- `:primary` - Always visible, used as card title on mobile
- `:secondary` - Default, shown in card body on mobile
- `:optional` - Only on large screens

### Grid Actions

Add row actions with dropdown menu:

```slim
= chalky_grid(rows: @users) do |grid|
  - grid.action(name: "View", path: :user_path, icon: "fa-solid fa-eye")
  - grid.action(name: "Edit", path: :edit_user_path, icon: "fa-solid fa-pen")
  - grid.action(name: "Delete", path: :user_path, icon: "fa-solid fa-trash", data: { method: :delete, confirm: "Are you sure?" })
  - grid.text(label: "Name", method: :name, priority: :primary)
  - grid.text(label: "Email", method: :email)
```

![Grid with Actions](docs/screenshots/grid-actions.png)

**Action Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| `name` | String | Action label |
| `path` | Symbol | Route helper name (e.g., `:edit_user_path`) |
| `icon` | String | Font Awesome icon class |
| `data` | Hash | Data attributes (`:method`, `:confirm`, etc.) |
| `options[:id_method]` | Symbol | Method to get row ID (default: `:id`) |
| `options[:id_param_key]` | Symbol | Param key for ID (default: `:id`) |
| `options[:unless]` | Symbol/Proc | Condition to hide action |
| `options[:variant]` | Symbol | `:admin` or `:danger` |

### Custom Column Example

```slim
= chalky_grid(rows: @orders) do |grid|
  - grid.text(label: "ID", method: :id)
  - grid.custom(label: "Total") do |order|
    span.font-bold = number_to_currency(order.total)
  - grid.custom(label: "Actions") do |order|
    = link_to "View", admin_order_path(order)
```

### Grid with Pagination

You can add pagination to a grid by passing a Pagy object:

```slim
= chalky_grid(rows: @users, pagy: @pagy, details_path: :admin_user_path) do |grid|
  - grid.text(label: "Name", method: :name, priority: :primary)
  - grid.text(label: "Email", method: :email)
  - grid.badge(label: "Role", method: :role, color: :blue)
```

The pagination component will be automatically displayed below the grid when there are multiple pages.

### `chalky_pagination`

Standalone pagination component for use outside of grids. Requires the [Pagy](https://github.com/ddnexus/pagy) gem.

```slim
= chalky_pagination(pagy: @pagy)

/ With custom URL builder
= chalky_pagination(pagy: @pagy, url_builder: ->(page) { users_path(page: page, search: params[:search]) })
```

![Pagination](docs/screenshots/pagination.png)

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `pagy` | Pagy | **required** | Pagy object containing pagination info |
| `url_builder` | Proc | `nil` | Custom proc to build page URLs (receives page number) |

**Features:**
- First, previous, next, last page buttons
- Page number display with ellipsis for large page counts
- Responsive: shows "Page X of Y" on desktop, "X-Y of Total" on mobile
- Turbo-compatible with `data-turbo-action="replace"`
- Only renders when there are multiple pages

**Controller Setup:**
```ruby
# In your controller
include Pagy::Backend

def index
  @pagy, @users = pagy(User.all, items: 25)
end
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

![Dropdown](docs/screenshots/dropdown.png)

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `variant` | Symbol | `:admin` | Dropdown variant |
| `pop_direction` | Symbol | `:right` | Menu direction (`:right`, `:left`) |
| `css_classes` | String | `""` | Additional CSS classes |

## UI Elements

### `chalky_badge`

Colored label for status, tags, categories.

```slim
= chalky_badge(label: "Active", color: :green)
= chalky_badge(label: "Pending", color: :yellow, style: :pill)
= chalky_badge(label: "Error", color: :red, icon: "fa-solid fa-xmark")
```

![Badges](docs/screenshots/badges.png)

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | String | **required** | Badge text |
| `color` | Symbol | `:gray` | `:gray`, `:green`, `:red`, `:blue`, `:yellow`, `:orange`, `:purple` |
| `size` | Symbol | `:sm` | `:xs`, `:sm`, `:md` |
| `style` | Symbol | `:rounded` | `:rounded`, `:pill` |
| `icon` | String | `nil` | Optional Font Awesome icon |

### `chalky_stat`

KPI card for dashboards with icon, value, and optional trend.

```slim
.grid.grid-cols-4.gap-6
  = chalky_stat(label: "Total Users", value: 1234, icon: "fa-solid fa-users", icon_color: :blue)
  = chalky_stat(label: "Revenue", value: "$12,345", icon: "fa-solid fa-dollar-sign", icon_color: :green)
  = chalky_stat(label: "Growth", value: "12%", icon: "fa-solid fa-chart-line", icon_color: :purple, trend: :up, subtitle: "+5%")
  = chalky_stat(label: "Errors", value: 3, icon: "fa-solid fa-bug", icon_color: :red)
```

![Stats](docs/screenshots/stats.png)

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | String | **required** | Metric label |
| `value` | String/Number | **required** | Metric value |
| `icon` | String | `nil` | Font Awesome icon class |
| `icon_color` | Symbol | `:blue` | Icon background color |
| `subtitle` | String | `nil` | Additional text below value |
| `trend` | Symbol | `nil` | `:up`, `:down`, or `nil` |

### `chalky_tooltip`

Hover tooltip for contextual information.

```slim
= chalky_tooltip(text: "More information here") do
  i.fa-solid.fa-circle-info.text-gray-400.cursor-help

= chalky_tooltip(text: "Edit this item", position: :bottom) do
  = chalky_icon_button(label: "Edit", icon: "fa-solid fa-pen")

= chalky_tooltip(text: "Light variant", variant: :light, delay: 300) do
  span.underline Hover me
```

![Tooltips](docs/screenshots/tooltips.png)

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `text` | String | **required** | Tooltip text to display |
| `position` | Symbol | `:top` | `:top`, `:bottom`, `:left`, `:right` |
| `variant` | Symbol | `:dark` | `:dark` (black bg), `:light` (white bg with border) |
| `delay` | Integer | `0` | Delay in milliseconds before showing |

### `chalky_hint`

Small help text typically shown below form fields.

```slim
= chalky_hint(text: "Enter a valid email address")
= chalky_hint(text: "Maximum 100 characters", size: :sm)
= chalky_hint do
  | Custom hint with
  strong  bold text
```

![Hints](docs/screenshots/hints.png)

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `text` | String | `nil` | Hint text (or use block) |
| `size` | Symbol | `:xs` | `:xs`, `:sm` |
| `icon` | String | `nil` | Optional icon |

### `chalky_alert`

Info, warning, success, or error message box.

```slim
= chalky_alert(message: "Your changes have been saved", variant: :success)

= chalky_alert(title: "Warning", message: "This action cannot be undone", variant: :warning)

= chalky_alert(variant: :info, style: :left_border) do
  ul
    li First instruction
    li Second instruction

= chalky_alert(variant: :error, dismissible: true) do
  | An error occurred. Please try again.
```

![Alerts](docs/screenshots/alerts.png)

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `message` | String | `nil` | Alert message (or use block) |
| `title` | String | `nil` | Optional alert title |
| `variant` | Symbol | `:info` | `:info`, `:success`, `:warning`, `:error` |
| `style` | Symbol | `:default` | `:default`, `:left_border` |
| `icon` | String | `nil` | Custom icon (defaults by variant) |
| `dismissible` | Boolean | `false` | Show dismiss button |

### `chalky_info_row`

Label/value display pair for detail pages.

```slim
= chalky_card do
  .space-y-2
    = chalky_info_row(label: "Name", value: @user.name)
    = chalky_info_row(label: "Email", value: @user.email)
    = chalky_info_row(label: "Role", value: @user.role.humanize)
    = chalky_info_row(label: "Total", value: number_to_currency(@order.total), separator: true, bold_value: true)
```

![Info Rows](docs/screenshots/info-rows.png)

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | String | **required** | Row label |
| `value` | String | `nil` | Row value (or use block) |
| `separator` | Boolean | `false` | Add top border separator |
| `bold_value` | Boolean | `false` | Make value bold (for totals) |

### `chalky_tabs`

Navigation tabs for page sections. Typically used inside the header's navigation slot.

```slim
= chalky_page do |page|
  - page.with_header(title: "Products") do |header|
    - header.with_navigation do
      = chalky_tabs(tabs: [
        {name: "Articles", path: admin_items_path},
        {name: "Collections", path: admin_collections_path},
        {name: "Categories", path: admin_categories_path}
      ])
```

![Tabs](docs/screenshots/tabs.png)

**Tab Options:**
| Option | Type | Description |
|--------|------|-------------|
| `name` | String | Tab label (required) |
| `path` | String | Tab URL or anchor (required) |
| `icon` | String | Optional Font Awesome icon class |
| `badge` | Integer | Optional badge count (e.g., notifications) |
| `default` | Boolean | Set to true for default active anchor tab |
| `active_param` | String | Query param name for active detection |
| `active_value` | String | Query param value for active detection |

**Smart Tab Behavior:**
- **Anchor tabs** (`#section`): Client-side switching with Stimulus, no page reload
- **URL tabs** (`/admin/users`): Standard Rails navigation with active state detection

```slim
/ Mixed example: anchors + URLs
= chalky_tabs(tabs: [
  {name: "Overview", path: "#overview", default: true},  / Anchor - JS switching
  {name: "Details", path: "#details"},                   / Anchor - JS switching
  {name: "Settings", path: admin_settings_path}          / URL - page navigation
])
```

## Sidebar Navigation

Complete sidebar system for admin layouts with mobile support, collapsible sections, menu items, and user profile.

### `chalky_sidebar_layout` (Recommended)

Full-featured sidebar layout with built-in mobile and desktop support. This is the recommended way to create admin layouts.

**Features:**
- Mobile: Hamburger button, overlay, slide-in menu from right
- Desktop: Fixed sidebar with collapse/expand toggle
- localStorage persistence for collapsed state
- Smooth transitions and animations

```slim
= chalky_sidebar_layout(menu_title: "Menu") do |layout|
  - layout.with_header do
    a.flex.items-center.gap-2 href="/"
      .w-8.h-8.bg-blue-600.rounded-lg.flex.items-center.justify-center
        span.text-white.font-bold C
      span.text-lg.font-semibold.text-gray-900 Chalky

  - layout.with_section(title: "Boutique", description: "Gestion du magasin", icon_path: "M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z", icon_color: :blue) do |section|
    - section.with_menu_item(path: "/admin", title: "Dashboard", icon_classes: "fa-solid fa-gauge")
    - section.with_menu_item(path: "/admin/orders", title: "Commandes", icon_classes: "fa-solid fa-book")
    - section.with_menu_item(path: "/admin/products", title: "Produits", icon_classes: "fa-solid fa-box")

  - layout.with_section(title: "Utilisateurs", icon_path: "M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0z", icon_color: :green) do |section|
    - section.with_menu_item(path: "/admin/users", title: "Utilisateurs", icon_classes: "fa-solid fa-users")

  - layout.with_footer(user_name: current_user.name, user_email: current_user.email, logout_path: logout_path) do |footer|
    - footer.with_menu_item(path: profile_path, title: "Mon profil", icon_classes: "fa-solid fa-user")

  = yield
```

![Sidebar Layout](docs/screenshots/sidebar-layout.png)

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `menu_title` | String | `"Menu"` | Title shown in mobile menu header |

**Slots:**

| Slot | Description |
|------|-------------|
| `with_header` | Logo/branding area at top of sidebar |
| `with_section` | Navigation section with menu items (can have multiple) |
| `with_footer` | User profile and logout at bottom |

**Section Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | String | **required** | Section title |
| `icon_path` | String | **required** | SVG path data for the icon |
| `description` | String | `nil` | Optional description below title |
| `icon_color` | Symbol | `:blue` | `:blue`, `:green`, `:purple`, `:orange`, `:red`, `:gray`, `:indigo` |

**Footer Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `user_name` | String | **required** | User's display name |
| `user_email` | String | **required** | User's email address |
| `logout_path` | String | **required** | Logout URL |
| `avatar_url` | String | `nil` | Avatar image URL (shows initials if nil) |
| `role_label` | String | `nil` | Optional role badge text |
| `role_color` | Symbol | `:gray` | Role badge color |
| `profile_path` | String | `nil` | Optional profile page URL |
| `logout_method` | Symbol | `:delete` | HTTP method for logout |

### `chalky_sidebar_head_script`

Script to prevent FOUC (Flash of Unstyled Content) for sidebar collapsed state. Must be placed in the `<head>` section of your layout.

```slim
head
  / ... other head content ...
  = chalky_sidebar_head_script
```

This script reads localStorage before rendering to apply the collapsed state immediately.

### Complete Layout Example

```slim
doctype html
html.h-full
  head
    title Admin
    = csrf_meta_tags
    = chalky_sidebar_head_script
    = stylesheet_link_tag "application"
    = javascript_importmap_tags

  body.h-full
    = chalky_sidebar_layout(menu_title: "Menu") do |layout|
      - layout.with_header do
        = image_tag "logo.png", class: "h-8"

      - layout.with_section(title: "Navigation", icon_path: "M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6", icon_color: :blue) do |section|
        - section.with_menu_item(path: admin_root_path, title: "Dashboard", icon_classes: "fa-solid fa-gauge")
        - section.with_menu_item(path: admin_orders_path, title: "Commandes", icon_classes: "fa-solid fa-shopping-cart")
        - section.with_menu_item(path: admin_products_path, title: "Produits", icon_classes: "fa-solid fa-box")

      - layout.with_footer(user_name: current_user.name, user_email: current_user.email, logout_path: logout_path, role_label: "Admin", role_color: :blue) do |footer|
        - footer.with_menu_item(path: profile_path, title: "Profil", icon_classes: "fa-solid fa-user")
        - footer.with_menu_item(path: settings_path, title: "Paramètres", icon_classes: "fa-solid fa-cog")

      = yield
```

---

## Sidebar Menu Items

Menu items are added via the `with_menu_item` method on sections and footers within `chalky_sidebar_layout`.

```slim
- layout.with_section(title: "Navigation", icon_path: "...", icon_color: :blue) do |section|
  - section.with_menu_item(path: admin_orders_path, title: "Commandes", icon_classes: "fa-solid fa-shopping-cart")
  - section.with_menu_item(path: admin_products_path, title: "Produits", icon_path: "M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4")
```

**Menu Item Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `path` | String | **required** | Link destination URL |
| `title` | String | **required** | Menu item label |
| `icon_classes` | String | `nil` | Font Awesome classes (e.g., `"fa-solid fa-book"`) |
| `icon_path` | String | `nil` | SVG path data (alternative to icon_classes) |
| `active` | Boolean/nil | `nil` | Override active state (`nil` = auto-detect from URL) |

**Icon Options:**
- Use `icon_classes` for Font Awesome icons: `"fa-solid fa-shopping-cart"`
- Use `icon_path` for custom SVG icons: `"M20 7l-8-4-8 4m16 0l-8 4..."`
- If both provided, `icon_path` takes precedence

**Icon Colors (for sections):** `:blue`, `:green`, `:purple`, `:orange`, `:red`, `:gray`, `:indigo`

## Requirements

- Rails 7.0+
- Ruby 3.0+
- ViewComponent gem
- Slim templates
- Tailwind CSS
- Stimulus.js
- Font Awesome (for icons)

## Post-Installation Setup

### JavaScript Setup (Required)

Add the following line to your `app/javascript/application.js`:

```javascript
import "chalky_layout"
```

This single import will automatically register all Stimulus controllers from the gem with the correct names. No need to copy files or register controllers manually.

### Tailwind Setup (Required)

Add the gem's component path to your Tailwind `content` array in `tailwind.config.js`:

```javascript
module.exports = {
  content: [
    // ... your paths
    // Add chalky_layout components (adjust path based on your bundler)
    "./node_modules/chalky_layout/**/*.{slim,rb}",
    // Or for bundled gems:
    `${process.env.GEM_HOME}/gems/chalky_layout-*/app/**/*.{slim,rb}`
  ],
  // ...
}
```

### Color Tokens (Optional)

Add the required color tokens to your Tailwind theme if you want to customize the default colors

### Font Awesome

Include Font Awesome for icons:

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
| `chalky_heading` | Section title with optional icon |
| `chalky_grid` | Responsive data table (supports `pagy:` for pagination) |
| `chalky_pagination` | Standalone pagination component (requires Pagy gem) |
| `chalky_dropdown` | Dropdown menu |
| `chalky_icon_button` | Button with icon |
| `chalky_button` | Form button |
| `chalky_back` | Back navigation |
| `chalky_badge` | Colored status/tag label |
| `chalky_stat` | KPI card for dashboards |
| `chalky_tooltip` | Hover tooltip |
| `chalky_hint` | Small help text |
| `chalky_alert` | Info/warning/error message box |
| `chalky_info_row` | Label/value display pair |
| `chalky_tabs` | Navigation tabs for page sections |
| `chalky_sidebar_layout` | Complete sidebar layout with mobile/desktop support (recommended) |
| `chalky_sidebar_head_script` | Anti-FOUC script for sidebar (place in `<head>`) |

## License

MIT License
