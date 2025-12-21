import { Controller } from "@hotwired/stimulus"

// Theme Editor Controller
// Smart theme generation with WCAG accessibility compliance
export default class extends Controller {
  static targets = ["panel", "toggle", "colorInput", "presetButton", "modeTab", "simpleMode", "advancedMode", "primaryPicker", "accentPicker"]
  static values = {
    storageKey: { type: String, default: "chalky-theme" },
    open: { type: Boolean, default: false },
    mode: { type: String, default: "simple" }
  }

  // Predefined theme presets - 8 light + 8 dark
  static presets = {
    // =====================
    // LIGHT MODE PRESETS
    // =====================
    "blue-light": {
      name: "Ocean Blue",
      primary: "#3b82f6",
      accent: "#06b6d4",
      mode: "light"
    },
    "green-light": {
      name: "Forest Green",
      primary: "#10b981",
      accent: "#84cc16",
      mode: "light"
    },
    "purple-light": {
      name: "Royal Purple",
      primary: "#8b5cf6",
      accent: "#ec4899",
      mode: "light"
    },
    "orange-light": {
      name: "Sunset Orange",
      primary: "#f97316",
      accent: "#eab308",
      mode: "light"
    },
    "red-light": {
      name: "Ruby Red",
      primary: "#ef4444",
      accent: "#f97316",
      mode: "light"
    },
    "teal-light": {
      name: "Teal Dream",
      primary: "#14b8a6",
      accent: "#6366f1",
      mode: "light"
    },
    "indigo-light": {
      name: "Deep Indigo",
      primary: "#6366f1",
      accent: "#a855f7",
      mode: "light"
    },
    "rose-light": {
      name: "Rose Garden",
      primary: "#f43f5e",
      accent: "#d946ef",
      mode: "light"
    },
    // =====================
    // DARK MODE PRESETS
    // =====================
    "blue-dark": {
      name: "Ocean Blue Dark",
      primary: "#60a5fa",
      accent: "#22d3ee",
      mode: "dark"
    },
    "green-dark": {
      name: "Forest Green Dark",
      primary: "#34d399",
      accent: "#a3e635",
      mode: "dark"
    },
    "purple-dark": {
      name: "Royal Purple Dark",
      primary: "#a78bfa",
      accent: "#f472b6",
      mode: "dark"
    },
    "orange-dark": {
      name: "Sunset Orange Dark",
      primary: "#fb923c",
      accent: "#fbbf24",
      mode: "dark"
    },
    "red-dark": {
      name: "Ruby Red Dark",
      primary: "#f87171",
      accent: "#fb923c",
      mode: "dark"
    },
    "teal-dark": {
      name: "Teal Dream Dark",
      primary: "#2dd4bf",
      accent: "#818cf8",
      mode: "dark"
    },
    "indigo-dark": {
      name: "Deep Indigo Dark",
      primary: "#818cf8",
      accent: "#c084fc",
      mode: "dark"
    },
    "rose-dark": {
      name: "Rose Garden Dark",
      primary: "#fb7185",
      accent: "#e879f9",
      mode: "dark"
    }
  }

  connect() {
    this.loadFromStorage()
    this.updatePanelVisibility()
    this.updateModeVisibility()
  }

  // ==========================================
  // PANEL VISIBILITY
  // ==========================================

  toggle() {
    this.openValue = !this.openValue
  }

  openValueChanged() {
    this.updatePanelVisibility()
  }

  updatePanelVisibility() {
    if (this.hasPanelTarget) {
      if (this.openValue) {
        this.panelTarget.classList.remove("translate-x-full")
        this.panelTarget.classList.add("translate-x-0")
      } else {
        this.panelTarget.classList.remove("translate-x-0")
        this.panelTarget.classList.add("translate-x-full")
      }
    }
  }

  // ==========================================
  // MODE SWITCHING (Simple / Advanced)
  // ==========================================

  switchMode(event) {
    const mode = event.currentTarget.dataset.mode
    this.modeValue = mode
    this.updateModeVisibility()

    // Update tab styles
    this.modeTabTargets.forEach(tab => {
      if (tab.dataset.mode === mode) {
        tab.classList.add("bg-white", "shadow-sm")
        tab.classList.remove("text-gray-500")
      } else {
        tab.classList.remove("bg-white", "shadow-sm")
        tab.classList.add("text-gray-500")
      }
    })
  }

  updateModeVisibility() {
    if (this.hasSimpleModeTarget && this.hasAdvancedModeTarget) {
      if (this.modeValue === "simple") {
        this.simpleModeTarget.classList.remove("hidden")
        this.advancedModeTarget.classList.add("hidden")
      } else {
        this.simpleModeTarget.classList.add("hidden")
        this.advancedModeTarget.classList.remove("hidden")
      }
    }
  }

  // ==========================================
  // PRESET THEMES
  // ==========================================

  applyPreset(event) {
    const presetKey = event.currentTarget.dataset.preset
    const preset = this.constructor.presets[presetKey]

    if (preset) {
      const mode = preset.mode || "light"
      this.generateThemeFromPrimary(preset.primary, preset.accent, mode)
      this.saveToStorage(preset.primary, preset.accent, mode)

      // Update UI
      if (this.hasPrimaryPickerTarget) {
        this.primaryPickerTarget.value = preset.primary
      }
      if (this.hasAccentPickerTarget) {
        this.accentPickerTarget.value = preset.accent
      }

      // Highlight selected preset
      this.presetButtonTargets.forEach(btn => {
        btn.classList.remove("ring-2", "ring-offset-2")
        // Use different ring color for dark/light presets
        btn.classList.remove("ring-blue-500", "ring-white")
        if (btn.dataset.preset === presetKey) {
          btn.classList.add("ring-2", "ring-offset-2")
          btn.classList.add(mode === "dark" ? "ring-white" : "ring-blue-500")
        }
      })
    }
  }

  // ==========================================
  // SMART COLOR GENERATION
  // ==========================================

  updatePrimaryColor(event) {
    const primaryColor = event.target.value
    const accentColor = this.hasAccentPickerTarget ? this.accentPickerTarget.value : this.generateComplementary(primaryColor)
    const mode = this.currentMode || "light"
    this.generateThemeFromPrimary(primaryColor, accentColor, mode)
    this.saveToStorage(primaryColor, accentColor, mode)
  }

  updateAccentColor(event) {
    const accentColor = event.target.value
    const primaryColor = this.hasPrimaryPickerTarget ? this.primaryPickerTarget.value : "#3b82f6"
    const mode = this.currentMode || "light"
    this.generateThemeFromPrimary(primaryColor, accentColor, mode)
    this.saveToStorage(primaryColor, accentColor, mode)
  }

  generateThemeFromPrimary(primaryHex, accentHex = null, mode = "light") {
    const primary = this.hexToHSL(primaryHex)
    const accent = accentHex ? this.hexToHSL(accentHex) : this.generateComplementaryHSL(primary)
    const isDark = mode === "dark"

    // Store current mode for reference
    this.currentMode = mode

    // ==========================================
    // PRIMARY COLOR PALETTE
    // ==========================================
    this.setToken("--chalky-primary", primaryHex)

    if (isDark) {
      // In dark mode, hover goes lighter
      this.setToken("--chalky-primary-hover", this.hslToHex(primary.h, primary.s, Math.min(primary.l + 10, 80)))
      // Primary light background in dark mode should be dark with primary tint
      this.setToken("--chalky-primary-light", this.hslToHex(primary.h, 30, 18))
      this.setToken("--chalky-primary-text", this.hslToHex(primary.h, 70, 70))
    } else {
      this.setToken("--chalky-primary-hover", this.hslToHex(primary.h, primary.s, Math.max(primary.l - 10, 10)))
      this.setToken("--chalky-primary-light", this.hslToHex(primary.h, Math.min(primary.s + 10, 100), 95))
      // Text color for primary - ensure WCAG AA contrast
      const primaryTextColor = this.getContrastTextColor(
        this.hslToHex(primary.h, Math.min(primary.s + 10, 100), 95),
        primary.h
      )
      this.setToken("--chalky-primary-text", primaryTextColor)
    }

    // ==========================================
    // SEMANTIC COLORS (derived from primary hue rotation)
    // ==========================================
    this.generateSemanticColors(isDark)

    // ==========================================
    // ACCENT COLORS (for badges, icons, etc.)
    // ==========================================
    this.generateAccentColors(primary, isDark)

    // ==========================================
    // SURFACE & TEXT COLORS
    // ==========================================
    this.generateSurfaceColors(primary, isDark)

    // Focus ring matches primary
    this.setToken("--chalky-focus-ring", primaryHex)
  }

  // Generate semantic colors (success, danger, warning, info)
  generateSemanticColors(isDark) {
    // Success: Green hue (around 145°)
    const successHue = 145
    if (isDark) {
      this.setToken("--chalky-success", this.hslToHex(successHue, 60, 55))
      this.setToken("--chalky-success-hover", this.hslToHex(successHue, 60, 60))
      this.setToken("--chalky-success-light", this.hslToHex(successHue, 40, 15))
      this.setToken("--chalky-success-text", this.hslToHex(successHue, 60, 70))
      this.setToken("--chalky-success-border", this.hslToHex(successHue, 50, 35))
    } else {
      this.setToken("--chalky-success", this.hslToHex(successHue, 70, 40))
      this.setToken("--chalky-success-hover", this.hslToHex(successHue, 70, 35))
      this.setToken("--chalky-success-light", this.hslToHex(successHue, 60, 96))
      this.setToken("--chalky-success-text", this.hslToHex(successHue, 70, 25))
      this.setToken("--chalky-success-border", this.hslToHex(successHue, 60, 60))
    }

    // Danger: Red hue (around 0°)
    const dangerHue = 0
    if (isDark) {
      this.setToken("--chalky-danger", this.hslToHex(dangerHue, 70, 60))
      this.setToken("--chalky-danger-hover", this.hslToHex(dangerHue, 70, 65))
      this.setToken("--chalky-danger-light", this.hslToHex(dangerHue, 50, 15))
      this.setToken("--chalky-danger-text", this.hslToHex(dangerHue, 65, 70))
      this.setToken("--chalky-danger-border", this.hslToHex(dangerHue, 55, 35))
    } else {
      this.setToken("--chalky-danger", this.hslToHex(dangerHue, 75, 50))
      this.setToken("--chalky-danger-hover", this.hslToHex(dangerHue, 75, 42))
      this.setToken("--chalky-danger-light", this.hslToHex(dangerHue, 80, 97))
      this.setToken("--chalky-danger-text", this.hslToHex(dangerHue, 70, 30))
      this.setToken("--chalky-danger-border", this.hslToHex(dangerHue, 70, 65))
    }

    // Warning: Yellow/Amber hue (around 45°)
    const warningHue = 45
    if (isDark) {
      this.setToken("--chalky-warning", this.hslToHex(warningHue, 80, 55))
      this.setToken("--chalky-warning-hover", this.hslToHex(warningHue, 80, 60))
      this.setToken("--chalky-warning-light", this.hslToHex(warningHue, 50, 15))
      this.setToken("--chalky-warning-text", this.hslToHex(warningHue, 70, 70))
      this.setToken("--chalky-warning-border", this.hslToHex(warningHue, 60, 35))
    } else {
      this.setToken("--chalky-warning", this.hslToHex(warningHue, 85, 45))
      this.setToken("--chalky-warning-hover", this.hslToHex(warningHue, 85, 38))
      this.setToken("--chalky-warning-light", this.hslToHex(warningHue, 80, 96))
      this.setToken("--chalky-warning-text", this.hslToHex(warningHue, 75, 28))
      this.setToken("--chalky-warning-border", this.hslToHex(warningHue, 80, 55))
    }

    // Info: Cyan hue (around 200°)
    const infoHue = 200
    if (isDark) {
      this.setToken("--chalky-info", this.hslToHex(infoHue, 65, 55))
      this.setToken("--chalky-info-hover", this.hslToHex(infoHue, 65, 60))
      this.setToken("--chalky-info-light", this.hslToHex(infoHue, 45, 15))
      this.setToken("--chalky-info-text", this.hslToHex(infoHue, 60, 70))
      this.setToken("--chalky-info-border", this.hslToHex(infoHue, 50, 35))
    } else {
      this.setToken("--chalky-info", this.hslToHex(infoHue, 70, 45))
      this.setToken("--chalky-info-hover", this.hslToHex(infoHue, 70, 38))
      this.setToken("--chalky-info-light", this.hslToHex(infoHue, 70, 96))
      this.setToken("--chalky-info-text", this.hslToHex(infoHue, 70, 28))
      this.setToken("--chalky-info-border", this.hslToHex(infoHue, 60, 60))
    }
  }

  // Generate accent colors for badges, icons, etc.
  generateAccentColors(primary, isDark) {
    const accents = [
      { name: "blue", hue: 220 },
      { name: "green", hue: 145 },
      { name: "red", hue: 0 },
      { name: "yellow", hue: 50 },
      { name: "orange", hue: 25 },
      { name: "purple", hue: 280 },
      { name: "indigo", hue: 240 }
    ]

    accents.forEach(({ name, hue }) => {
      if (isDark) {
        // Dark mode: brighter main color, dark background, light text
        this.setToken(`--chalky-accent-${name}`, this.hslToHex(hue, 65, 60))
        this.setToken(`--chalky-accent-${name}-light`, this.hslToHex(hue, 40, 18))
        this.setToken(`--chalky-accent-${name}-text`, this.hslToHex(hue, 60, 75))
      } else {
        // Light mode: standard colors
        this.setToken(`--chalky-accent-${name}`, this.hslToHex(hue, 70, 55))
        this.setToken(`--chalky-accent-${name}-light`, this.hslToHex(hue, 65, 92))
        this.setToken(`--chalky-accent-${name}-text`, this.hslToHex(hue, 70, 30))
      }
    })

    // Gray accent (neutral) - uses primary hue for subtle tint
    if (isDark) {
      this.setToken("--chalky-accent-gray", this.hslToHex(primary.h, 5, 55))
      this.setToken("--chalky-accent-gray-light", this.hslToHex(primary.h, 5, 20))
      this.setToken("--chalky-accent-gray-text", this.hslToHex(primary.h, 5, 75))
    } else {
      this.setToken("--chalky-accent-gray", this.hslToHex(primary.h, 5, 45))
      this.setToken("--chalky-accent-gray-light", this.hslToHex(primary.h, 5, 95))
      this.setToken("--chalky-accent-gray-text", this.hslToHex(primary.h, 5, 25))
    }
  }

  // Generate surface and text colors
  generateSurfaceColors(primary, isDark) {
    const neutralHue = primary.h
    const neutralSat = 5 // Very low saturation for subtle tint

    if (isDark) {
      // Dark mode surfaces: dark gray with slight primary tint (GitHub/VS Code style)
      this.setToken("--chalky-surface", this.hslToHex(neutralHue, neutralSat, 12))           // ~#1f2937
      this.setToken("--chalky-surface-secondary", this.hslToHex(neutralHue, neutralSat, 15)) // Slightly lighter
      this.setToken("--chalky-surface-tertiary", this.hslToHex(neutralHue, neutralSat, 18))
      this.setToken("--chalky-surface-hover", this.hslToHex(neutralHue, neutralSat, 20))
      this.setToken("--chalky-surface-active", this.hslToHex(neutralHue, neutralSat, 25))

      // Dark mode text: light colors
      this.setToken("--chalky-text-primary", this.hslToHex(neutralHue, 5, 95))
      this.setToken("--chalky-text-secondary", this.hslToHex(neutralHue, 5, 75))
      this.setToken("--chalky-text-tertiary", this.hslToHex(neutralHue, 5, 60))
      this.setToken("--chalky-text-muted", this.hslToHex(neutralHue, 5, 45))
      this.setToken("--chalky-text-inverted", this.hslToHex(neutralHue, 10, 10))

      // Dark mode borders: darker
      this.setToken("--chalky-border", this.hslToHex(neutralHue, neutralSat, 25))
      this.setToken("--chalky-border-light", this.hslToHex(neutralHue, neutralSat, 20))
      this.setToken("--chalky-border-strong", this.hslToHex(neutralHue, neutralSat, 35))

      // Tooltip in dark mode: lighter (inverted)
      this.setToken("--chalky-tooltip-bg", this.hslToHex(neutralHue, 10, 85))
      this.setToken("--chalky-tooltip-text", this.hslToHex(neutralHue, 10, 10))

      // Overlay stays dark
      this.setToken("--chalky-overlay", "rgba(0, 0, 0, 0.7)")
    } else {
      // Light mode surfaces: white/light gray
      this.setToken("--chalky-surface", "#ffffff")
      this.setToken("--chalky-surface-secondary", this.hslToHex(neutralHue, neutralSat, 98))
      this.setToken("--chalky-surface-tertiary", this.hslToHex(neutralHue, neutralSat, 96))
      this.setToken("--chalky-surface-hover", this.hslToHex(neutralHue, neutralSat, 96))
      this.setToken("--chalky-surface-active", this.hslToHex(neutralHue, neutralSat, 91))

      // Light mode text: dark colors
      this.setToken("--chalky-text-primary", this.hslToHex(neutralHue, 10, 10))
      this.setToken("--chalky-text-secondary", this.hslToHex(neutralHue, 8, 35))
      this.setToken("--chalky-text-tertiary", this.hslToHex(neutralHue, 6, 45))
      this.setToken("--chalky-text-muted", this.hslToHex(neutralHue, 5, 60))
      this.setToken("--chalky-text-inverted", "#ffffff")

      // Light mode borders: light gray
      this.setToken("--chalky-border", this.hslToHex(neutralHue, neutralSat, 90))
      this.setToken("--chalky-border-light", this.hslToHex(neutralHue, neutralSat, 95))
      this.setToken("--chalky-border-strong", this.hslToHex(neutralHue, neutralSat, 82))

      // Tooltip in light mode: dark
      this.setToken("--chalky-tooltip-bg", this.hslToHex(neutralHue, 15, 15))
      this.setToken("--chalky-tooltip-text", "#ffffff")

      // Overlay
      this.setToken("--chalky-overlay", "rgba(0, 0, 0, 0.5)")
    }
  }

  // ==========================================
  // COLOR UTILITY FUNCTIONS
  // ==========================================

  hexToHSL(hex) {
    const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex)
    if (!result) return { h: 0, s: 0, l: 50 }

    let r = parseInt(result[1], 16) / 255
    let g = parseInt(result[2], 16) / 255
    let b = parseInt(result[3], 16) / 255

    const max = Math.max(r, g, b)
    const min = Math.min(r, g, b)
    let h, s, l = (max + min) / 2

    if (max === min) {
      h = s = 0
    } else {
      const d = max - min
      s = l > 0.5 ? d / (2 - max - min) : d / (max + min)
      switch (max) {
        case r: h = ((g - b) / d + (g < b ? 6 : 0)) / 6; break
        case g: h = ((b - r) / d + 2) / 6; break
        case b: h = ((r - g) / d + 4) / 6; break
      }
    }

    return {
      h: Math.round(h * 360),
      s: Math.round(s * 100),
      l: Math.round(l * 100)
    }
  }

  hslToHex(h, s, l) {
    s /= 100
    l /= 100

    const c = (1 - Math.abs(2 * l - 1)) * s
    const x = c * (1 - Math.abs((h / 60) % 2 - 1))
    const m = l - c / 2
    let r = 0, g = 0, b = 0

    if (0 <= h && h < 60) { r = c; g = x; b = 0 }
    else if (60 <= h && h < 120) { r = x; g = c; b = 0 }
    else if (120 <= h && h < 180) { r = 0; g = c; b = x }
    else if (180 <= h && h < 240) { r = 0; g = x; b = c }
    else if (240 <= h && h < 300) { r = x; g = 0; b = c }
    else if (300 <= h && h < 360) { r = c; g = 0; b = x }

    r = Math.round((r + m) * 255)
    g = Math.round((g + m) * 255)
    b = Math.round((b + m) * 255)

    return `#${((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1)}`
  }

  generateComplementary(hex) {
    const hsl = this.hexToHSL(hex)
    return this.hslToHex((hsl.h + 180) % 360, hsl.s, hsl.l)
  }

  generateComplementaryHSL(hsl) {
    return {
      h: (hsl.h + 180) % 360,
      s: hsl.s,
      l: hsl.l
    }
  }

  // ==========================================
  // WCAG CONTRAST CALCULATIONS
  // ==========================================

  // Get relative luminance of a color (WCAG formula)
  getLuminance(hex) {
    const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex)
    if (!result) return 0

    let r = parseInt(result[1], 16) / 255
    let g = parseInt(result[2], 16) / 255
    let b = parseInt(result[3], 16) / 255

    r = r <= 0.03928 ? r / 12.92 : Math.pow((r + 0.055) / 1.055, 2.4)
    g = g <= 0.03928 ? g / 12.92 : Math.pow((g + 0.055) / 1.055, 2.4)
    b = b <= 0.03928 ? b / 12.92 : Math.pow((b + 0.055) / 1.055, 2.4)

    return 0.2126 * r + 0.7152 * g + 0.0722 * b
  }

  // Calculate contrast ratio between two colors
  getContrastRatio(hex1, hex2) {
    const lum1 = this.getLuminance(hex1)
    const lum2 = this.getLuminance(hex2)
    const lighter = Math.max(lum1, lum2)
    const darker = Math.min(lum1, lum2)
    return (lighter + 0.05) / (darker + 0.05)
  }

  // Get the best text color for a background (WCAG AA compliant)
  getContrastTextColor(bgHex, hue = 220) {
    const bgLuminance = this.getLuminance(bgHex)

    // Try dark text first (preferred for light backgrounds)
    const darkText = this.hslToHex(hue, 70, 25)
    const darkContrast = this.getContrastRatio(bgHex, darkText)

    // WCAG AA requires 4.5:1 for normal text
    if (darkContrast >= 4.5) {
      return darkText
    }

    // Try progressively darker
    for (let l = 20; l >= 5; l -= 5) {
      const testColor = this.hslToHex(hue, 70, l)
      if (this.getContrastRatio(bgHex, testColor) >= 4.5) {
        return testColor
      }
    }

    // Fall back to near black
    return this.hslToHex(hue, 10, 10)
  }

  // ==========================================
  // TOKEN MANAGEMENT
  // ==========================================

  setToken(name, value) {
    document.documentElement.style.setProperty(name, value)
  }

  // ==========================================
  // STORAGE
  // ==========================================

  loadFromStorage() {
    try {
      const saved = localStorage.getItem(this.storageKeyValue)
      if (saved) {
        const data = JSON.parse(saved)
        if (data.primary && data.accent) {
          const mode = data.mode || "light"
          this.currentMode = mode
          this.generateThemeFromPrimary(data.primary, data.accent, mode)
          if (this.hasPrimaryPickerTarget) {
            this.primaryPickerTarget.value = data.primary
          }
          if (this.hasAccentPickerTarget) {
            this.accentPickerTarget.value = data.accent
          }
        }
      }
    } catch (e) {
      console.warn("Failed to load theme from storage:", e)
    }
  }

  saveToStorage(primary = null, accent = null, mode = null) {
    const data = {
      primary: primary || (this.hasPrimaryPickerTarget ? this.primaryPickerTarget.value : "#3b82f6"),
      accent: accent || (this.hasAccentPickerTarget ? this.accentPickerTarget.value : "#06b6d4"),
      mode: mode || this.currentMode || "light"
    }
    localStorage.setItem(this.storageKeyValue, JSON.stringify(data))
  }

  // ==========================================
  // ACTIONS
  // ==========================================

  reset() {
    // Reset to default blue light theme
    this.currentMode = "light"
    this.generateThemeFromPrimary("#3b82f6", "#06b6d4", "light")
    if (this.hasPrimaryPickerTarget) {
      this.primaryPickerTarget.value = "#3b82f6"
    }
    if (this.hasAccentPickerTarget) {
      this.accentPickerTarget.value = "#06b6d4"
    }
    localStorage.removeItem(this.storageKeyValue)

    // Clear preset selection
    this.presetButtonTargets.forEach(btn => {
      btn.classList.remove("ring-2", "ring-offset-2", "ring-blue-500", "ring-white")
    })
  }

  copyCSS() {
    const css = this.generateCSS()
    navigator.clipboard.writeText(css).then(() => {
      this.showNotification("CSS copié !")
    })
  }

  copyJSON() {
    const json = this.generateJSON()
    navigator.clipboard.writeText(json).then(() => {
      this.showNotification("JSON copié !")
    })
  }

  generateCSS() {
    const root = document.documentElement
    const tokens = [
      "--chalky-surface", "--chalky-surface-secondary", "--chalky-surface-tertiary",
      "--chalky-surface-hover", "--chalky-surface-active",
      "--chalky-text-primary", "--chalky-text-secondary", "--chalky-text-tertiary",
      "--chalky-text-muted", "--chalky-text-inverted",
      "--chalky-border", "--chalky-border-light", "--chalky-border-strong",
      "--chalky-primary", "--chalky-primary-hover", "--chalky-primary-light", "--chalky-primary-text",
      "--chalky-success", "--chalky-success-hover", "--chalky-success-light", "--chalky-success-text", "--chalky-success-border",
      "--chalky-danger", "--chalky-danger-hover", "--chalky-danger-light", "--chalky-danger-text", "--chalky-danger-border",
      "--chalky-warning", "--chalky-warning-hover", "--chalky-warning-light", "--chalky-warning-text", "--chalky-warning-border",
      "--chalky-info", "--chalky-info-hover", "--chalky-info-light", "--chalky-info-text", "--chalky-info-border",
      "--chalky-accent-blue", "--chalky-accent-blue-light", "--chalky-accent-blue-text",
      "--chalky-accent-green", "--chalky-accent-green-light", "--chalky-accent-green-text",
      "--chalky-accent-red", "--chalky-accent-red-light", "--chalky-accent-red-text",
      "--chalky-accent-yellow", "--chalky-accent-yellow-light", "--chalky-accent-yellow-text",
      "--chalky-accent-orange", "--chalky-accent-orange-light", "--chalky-accent-orange-text",
      "--chalky-accent-purple", "--chalky-accent-purple-light", "--chalky-accent-purple-text",
      "--chalky-accent-gray", "--chalky-accent-gray-light", "--chalky-accent-gray-text",
      "--chalky-accent-indigo", "--chalky-accent-indigo-light", "--chalky-accent-indigo-text",
      "--chalky-tooltip-bg", "--chalky-tooltip-text", "--chalky-focus-ring"
    ]

    let css = ":root {\n"
    tokens.forEach(token => {
      const value = root.style.getPropertyValue(token) || getComputedStyle(root).getPropertyValue(token)
      if (value) {
        css += `  ${token}: ${value.trim()};\n`
      }
    })
    css += "}"
    return css
  }

  generateJSON() {
    const primary = this.hasPrimaryPickerTarget ? this.primaryPickerTarget.value : "#3b82f6"
    const accent = this.hasAccentPickerTarget ? this.accentPickerTarget.value : "#06b6d4"
    return JSON.stringify({ primary, accent }, null, 2)
  }

  showNotification(message) {
    const notification = document.createElement("div")
    notification.className = "fixed bottom-24 right-4 bg-gray-900 text-white px-4 py-2 rounded-lg shadow-lg text-sm z-[10001]"
    notification.textContent = message
    document.body.appendChild(notification)
    setTimeout(() => notification.remove(), 2000)
  }

  // ==========================================
  // ADVANCED MODE - Manual color input
  // ==========================================

  updateColor(event) {
    const input = event.target
    const tokenName = input.dataset.token
    const value = input.value
    this.setToken(tokenName, value)
  }

  // Toggle collapsible sections in advanced mode
  toggleSection(event) {
    const button = event.currentTarget
    const section = button.closest("[data-section]")
    const content = section.querySelector("[data-section-content]")
    const icon = section.querySelector("[data-section-icon]")

    if (content) {
      content.classList.toggle("hidden")
    }
    if (icon) {
      icon.classList.toggle("-rotate-180")
      icon.classList.toggle("rotate-0")
    }
  }
}
