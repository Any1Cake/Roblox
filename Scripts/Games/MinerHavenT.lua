local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/Any1Cake/Roblox/main/Libraries/Rayfield/Library-Code.lua', true))()

local Window = Rayfield:CreateWindow({
    Name = "Miner's Haven",
    LoadingTitle = "Loading Script",
    LoadingSubtitle = "By Any1cake",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil,
       FileName = "Big Hub"
    },
    Discord = {
       Enabled = false,
       Invite = "noinvitelink",
       RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
       Title = "Miner's Haven",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided",
       FileName = "Key",
       SaveKey = true,
       GrabKeyFromSite = false,
       Key = {"Hello"}
    }
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Mouse = LocalPlayer:GetMouse()
local Value = LocalPlayer.Rebirths

local MainTab = Window:CreateTab("Main", nil)
MainTab.flags = {} -- Initialize the flags table
local MainSection = MainTab:CreateSection("Rebirth")

local function loadLayouts()
    task.spawn(function()
        ReplicatedStorage.Layouts:InvokeServer("Load", MainTab.flags.layoutone)
        task.wait(getgenv().duration)
        if MainTab.flags.autolayout2 then
            ReplicatedStorage.Layouts:InvokeServer("Load", MainTab.flags.layouttwo)
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

local ToggleAutoRebirth = MainTab:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Flag = "autoRebirth",
    Callback = function(Value)
        if Value then
            AutoRebirth()
        end
    end,
})

local ToggleAutoLayouts = MainTab:CreateToggle({
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

local ToggleSecondLayout = MainTab:CreateToggle({
    Name = "Enable Second Layout",
    CurrentValue = false,
    Flag = "autolayout2",
    Callback = function(Value)
        -- The function that takes place when the toggle is pressed
        -- The variable (Value) is a boolean on whether the toggle is true or false
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

local DropdownFirstLayout = MainTab:CreateDropdown({
    Name = "First Layout",
    Options = {"Layout1","Layout2","Layout3"},
    CurrentOption = {"Layout1"},
    MultipleOptions = false,
    Flag = "layoutone",
    Callback = function(Option)
        MainTab.flags.layoutone = Option
    end,
})

local DropdownSecondLayout = MainTab:CreateDropdown({
    Name = "Second Layout",
    Options = {"Layout1","Layout2","Layout3"},
    CurrentOption = {"Layout1"},
    MultipleOptions = false,
    Flag = "layouttwo",
    Callback = function(Option)
        MainTab.flags.layouttwo = Option
    end,
})

Value:GetPropertyChangedSignal("Value"):Connect(autoLoad)

local SecTab = Window:CreateTab("Main", nil)
local MainSection = SecTab:CreateSection("Boxes")
