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

Form submit button.

```slim
= chalky_button(label: "Save", variant: :primary)
= chalky_button(label: "Delete", variant: :danger)
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | String | `nil` | Button label |
| `variant` | Symbol | `:primary` | `:primary`, `:danger` |
| `type` | Symbol | `:submit` | Button type |

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
  - grid.link(label: "Website", method: :url, path: ->(row) { row.url })
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
| `image` | Image thumbnail | `size:` (`:small`, `:medium`, `:large`) |
| `icon` | Conditional icon | `icon:` |
| `custom` | Custom block | Block required |

**Column Priority:**
- `:primary` - Always visible, card title on mobile
- `:secondary` - Default, card body on mobile
- `:optional` - Only on large screens

**Badge/Icon Colors:** `:green`, `:red`, `:blue`, `:yellow`, `:purple`, `:orange`, `:gray`

**Action Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| `name` | String | Action label |
| `path` | Symbol | Route helper (e.g., `:edit_user_path`) |
| `icon` | String | Font Awesome class |
| `data` | Hash | Data attributes |
| `options[:variant]` | Symbol | `:admin` or `:danger` |

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

Hover tooltip.

```slim
= chalky_tooltip(text: "Help text", position: :top, variant: :dark, delay: 300) do
  i.fa-solid.fa-circle-info
```

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `text` | String | **required** | Tooltip text |
| `position` | Symbol | `:top` | `:top`, `:bottom`, `:left`, `:right` |
| `variant` | Symbol | `:dark` | `:dark`, `:light` |
| `delay` | Integer | `0` | Delay in ms |

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
