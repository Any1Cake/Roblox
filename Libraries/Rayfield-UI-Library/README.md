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

### Updating a Toggle
```lua
Toggle:Set(false)
```
