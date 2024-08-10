local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/Any1Cake/Roblox/main/Libraries/Rayfield-UI-Library/source.lua', true))()

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
local WorkSpace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Value = LocalPlayer.Rebirths

local Tab1 = Window:CreateTab("Main", nil)
Tab1.flags = {} -- Initialize the flags table
local MainSection = Tab1:CreateSection("Rebirth")

local function loadLayouts()
    task.spawn(function()
        ReplicatedStorage.Layouts:InvokeServer("Load", Tab1.flags.layoutone)
        task.wait(getgenv().duration)
        if Tab1.flags.autolayout2 then
            ReplicatedStorage.Layouts:InvokeServer("Load", Tab1.flags.layouttwo)
        end
    end)
end

local function AutoRebirth()
    task.spawn(function()
        while Tab1.flags.autoRebirth do
            ReplicatedStorage.Rebirth:InvokeServer(26)
            task.wait()
        end
    end)
end

local function autoLoad()
    task.spawn(function()
        task.wait(0.75)
        if Tab1.flags.autolayout1 then
            loadLayouts()
        end
    end)
end

local Button = Tab1:CreateButton({
    Name = "Destroy UI",
    Callback = function()
        Rayfield:Destroy()
    end,
})

local ToggleAutoRebirth = Tab1:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Flag = "autoRebirth",
    Callback = function(Value)
        Tab1.flags.autoRebirth = Value
        if Value then
            AutoRebirth()
        end
    end,
})

local ToggleAutoLayouts = Tab1:CreateToggle({
    Name = "Auto Layouts",
    CurrentValue = false,
    Flag = "autolayout1",
    Callback = function(Value)
        Tab1.flags.autolayout1 = Value
        if Value then
            loadLayouts()
            AutoRebirth()
        end
    end,
})

local ToggleSecondLayout = Tab1:CreateToggle({
    Name = "Enable Second Layout",
    CurrentValue = false,
    Flag = "autolayout2",
    Callback = function(Value)
        Tab1.flags.autolayout2 = Value
    end,
})

local TimeInput = Tab1:CreateInput({
    Name = "Time Between Layouts",
    PlaceholderText = "Input Number",
    RemoveTextAfterFocusLost = false,
    Callback = function(Time)
        getgenv().duration = Time
    end,
})

local DropdownFirstLayout = Tab1:CreateDropdown({
    Name = "First Layout",
    Options = {"Layout1","Layout2","Layout3"},
    CurrentOption = "Layout1", -- Single string since MultipleOptions is false
    MultipleOptions = false,
    Flag = "layoutone",
    Callback = function(Option)
        local selectedOption = Option[1]
        Tab1.flags.layoutone = selectedOption
    end,
})

local DropdownSecondLayout = Tab1:CreateDropdown({
    Name = "Second Layout",
    Options = {"Layout1","Layout2","Layout3"},
    CurrentOption = "Layout1", -- Single string since MultipleOptions is false
    MultipleOptions = false,
    Flag = "layouttwo",
    Callback = function(Option)
        local selectedOption = Option[1]
        Tab1.flags.layouttwo = selectedOption
    end,
})

Value:GetPropertyChangedSignal("Value"):Connect(autoLoad)

local Tab2 = Window:CreateTab("Boxes", nil)
local MainSection = Tab2:CreateSection("Boxes")

local function BoxOpener()
    task.spawn(function()
        while mainW.flags.OpenBox do
            game.ReplicatedStorage.MysteryBox:InvokeServer(getgenv().TargetBox)
            wait() -- Wait before opening the box again
        end
    end)
end

local ToggleAutoTpBox = Tab2:CreateToggle({
    Name = "Auto Tp To Boxes",
    CurrentValue = false,
    Flag = "autoTpBox",
    Callback = function(Value)
        Tab2.flags.autoTpBox = Value
    end,
})

local ToggleAutoOpenBox = Tab2:CreateToggle({
    Name = "Auto Open Boxes",
    CurrentValue = false,
    Flag = "autoOpenBox",
    Callback = function(Value)
        Tab2.flags.autoTpBox = Value
        if Value then
            BoxOpener()
        end
    end,
})
