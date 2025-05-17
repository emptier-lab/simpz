# simpz UI Library

A modern, minimalist UI library for Roblox with sleek animations, customizable themes, and a variety of UI components.

## Features

- **Clean Design** - Modern, dark-themed UI with rounded corners and smooth animations
- **Collapsible Sections** - Organize your UI with expandable/collapsible sections
- **Customizable** - Easily change colors, themes, and styles
- **Multiple Components** - Buttons, toggles, sliders, dropdowns, and more
- **UI Effects** - Shadows, glows, and smooth transitions

## Installation

```lua
local simpz = loadstring(game:HttpGet("https://raw.githubusercontent.com/emptier-lab/simpz/main/Library.lua"))()
```

## Basic Usage

```lua
-- Create a window
local Window = simpz:CreateWindow("My App", UDim2.new(0, 550, 0, 400))

-- Create a tab
local HomeTab = Window:CreateTab("Home", "rbxassetid://7733960981")

-- Create a section
local SettingsSection = simpz:CreateSection(HomeTab, "Settings")

-- Create UI elements
simpz:CreateButton(SettingsSection, "Click Me", function()
    print("Button clicked!")
end)

simpz:CreateToggle(SettingsSection, "Enable Feature", false, function(value)
    print("Toggle set to:", value)
end)

simpz:CreateSlider(SettingsSection, "Speed", {
    min = 0,
    max = 100,
    default = 50,
    suffix = "%"
}, function(value)
    print("Slider value:", value)
end)
```

## Components

### Window

```lua
local Window = simpz:CreateWindow("Title", UDim2.new(0, 550, 0, 400))
```

### Tabs

```lua
local Tab = Window:CreateTab("Name", "rbxassetid://ICON_ID") -- Icon is optional
```

### Sections

```lua
local Section = simpz:CreateSection(Tab, "Section Name")
```

Sections are collapsible - click on the section header to expand or collapse.

### Button

```lua
simpz:CreateButton(Section, "Button Text", function()
    -- Callback function
end)
```

### Toggle

```lua
simpz:CreateToggle(Section, "Toggle Option", false, function(value)
    -- Callback with boolean value
end)
```

### Slider

```lua
simpz:CreateSlider(Section, "Slider Name", {
    min = 0,
    max = 100, 
    default = 50,
    suffix = "%",    -- Optional
    precise = false  -- Optional, for decimal values
}, function(value)
    -- Callback with numeric value
end)
```

### Color Picker

```lua
simpz:CreateColorPicker(Section, "Color", Color3.fromRGB(255, 0, 0), function(color)
    -- Callback with Color3 value
end)
```

### Sound Controller

```lua
simpz:CreateSoundController(Section, "Volume", {
    min = 0,
    max = 100,
    default = 75
}, function(value, isMuted)
    -- Callback with value and mute state
end)
```

### Dropdown

```lua
simpz:CreateDropdown(Section, "Options", {
    items = {"Option 1", "Option 2", "Option 3"},
    default = "Option 1",
    multi = false  -- Set to true for multi-select
}, function(selected)
    -- Callback with selected item(s)
end)
```

### Keybind

```lua
simpz:CreateKeybind(Section, "Toggle UI", "RightControl", function(key)
    -- Callback with key code
end)
```

### TextBox

```lua
simpz:CreateTextBox(Section, "Input", "", "Enter text...", function(text)
    -- Callback with input text
end)
```

### Progress Bar

```lua
local progressBar = simpz:CreateProgressBar(Section, "Loading", {
    min = 0,
    max = 100,
    default = 0,
    color = Color3.fromRGB(0, 255, 128)  -- Optional color
})

-- Update the progress bar later
progressBar:Set(75)  -- Set to 75%
```

## Customization

You can customize the theme colors:

```lua
simpz.Settings.Theme = {
    Primary = Color3.fromRGB(32, 33, 36),     -- Main background
    Secondary = Color3.fromRGB(42, 43, 49),   -- Secondary elements
    Accent = Color3.fromRGB(114, 137, 218),   -- Accent color
    TextColor = Color3.fromRGB(255, 255, 255) -- Text color
}
```

## Example Script

Here's a more complete example:

```lua
local simpz = loadstring(game:HttpGet("https://raw.githubusercontent.com/emptier-lab/simpz/main/Library.lua"))()

-- Create window
local Window = simpz:CreateWindow("simpz Example", UDim2.new(0, 600, 0, 450))

-- Create tabs
local HomeTab = Window:CreateTab("Home", "rbxassetid://7733960981")
local SettingsTab = Window:CreateTab("Settings", "rbxassetid://7734053495")

-- Create sections
local WelcomeSection = simpz:CreateSection(HomeTab, "Welcome")
local FeaturesSection = simpz:CreateSection(HomeTab, "Features")

-- Add elements to welcome section
simpz:CreateButton(WelcomeSection, "Click Me", function()
    print("Button clicked!")
end)

-- Add toggle with callback
simpz:CreateToggle(WelcomeSection, "Enable Feature", false, function(value)
    print("Toggle set to:", value)
end)

-- Add slider with callback
simpz:CreateSlider(FeaturesSection, "Walk Speed", {
    min = 16,
    max = 100,
    default = 16,
    suffix = " studs"
}, function(value)
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

-- Settings tab elements
local GameSection = simpz:CreateSection(SettingsTab, "Game Settings")

simpz:CreateDropdown(GameSection, "Graphics Quality", {
    items = {"Low", "Medium", "High", "Ultra"},
    default = "Medium"
}, function(selected)
    print("Quality set to:", selected)
end)

-- Dynamic element creation
for i = 1, 3 do
    simpz:CreateButton(GameSection, "Option " .. i, function()
        print("Option", i, "selected")
    end)
end
```

## Notes

- UI components are built to be responsive and intuitive
- All elements have consistent theming and styling
- Sections automatically adjust height based on content
- Callback functions provide real-time updates

## License

MIT License - Feel free to use and modify for your own projects.

## Credits

- Created by empty?
