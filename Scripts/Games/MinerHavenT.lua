
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/Any1Cake/Roblox/main/Libraries/Rayfield/Library-Code.lua', true))()

local Window = Rayfield:CreateWindow({
    Name = "Miner's Haven",
    LoadingTitle = "Loading Script",
    LoadingSubtitle = "By Any1cake",
    ConfigurationSaving = {
       Enabled = false,
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

local MainTab = Window:CreateTab("Main", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Rebirth Farm")

local Button = MainTab:CreateButton({
    Name = "Destroy UI",
    Callback = function()
        Rayfield:Destroy()
    end,
 })

local Toggle = MainTab:CreateToggle({
    Name = "Auto Layouts",
    CurrentValue = false,
    Flag = "autolayout1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
    -- The function that takes place when the toggle is pressed
    -- The variable (Value) is a boolean on whether the toggle is true or false
    end,
})

local Toggle = MainTab:CreateToggle({
    Name = "Enable Second Layout?",
    CurrentValue = false,
    Flag = "autolayout2", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
    -- The function that takes place when the toggle is pressed
    -- The variable (Value) is a boolean on whether the toggle is true or false
    end,
})

local Input = MainTab:CreateInput({
    Name = "Time Between Layouts",
    PlaceholderText = "Input Number",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
    -- The function that takes place when the input is changed
    -- The variable (Text) is a string for the value in the text box
    end,
})