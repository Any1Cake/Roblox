# Orion Library
This documentation is for the stable release of Orion Library.

## Booting the Library
```lua
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/Any1Cake/Roblox/main/Libraries/Orion-UI-Library/source.lua', true))()
```

## Creating a Window
```lua
local Window = OrionLib:MakeWindow({
	Name = "Title of the library", -- The name of the UI.
	HidePremium = false, -- Whether or not the user details shows Premium status or not.
	SaveConfig = true, -- Toggles the config saving in the UI.
	ConfigFolder = "OrionTest", -- The name of the folder where the configs are saved.
	IntroEnabled = true, -- Whether or not to show the intro animation.
	IntroText = "OrionTest", -- Text to show in the intro animation.
	IntroIcon = "OrionTest", -- URL to the image you want to use in the intro animation.
	Icon = nil, -- URL to the image you want displayed on the window.
	CloseCallback = function() 
	-- Function to execute when the window is closed.
	end
})
```

## Creating a Tab
```lua
local Tab1 = Window:MakeTab({
	Name = "OrionTest", -- The name of the tab.
	Icon = "rbxassetid://4483345998", -- The icon of the tab.
	PremiumOnly = false -- Makes the tab accessible to Sirus Premium users only.
})
```

## Creating a Section
```lua
local Section = Tab1:AddSection({
	Name = "OrionTest" -- The name of the section.
})
```
You can add elements to sections the same way you would add them to a tab normally.

## Notifying the user
```lua
OrionLib:MakeNotification({
	Name = "Title!", -- The name of the notification.
	Content = "Notification content... what will it say??", -- The content of the notification.
	Image = "rbxassetid://4483345998", -- The icon of the notification.
	Time = 5 -- The duration of the notfication.
})
```

## Creating a Button
```lua
local Button = Tab:AddButton({
	Name = "Button!", -- The name of the button.
	Callback = function() -- The function of the button.
      		print("button pressed")
  	end
})
```

## Creating a Checkbox toggle
```lua
local Toggle = Tab:AddToggle({
	Name = "This is a toggle!", -- The name of the toggle.
	Default = false, -- The default value of the toggle.
	Save = true, -- Set this to true if you want to save this element in config
	Flag = "Toggle" -- A flag is the identifier for the config file, make sure every element has a different flag if you're using SaveConfig to ensure no overlaps
	Callback = function(Value) 
		print(Value) -- The function of the toggle.
	end    
})
```

### Changing the value of an existing Toggle
```lua
Toggle:Set(true)
```

## Creating a Color Picker
```lua
local ColorPicker = Tab:AddColorpicker({
	Name = "Colorpicker", -- The name of the colorpicker.
	Default = Color3.fromRGB(255, 0, 0), -- The default value of the colorpicker.
	Save = true, -- Set this to true if you want to save this element in config
	Flag = "ColorPicker" -- A flag is the identifier for the config file, make sure every element has a different flag if you're using SaveConfig to ensure no overlaps
	Callback = function(Value) 
		print(Value) -- The function of the colorpicker.
	end	  
})
```

### Setting the color picker's value
```lua
ColorPicker:Set(Color3.fromRGB(255,255,255))
```

## Creating a Slider
```lua
local Slider = Tab:AddSlider({
	Name = "Slider", -- The name of the slider.
	Min = 0, -- The minimal value of the slider.
	Max = 20, -- The maxium value of the slider.
	Default = 5, -- The default value of the slider.
	Increment = 1, -- How much the slider will change value when dragging.
	ValueName = "Slider" -- The text after the value number.
	Color = Color3.fromRGB(255,255,255),
	Save = true, -- Set this to true if you want to save this element in config
	Flag = "Slider" -- A flag is the identifier for the config file, make sure every element has a different flag if you're using SaveConfig to ensure no overlaps
	Callback = function(Value)
		print(Value) -- The function of the slider.
	end    
})
```

### Change Slider Value
```lua
Slider:Set(2)
```

## Creating a Label
```lua
local Label = Tab:AddLabel("Label")
```

### Changing the value of an existing label
```lua
Label:Set("Label New!")
```

## Creating a Paragraph
```lua
local Paragraph = Tab:AddParagraph("Paragraph","Paragraph Content")
```

### Changing an existing Paragraph
```lua
Paragraph:Set("Paragraph New!", "New Paragraph Content!")
```

## Creating an Adaptive Input
```lua
local TextBox = Tab:AddTextbox({
	Name = "Textbox", -- The name of the textbox.
	Default = 0, -- The default value of the textbox.
	TextDisappear = false -- Makes the text disappear in the textbox after losing focus.
	Callback = function(Value)
		print(Value) -- The function of the textbox.
	end	  
})
```

## Creating a Keybind
```lua
local Bind = Tab:AddBind({
	Name = "Bind", -- The name of the bind.
	Default = Enum.KeyCode.E, -- The default value of the bind.
	Hold = false, -- Makes the bind work like: Holding the key > The bind returns true, Not holding the key > Bind returns false.
	Save = true, -- Set this to true if you want to save this element in config
	Flag = "KeyBind" -- A flag is the identifier for the config file, make sure every element has a different flag if you're using SaveConfig to ensure no overlaps
	Callback = function()
		print("press") -- The function of the bind.
	end    
})
```

### Changing the value of a bind
```lua
Bind:Set(Enum.KeyCode.E)
```

## Creating a Dropdown menu
```lua
local Dropdown = Tab:AddDropdown({
	Name = "Dropdown", -- The name of the dropdown.
	Default = "1", -- The default value of the dropdown.
	Options = {"1", "2"}, -- The options in the dropdown.
	Save = true, -- Set this to true if you want to save this element in config
	Flag = "Dropdown" -- A flag is the identifier for the config file, make sure every element has a different flag if you're using SaveConfig to ensure no overlaps
	Callback = function(Value)
		print(Value) -- The function of the dropdown.
	end    
})
```

### Adding a set of new Dropdown buttons to an existing menu
```lua
Dropdown:Refresh(List<table>,true)
```

The above boolean value "true" is whether or not the current buttons will be deleted.
### Selecting a dropdown option
```lua
Dropdown:Set("dropdown option")
```

# Finishing your script (REQUIRED)
The below function needs to be added at the end of your code.
```lua
OrionLib:Init()
```

### How flags work.
The flags feature in the ui may be confusing for some people. It serves the purpose of being the ID of an element in the config file, and makes accessing the value of an element anywhere in the code possible.
Below in an example of using flags.
```lua
local Toggle = Tab1:AddToggle({
    Name = "Toggle",
    Default = true,
    Save = true,
    Flag = "Toggle"
})

print(OrionLib.Flags["Toggle"].Value) -- prints the value of the toggle.
```
Flags only work with the toggle, slider, dropdown, bind, and colorpicker.

### Making your interface work with configs.
In order to make your interface use the configs function you first need to add the `SaveConfig` and `ConfigFolder` arguments to your window function. The explanation of these arguments in above.

Then you need to add the `Flag` and `Save` values to every toggle, slider, dropdown, bind, and colorpicker you want to include in the config file.
- The `Flag = <string>` argument is the ID of an element in the config file.
- The `Save = <bool>` argument includes the element in the config file.

Config files are made for every game the library is launched in.

## Destroying the Interface
```lua
OrionLib:Destroy()
```
