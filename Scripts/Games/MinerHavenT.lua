
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/Any1Cake/Roblox/main/Libraries/Rayfield/Library-Code.lua', true))()

local Window = Rayfield:CreateWindow({
    Name = "Miner's Haven",
    LoadingTitle = "Loading Script",
    LoadingSubtitle = "By Any1cake",
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
    KeySystem = true, -- Set this to true to use our key system
    KeySettings = {
       Title = "Miner's Haven",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided",
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
})

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Value = LocalPlayer.Rebirths

local MainTab = Window:CreateTab("Main", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Rebirth")

local function loadLayouts()
    task.spawn(function()
        ReplicatedStorage.Layouts:InvokeServer("Load", MainTab.layoutone)
        task.wait(getgenv().duration)
        if MainTab.flags.autolayout2 then
            ReplicatedStorage.Layouts:InvokeServer("Load", MainTab.layouttwo)
        end
    end)
end

local function AutoRebirth()
    task.spawn(function()
        while MainTab.flags.autoRebirth do
            ReplicatedStorage.Rebirth:InvokeServer(26)
            task.wait()
        end
    end)
end

local function autoLoad()
    task.spawn(function()
        task.wait(0.75)
        if MainTab.flags.autolayout1 then
            loadLayouts()
        end
    end)
end

local Button = MainTab:CreateButton({
    Name = "Destroy UI",
    Callback = function()
        Rayfield:Destroy()
    end,
})

local Toggle = MainTab:CreateToggle({
    Name = "Auto Layouts",
    CurrentValue = false,
    Flag = "autolayout1",
    Callback = function(Value)
        if Value then
            loadLayouts()
            AutoRebirth()
        end
    end,
})

local Toggle = MainTab:CreateToggle({
    Name = "Enable Second Layout",
    CurrentValue = false,
    Flag = "autolayout2",
    Callback = function(Value)
    -- The function that takes place when the toggle is pressed
    -- The variable (Value) is a boolean on whether the toggle is true or false
    end,
})

local Toggle = MainTab:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Flag = "autoRebirth",
    Callback = function(Value)
        if Value then
            AutoRebirth()
        end
    end,
})

local Input = MainTab:CreateInput({
    Name = "Time Between Layouts",
    PlaceholderText = "Input Number",
    RemoveTextAfterFocusLost = false,
    Callback = function(Time)
        getgenv().duration = Time
    end,
})

local Dropdown = MainTab:CreateDropdown({
    Name = "First Layout",
    Options = {"Layout1","Layout2","Layout3"},
    CurrentOption = {"Layout1"},
    MultipleOptions = false,
    Flag = "layoutone",
    Callback = function(Option)
    -- The function that takes place when the selected option is changed
    -- The variable (Option) is a table of strings for the current selected options
    end,
})

local Dropdown = MainTab:CreateDropdown({
    Name = "Second Layout",
    Options = {"Layout1","Layout2","Layout3"},
    CurrentOption = {"Layout1"},
    MultipleOptions = false,
    Flag = "layouttwo",
    Callback = function(Option)
    -- The function that takes place when the selected option is changed
    -- The variable (Option) is a table of strings for the current selected options
    end,
})

-- Auto Load on Value change
Value:GetPropertyChangedSignal("Value"):Connect(autoLoad)

local SecTab = Window:CreateTab("Main", nil) -- Title, Image
local MainSection = SecTab:CreateSection("Boxes")



Rayfield:LoadConfiguration()