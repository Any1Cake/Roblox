# Rayfield Interface Suite
## Secure Mode

### ⚠️ WARNING

If the game you're trying to run Rayfield Interface Suite on, is detecting or crashing when you use Rayfield Interface Suite, try using Secure Mode by Placing this
```lua
getgenv().SecureMode = true
```
above the initial Rayfield loadstring

### ℹ NOTE

This may cause some elements of the UI to look lower quality or may increase loading times slightly

## Enabling Configuration Saving

1. Enable ConfigurationSaving in the CreateWindow function

2. Choose an appropiate FileName in the CreateWindow function

3. Choose an unique flag identifier for each supported element you create

4. Place Rayfield:LoadConfiguration() at the bottom of all your code

## Loading the library

```lua
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Any1Cake/Roblox/main/Libraries/Rayfield-UI-Library/source.lua'))()
```

# Windows in Rayfield

## Creating a Window

```lua
local Window = Rayfield:CreateWindow({
   Name = "Rayfield Example Window",
   LoadingTitle = "Rayfield Interface Suite",
   LoadingSubtitle = "by Sirius",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },
   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})
```

### Creating a Tab
```lua
local Tab = Window:CreateTab("Tab Example", 4483362458) -- Title, Image
```

### Creating a Section
```lua
local Section = Tab:CreateSection("Section Example")
```

### Updating a Section
```lua
Section:Set("Section Example")
```

### Destroying the Interface
```lua
Rayfield:Destroy()
```

# Adding interactive elements

## Notifying the user
```lua
Rayfield:Notify({
   Title = "Notification Title",
   Content = "Notification Content",
   Duration = 6.5,
   Image = 4483362458,
   Actions = { -- Notification Buttons
      Ignore = {
         Name = "Okay!",
         Callback = function()
         print("The user tapped Okay!")
      end
   },
},
})
```

## Creating a Button
```lua
local Button = Tab:CreateButton({
   Name = "Button Example",
   Callback = function()
   -- The function that takes place when the button is pressed
   end,
})
```

### Updating a Button
```lua
Button:Set("Button Example")
```

## Creating a Toggle
```lua
local Toggle = Tab:CreateToggle({
   Name = "Toggle Example",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
   -- The function that takes place when the toggle is pressed
   -- The variable (Value) is a boolean on whether the toggle is true or false
   end,
})
```

## Creating a Color Picker
```lua
local ColorPicker = Tab:CreateColorPicker({
    Name = "Color Picker",
    Color = Color3.fromRGB(255,255,255),
    Flag = "ColorPicker1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        -- The function that takes place every time the color picker is moved/changed
        -- The variable (Value) is a Color3fromRGB value based on which color is selected
    end
})
```

### Updating a Color Picker
```lua
ColorPicker:Set(Color3.fromRGB(255,255,255))
```

## Creating a Slider
```lua
local Slider = Tab:CreateSlider({
   Name = "Slider Example",
   Range = {0, 100},
   Increment = 10,
   Suffix = "Bananas",
   CurrentValue = 10,
   Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
   -- The function that takes place when the slider changes
   -- The variable (Value) is a number which correlates to the value the slider is currently at
   end,
})
```

### Updating a Slider
```lua
Slider:Set(10) -- The new slider integer value
```

## Creating an Adaptive Input (TextBox)
```lua
local Input = Tab:CreateInput({
   Name = "Input Example",
   PlaceholderText = "Input Placeholder",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   -- The function that takes place when the input is changed
   -- The variable (Text) is a string for the value in the text box
   end,
})
```

## Creating a Dropdown menu
```lua
local Dropdown = Tab:CreateDropdown({
   Name = "Dropdown Example",
   Options = {"Option 1","Option 2"},
   CurrentOption = {"Option 1"},
   MultipleOptions = false,
   Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Option)
   -- The function that takes place when the selected option is changed
   -- The variable (Option) is a table of strings for the current selected options
   end,
})
```

### Updating a Dropdown
```lua
Dropdown:Set({"Option 2"}) -- The new list of options
--[[Check the value of an existing element
  To check the current value of an existing element, using the variable, you can do ElementName.CurrentValue, 
  if it's a keybind or dropdown, you will need to use KeybindName.CurrentKeybind or DropdownName.CurrentOption You can also check it via the flags from Rayfield.Flags
]]
```

-- Binding keys in Rayfield
Creating a Keybind
local Keybind = Tab:CreateKeybind({
   Name = "Keybind Example",
   CurrentKeybind = "Q",
   HoldToInteract = false,
   Flag = "Keybind1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Keybind)
   -- The function that takes place when the keybind is pressed
   -- The variable (Keybind) is a boolean for whether the keybind is being held or not (HoldToInteract needs to be true)
   end,
})

-- Updating a Keybind
Keybind:Set("RightCtrl") -- Keybind (string)

--Textual elements in Rayfield
-- Creating a Label
local Label = Tab:CreateLabel("Label Example")

-- Updating a Label
Label:Set("Label Example")

-- Creating a Paragraph
local Paragraph = Tab:CreateParagraph({Title = "Paragraph Example", Content = "Paragraph Example"})

-- Updating a Paragraph
Paragraph:Set({Title = "Paragraph Example", Content = "Paragraph Example"})

### Updating a Toggle
```lua
Toggle:Set(false)
```
