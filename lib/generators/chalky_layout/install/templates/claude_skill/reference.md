# Chalky Layout - Complete API Reference

## Page Layout

### `chalky_page`

Main page wrapper with header and body slots.

```slim
= chalky_page do |page|
  - page.with_header(title: "Title", subtitle: "Subtitle") do |header|
    - header.with_actions do
      / Action buttons
    - header.with_navigation do
      / Navigation tabs
  - page.with_body(full_width: false) do
    / Main content
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | String | `nil` | Page title |
| `subtitle` | String | `nil` | Page subtitle |
| `css_classes` | String | `""` | Additional CSS classes |
| `data_attributes` | Hash | `{}` | Data attributes |

**Header Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | String | `nil` | Header title |
| `subtitle` | String | `nil` | Header subtitle |
| `backlink` | Boolean | `true` | Show back button |
| `backlink_fallback_url` | String | `"/"` | Fallback URL |
| `spacing` | String | `"mb-0"` | Margin classes |

**Body Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `full_width` | Boolean | `false` | Use full width layout |

### `chalky_title_bar`

Standalone title bar (use outside chalky_page).

```slim
= chalky_title_bar(title: "Page", backlink: false) do |header|
  - header.with_actions do
    / Buttons
```

### `chalky_content`

Standalone content wrapper.

```slim
= chalky_content(full_width: true) do
  / Content
```

### `chalky_actions`

Standalone actions container.

```slim
= chalky_actions(layout: :center) do
  / Buttons
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `layout` | Symbol | `:right` | `:right`, `:left`, `:center` |

---

## Containers

### `chalky_card`

Simple card container with shadow and border.

```slim
= chalky_card(spacing: "mb-4", css_classes: "bg-blue-50") do
  / Content
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
= chalky_panel(title: "Settings", icon: "fa-solid fa-cog", icon_color: :blue, open: true) do
  / Content
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | String | **required** | Panel title |
| `icon` | String | **required** | Font Awesome icon class |
| `subtitle` | String | `nil` | Optional subtitle |
| `icon_color` | Symbol | `:blue` | `:blue`, `:green`, `:red`, `:purple`, `:orange`, `:gray` |
| `dom_id` | String | `nil` | DOM ID |
| `open` | Boolean | `true` | Initially open |

### `chalky_heading`

Section title with optional description and icon.

```slim
= chalky_heading(title: "Section", subtitle: "Description", icon_path: "fa-solid fa-cog", icon_color: :blue)
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | String | **required** | Heading title |
| `subtitle` | String | `nil` | Optional description |
| `description` | String | `nil` | Alias for subtitle |
| `icon_path` | String | `nil` | Font Awesome class or SVG path |
| `icon_color` | Symbol | `:blue` | Icon background color |
| `spacing` | String | `"mb-6"` | Margin classes |

---

## Buttons

### `chalky_icon_button`

Button with icon for header actions. Must be wrapped in a link.

```slim
= link_to path do
  = chalky_icon_button(label: "Add", icon: "fa-solid fa-plus")
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | String | **required** | Button label |
| `icon` | String | `nil` | Font Awesome icon class |

### `chalky_button`

Form submit button with multiple variants.

```slim
/ Primary (default)
= chalky_button(label: "Save")

/ Secondary
= chalky_button(label: "Cancel", variant: :secondary)

/ Success
= chalky_button(label: "Confirm", variant: :success)

/ Danger
= chalky_button(label: "Delete", variant: :danger)

/ With icon
= chalky_button(variant: :primary, icon_path: "M5 13l4 4L19 7") do
  | Save Changes

/ Different sizes
= chalky_button(label: "Small", size: :sm)
= chalky_button(label: "Large", size: :lg)
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | String | `nil` | Button label (or use block) |
| `variant` | Symbol | `:primary` | `:primary`, `:secondary`, `:success`, `:danger` |
| `size` | Symbol | `:md` | `:sm`, `:md`, `:lg` |
| `icon_path` | String | `nil` | SVG path for button icon |
| `css_classes` | String | `""` | Additional CSS classes |
| `type` | String | `"button"` | HTML button type |
| `data` | Hash | `{}` | Data attributes |

**Variant Styles:**
| Variant | Description |
|---------|-------------|
| `:primary` | Blue background - main actions |
| `:secondary` | Gray background - cancel/secondary |
| `:success` | Green background - confirmation |
| `:danger` | Red background - destructive |

### `chalky_back`

Back navigation with JS history support.

```slim
= chalky_back(fallback_url: "/admin")
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `fallback_url` | String | `"/"` | Fallback URL if no history |

---

## Data Display

### `chalky_grid`

Responsive data table with multiple column types.

```slim
= chalky_grid(rows: @users, details_path: :user_path) do |grid|
  - grid.text(label: "Name", method: :name, priority: :primary)
  - grid.text(label: "Email", method: :email, priority: :secondary)
  - grid.badge(label: "Status", method: :status, color: :green)
  - grid.number(label: "Count", method: :count, unit: "items")
  - grid.boolean(label: "Active", method: :active?)
  - grid.date(label: "Created", method: :created_at)
  - grid.datetime(label: "Updated", method: :updated_at)
  - grid.link(label: "Website", method: :url, path: :website_path)
  - grid.image(label: "Photo", method: :avatar, size: :small)
  - grid.icon(method: :featured?, icon: "fa-solid fa-star")
  - grid.custom(label: "Custom") do |row|
    span = row.custom_field
  - grid.action(name: "Edit", path: :edit_user_path, icon: "fa-solid fa-pen")
  - grid.action(name: "Delete", path: :user_path, icon: "fa-solid fa-trash", data: { turbo_method: :delete, turbo_confirm: "Sure?" })
```

**Grid Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `rows` | Array | **required** | Data to display |
| `details_path` | Symbol | `nil` | Path helper for row links |
| `variant` | Symbol | `:admin` | Grid style (`:default`, `:simple`, `:admin`) |
| `responsive` | Boolean | `true` | Enable responsive mode |
| `horizontal_scroll` | Boolean | `false` | Enable horizontal scroll |
| `pagy` | Pagy | `nil` | Pagy object for automatic pagination |
| `details_path_id_method` | Symbol | `:id` | Method to get row ID for links |
| `row_count_key` | Symbol | `nil` | Method for row count display |
| `details_path_attributes` | Hash | `{}` | Extra attributes for row links |
| `css_classes` | String | `""` | Additional CSS classes for table |
| `bulk_selection` | Boolean | `false` | Enable checkbox selection |
| `row_data_attributes` | Proc | `nil` | Proc returning data attrs per row |
| `row_classes_proc` | Proc | `nil` | Proc returning CSS classes per row |
| `index_badge_proc` | Proc | `nil` | Proc returning badge classes per row |

**Column Types - Basic:**
| Type | Description | Extra Parameters |
|------|-------------|------------------|
| `text` | Plain text display | `priority:` |
| `badge` | Colored status badge | `color:` |
| `number` | Formatted number with optional unit | `unit:` |
| `boolean` | Yes/No indicator (check/cross icons) | - |
| `icon` | Conditional icon display | `icon:` (Font Awesome class) |
| `image` | Image thumbnail (ActiveStorage) | `size:` (`:small`, `:medium`, `:large`) |
| `custom` | Custom block for full control | Block required |

**Column Types - Date/Time:**
| Type | Description | Extra Parameters |
|------|-------------|------------------|
| `date` | Date format (I18n localized) | `formatted_as:` (`:default`, `:short`, `:long`) |
| `datetime` | Date and time | `formatted_as:` (`:with_time`, `:relative`, `:default`) |

**Column Types - Interactive:**
| Type | Description | Extra Parameters |
|------|-------------|------------------|
| `link` | Clickable link to another page | `path:` (route helper symbol) |
| `select` | Select/dropdown column | `data_type:` (`:enumerize` for Enumerize gem) |
| `formula` | Calculated/formula column | - |
| `modal_data` | Link opening a modal | `path:` (route helper symbol) |
| `project_files` | File attachments display | - |
| `price_range` | Price range display | - |
| `status_icon` | Status indicator icon | - |
| `stock_management` | Stock +/- buttons | - |

**Column Types - Associations:**
| Type | Description | Extra Parameters |
|------|-------------|------------------|
| `references` | Display referenced records | `formatted_as:` |
| `users` | Display user avatars/names | - |
| `lookups` | Lookup field display | - |

**Column Priority:**
- `:primary` - Always visible, card title on mobile
- `:secondary` - Default, card body on mobile
- `:optional` - Only on large screens

**Badge/Icon Colors:** `:green`, `:red`, `:blue`, `:yellow`, `:purple`, `:orange`, `:gray`

**Nested Attribute Access:**
```slim
- grid.text(label: "Customer", method: "user.full_name")
- grid.text(label: "City", method: "address.city")
```

**Using Procs for Dynamic Values:**
```slim
- grid.text(label: "Total", method: ->(order) { number_to_currency(order.total) })
```

**Action Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| `name` | String | Action label |
| `path` | Symbol | Route helper (e.g., `:edit_user_path`) |
| `icon` | String | Font Awesome class |
| `data` | Hash | Data attributes |
| `options[:id_method]` | Symbol | Method to get row ID (default: `:id`) |
| `options[:id_param_key]` | Symbol | Param key for ID (default: `:id`) |
| `options[:unless]` | Symbol/Proc | Condition to hide action |
| `options[:variant]` | Symbol | `:admin` or `:danger` |

**Advanced Grid Examples:**

Custom row styling:
```slim
= chalky_grid(rows: @orders, row_classes_proc: ->(row) { row.urgent? ? "bg-red-50" : "" }) do |grid|
  - grid.text(label: "Order", method: :number)
```

Custom row data attributes:
```slim
= chalky_grid(rows: @items, row_data_attributes: ->(row) { { id: row.id, category: row.category } }) do |grid|
  - grid.text(label: "Name", method: :name)
```

### `chalky_pagination`

Standalone pagination component. Requires the [Pagy](https://github.com/ddnexus/pagy) gem.

```slim
= chalky_pagination(pagy: @pagy)

/ With custom URL builder (preserves query params)
= chalky_pagination(pagy: @pagy, url_builder: ->(page) { users_path(page: page, search: params[:search]) })
```

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

---

## Interactive

### `chalky_dropdown`

Dropdown menu.

```slim
= chalky_dropdown(pop_direction: :left) do |dropdown|
  - dropdown.with_trigger do
    = chalky_icon_button(label: "Menu", icon: "fa-solid fa-ellipsis-v")
  - dropdown.with_menu do
    = link_to "Edit", edit_path, class: "dropdown-item"
    = link_to "Delete", delete_path, class: "dropdown-item text-red-600"
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `variant` | Symbol | `:admin` | Dropdown variant |
| `pop_direction` | Symbol | `:right` | `:right`, `:left` |
| `css_classes` | String | `""` | Additional CSS classes |

### `chalky_tabs`

Navigation tabs.

```slim
= chalky_tabs(tabs: [
  {name: "Tab 1", path: path1, icon: "fa-solid fa-home"},
  {name: "Tab 2", path: path2, badge: 5},
  {name: "Anchor", path: "#section", default: true}
])
```

**Tab Options:**
| Option | Type | Description |
|--------|------|-------------|
| `name` | String | Tab label (required) |
| `path` | String | URL or anchor (required) |
| `icon` | String | Font Awesome class |
| `badge` | Integer | Badge count |
| `default` | Boolean | Default active for anchors |

---

## UI Elements

### `chalky_badge`

Colored status label.

```slim
= chalky_badge(label: "Active", color: :green, style: :pill, icon: "fa-solid fa-check")
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | String | **required** | Badge text |
| `color` | Symbol | `:gray` | `:gray`, `:green`, `:red`, `:blue`, `:yellow`, `:orange`, `:purple` |
| `size` | Symbol | `:sm` | `:xs`, `:sm`, `:md` |
| `style` | Symbol | `:rounded` | `:rounded`, `:pill` |
| `icon` | String | `nil` | Font Awesome icon |

### `chalky_stat`

KPI card for dashboards.

```slim
= chalky_stat(label: "Users", value: 1234, icon: "fa-solid fa-users", icon_color: :blue, trend: :up, subtitle: "+5%")
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | String | **required** | Metric label |
| `value` | String/Number | **required** | Metric value |
| `icon` | String | `nil` | Font Awesome class |
| `icon_color` | Symbol | `:blue` | Icon background color |
| `subtitle` | String | `nil` | Additional text |
| `trend` | Symbol | `nil` | `:up`, `:down` |

### `chalky_tooltip`

Hover tooltip with HTML content support.

```slim
/ Simple text tooltip
= chalky_tooltip(position: :top) do |tooltip|
  - tooltip.with_trigger do
    i.fa-solid.fa-circle-info
  - tooltip.with_tooltip_content do
    | Help text

/ Rich HTML tooltip
= chalky_tooltip(position: :bottom, variant: :light) do |tooltip|
  - tooltip.with_trigger do
    = chalky_icon_button(label: "Info", icon: "fa-solid fa-info")
  - tooltip.with_tooltip_content do
    .space-y-2
      .font-bold Title
      p Rich HTML content with images, lists, etc.
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `position` | Symbol | `:top` | `:top`, `:bottom`, `:left`, `:right` |
| `variant` | Symbol | `:dark` | `:dark`, `:light` |
| `delay` | Integer | `0` | Delay in ms |

**Slots:**
| Slot | Description |
|------|-------------|
| `with_trigger` | Element that triggers the tooltip on hover (required) |
| `with_tooltip_content` | Tooltip content - can be text or rich HTML (required) |

### `chalky_hint`

Small help text.

```slim
= chalky_hint(text: "Maximum 100 characters", size: :xs)
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `text` | String | `nil` | Hint text (or use block) |
| `size` | Symbol | `:xs` | `:xs`, `:sm` |
| `icon` | String | `nil` | Optional icon |

### `chalky_alert`

Message box.

```slim
= chalky_alert(message: "Success!", variant: :success, dismissible: true)
= chalky_alert(title: "Warning", message: "Careful!", variant: :warning, style: :left_border)
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `message` | String | `nil` | Alert message (or block) |
| `title` | String | `nil` | Alert title |
| `variant` | Symbol | `:info` | `:info`, `:success`, `:warning`, `:error` |
| `style` | Symbol | `:default` | `:default`, `:left_border` |
| `icon` | String | `nil` | Custom icon |
| `dismissible` | Boolean | `false` | Show dismiss button |

### `chalky_info_row`

Label/value display pair.

```slim
= chalky_info_row(label: "Name", value: @user.name)
= chalky_info_row(label: "Total", value: number_to_currency(total), separator: true, bold_value: true)
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | String | **required** | Row label |
| `value` | String | `nil` | Row value (or block) |
| `separator` | Boolean | `false` | Top border |
| `bold_value` | Boolean | `false` | Bold value |

---

## Sidebar Components

### `chalky_sidebar_layout` (Recommended)

Complete sidebar layout with mobile and desktop support.

```slim
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

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `menu_title` | String | `"Menu"` | Title shown in mobile menu header |

**Slots:**
| Slot | Description |
|------|-------------|
| `with_header` | Logo/branding area |
| `with_section` | Navigation section (can have multiple) |
| `with_footer` | User profile and logout |

**Section Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | String | **required** | Section title |
| `icon_path` | String | **required** | SVG path data |
| `description` | String | `nil` | Optional description |
| `icon_color` | Symbol | `:blue` | `:blue`, `:green`, `:purple`, `:orange`, `:red`, `:gray`, `:indigo` |

**Footer Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `user_name` | String | **required** | Display name |
| `user_email` | String | **required** | Email |
| `logout_path` | String | **required** | Logout URL |
| `avatar_url` | String | `nil` | Avatar image |
| `role_label` | String | `nil` | Role badge |
| `role_color` | Symbol | `:gray` | Badge color |
| `profile_path` | String | `nil` | Profile URL |
| `logout_method` | Symbol | `:delete` | HTTP method |

### `chalky_sidebar_head_script`

Script to prevent FOUC (Flash of Unstyled Content) for sidebar collapsed state. Must be placed in `<head>`.

```slim
head
  = chalky_sidebar_head_script
  / ... other head content
```

### Menu Items (via `with_menu_item`)

Menu items are added via the `with_menu_item` method on sections and footers within `chalky_sidebar_layout`.

```slim
- layout.with_section(title: "Navigation", icon_path: "...", icon_color: :blue) do |section|
  - section.with_menu_item(path: admin_users_path, title: "Users", icon_classes: "fa-solid fa-users")
  - section.with_menu_item(path: admin_orders_path, title: "Orders", icon_classes: "fa-solid fa-shopping-cart")
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `path` | String | **required** | Link URL |
| `title` | String | **required** | Label |
| `icon_classes` | String | `nil` | Font Awesome classes |
| `icon_path` | String | `nil` | SVG path (alternative) |
| `active` | Boolean/nil | `nil` | Override active state |

---

## Theming & Tailwind Setup

ChalkyLayout uses CSS custom properties (design tokens) for theming. Works with both Tailwind v3 and v4.

### Tailwind v3 Setup

```css
/* application.css */
@tailwind base;
@tailwind components;
@tailwind utilities;

@import "chalky_layout/tokens.css";
@import "chalky_layout/utilities.css";

/* Your theme overrides (optional) */
:root {
  --chalky-primary: #8b5cf6;
}
```

Add to `tailwind.config.js`:
```javascript
module.exports = {
  content: [
    // ... your paths
    `${process.env.GEM_HOME}/gems/chalky_layout-*/app/**/*.{slim,rb}`
  ]
}
```

### Tailwind v4 Setup

```css
/* application.css */
@import "tailwindcss";

@source "../../../vendor/bundle/ruby/*/gems/chalky_layout-*/app/**/*.{slim,rb}";

@import "chalky_layout/tokens.css";
@import "chalky_layout/utilities.css";

/* Your theme overrides (optional) */
:root {
  --chalky-primary: #8b5cf6;
}
```

### Available Design Tokens

**Primary (Brand Color):**
| Token | Default | Description |
|-------|---------|-------------|
| `--chalky-primary` | `#3b82f6` | Main brand/action color |
| `--chalky-primary-hover` | `#2563eb` | Hover state |
| `--chalky-primary-light` | `#eff6ff` | Light background |
| `--chalky-primary-text` | `#1d4ed8` | Text on light background |

**Semantic Colors:**
| Token | Default | Description |
|-------|---------|-------------|
| `--chalky-success` | `#16a34a` | Positive actions |
| `--chalky-success-light` | `#f0fdf4` | Success background |
| `--chalky-danger` | `#dc2626` | Destructive actions |
| `--chalky-danger-light` | `#fef2f2` | Danger background |
| `--chalky-warning` | `#ca8a04` | Caution states |
| `--chalky-warning-light` | `#fefce8` | Warning background |
| `--chalky-info` | `#0284c7` | Informational |
| `--chalky-info-light` | `#f0f9ff` | Info background |

**Surfaces:**
| Token | Default | Description |
|-------|---------|-------------|
| `--chalky-surface` | `#ffffff` | Card backgrounds |
| `--chalky-surface-secondary` | `#f9fafb` | Secondary backgrounds |
| `--chalky-surface-tertiary` | `#f3f4f6` | Tertiary backgrounds |
| `--chalky-surface-hover` | `#f3f4f6` | Hover states |

**Text:**
| Token | Default | Description |
|-------|---------|-------------|
| `--chalky-text-primary` | `#111827` | Main text |
| `--chalky-text-secondary` | `#4b5563` | Secondary text |
| `--chalky-text-tertiary` | `#6b7280` | Muted text |
| `--chalky-text-inverted` | `#ffffff` | Text on dark backgrounds |

**Borders:**
| Token | Default | Description |
|-------|---------|-------------|
| `--chalky-border` | `#e5e7eb` | Default border |
| `--chalky-border-light` | `#f3f4f6` | Light border |
| `--chalky-border-strong` | `#d1d5db` | Strong border |

**Accent Colors (badges/icons):**
| Token | Light variant | Text variant |
|-------|---------------|--------------|
| `--chalky-accent-blue` | `--chalky-accent-blue-light` | `--chalky-accent-blue-text` |
| `--chalky-accent-green` | `--chalky-accent-green-light` | `--chalky-accent-green-text` |
| `--chalky-accent-red` | `--chalky-accent-red-light` | `--chalky-accent-red-text` |
| `--chalky-accent-yellow` | `--chalky-accent-yellow-light` | `--chalky-accent-yellow-text` |
| `--chalky-accent-orange` | `--chalky-accent-orange-light` | `--chalky-accent-orange-text` |
| `--chalky-accent-purple` | `--chalky-accent-purple-light` | `--chalky-accent-purple-text` |
| `--chalky-accent-gray` | `--chalky-accent-gray-light` | `--chalky-accent-gray-text` |
| `--chalky-accent-indigo` | `--chalky-accent-indigo-light` | `--chalky-accent-indigo-text` |

### Complete Theme Example

```css
/* app/assets/stylesheets/theme.css */
:root {
  /* Primary - Purple theme */
  --chalky-primary: #8b5cf6;
  --chalky-primary-hover: #7c3aed;
  --chalky-primary-light: #f5f3ff;
  --chalky-primary-text: #6d28d9;
  --chalky-focus-ring: #8b5cf6;

  /* Customize other tokens as needed */
}
```

Import order:
```css
@import "chalky_layout/tokens.css";
@import "chalky_layout/utilities.css";
@import "theme.css";  /* Your overrides LAST */
```
