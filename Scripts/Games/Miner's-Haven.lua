local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Value = LocalPlayer.Rebirths

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Any1Cake/Roblox/main/Libraries/Wally-V2-Remastered/Library-Code.lua", true))()
library.options.underlinecolor = 'rainbow'
library.options.toggledisplay = 'Fill'
local mainW = library:CreateWindow("Miner's Haven")
local SectionFarm = mainW:Section('Rebirth', true)

-- Anti-AFK
local vu = game:GetService("VirtualUser")
Players.LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

local function loadLayouts()
    task.spawn(function()
        game:GetService("ReplicatedStorage").Layouts:InvokeServer("Load", getgenv().layoutone)
        task.wait(getgenv().duration)
        if mainW.flags.seclayout then
            game:GetService("ReplicatedStorage").Layouts:InvokeServer("Load", getgenv().layoutwo)
        end
    end)
end

local function farmRebirth()
    task.spawn(function()
        while mainW.flags.aReb do
            game:GetService("ReplicatedStorage").Rebirth:InvokeServer(26)
            task.wait()
        end
    end)
end

local function autoLoad()
    task.spawn(function()
        task.wait(0.75)
        if mainW.flags.rebfarm then
            loadLayouts()
        end
    end)
end

-- Enable Rebirth Farming
local reFarm = mainW:Toggle('Rebirth Farm', {flag = "rebfarm"}, function()
    if mainW.flags.rebfarm then
        loadLayouts()
        farmRebirth()
    end
end)

-- Enable Second Layout
local tFarm = mainW:Toggle('Enable Second Layout?', {flag = "seclayout"}, function()
    -- Additional functionality when enabled
end)

-- Auto Rebirth Toggle
local autoReb = mainW:Toggle('Auto Rebirth', {flag = "aReb"}, function()
    farmRebirth()
end)

-- Input time between layouts
local timeBox = mainW:Box('Time Between Lays', {
    default = 0,
    type = 'number',
    min = 0,
    max = 60,
    flag = 'duration',
    location = {getgenv()}
}, function(new)
    getgenv().duration = new
end)

-- Select First Layout
mainW:Dropdown("First Layout", {
    default = nil,
    location = getgenv(),
    flag = "layoutone",
    list = {
            "Layout1",
            "Layout2",
            "Layout3"
            }
}, function()
    -- Additional functionality when selected
end)

-- Select Second Layout
mainW:Dropdown("Second Layout", {
    default = nil,
    location = getgenv(),
    flag = "layoutwo",
    list = {
            "Layout1",
            "Layout2",
            "Layout3"
            }
}, function()
    -- Additional functionality when selected
end)

-- Auto Load on Value change
Value:GetPropertyChangedSignal("Value"):Connect(autoLoad)

-- Box Section
local SectionBox = mainW:Section('Boxes', true)

-- Get the location of player
local old = game.Players.LocalPlayer.Character:getChildren()
for i=1,#old do  
    if old[i].Name == "HumanoidRootPart" then 
        lastPos = old[i].CFrame 
    end
end

-- Auto Tp to Boxes
-- Credits to https://forum.wearedevs.net/profile?uid=53396 for the script 
local function autoTpToBoxes()
    while mainW.flags.BoxTp do
        local plr = game:GetService("Players").LocalPlayer
        local char = plr.Character
        local bxs = game:GetService("Workspace").Boxes
        local i = 1

        if #bxs:GetChildren() == 0 then
            plr.Character.HumanoidRootPart.CFrame = lastPos
        else
            local v = bxs:GetChildren()[i]
            char:MoveTo(v.Position)
            wait(0.75)
            i = i % #bxs:GetChildren() + 1
        end
        wait() -- Add a small delay to prevent high CPU usage
    end
end

local TptoBoxes = mainW:Toggle('Auto Tp to Boxes', {flag = "BoxTp",}, function()
    if mainW.flags.BoxTp then
        autoTpToBoxes()
    end
end)

-- Auto Open Box Function
local function BoxOpener()
    task.spawn(function()
        while mainW.flags.OpenBox do
            game.ReplicatedStorage.MysteryBox:InvokeServer(getgenv().TargetBox)
            wait() -- Wait before opening the box again
        end
    end)
end

-- Auto Open Box Toggle
local autoBoxOpener = mainW:Toggle('Auto Open Box', {flag = "OpenBox"}, function()
    if mainW.flags.OpenBox then
        BoxOpener()
    end
end)

-- Select Target Box Dropdown
mainW:Dropdown('Select Box', {
    default = 'Select Box',
    location = getgenv(),
    flag = 'TargetBox',
    list = {
            'Regular',
            'Unreal',
            'Inferno',
            'Cake Raffle',
            'Pumkin',
            'Luxury',
            'Red-Banded',
            'Spectral',
            'Heavenly',
            'Magnificent',
            'Festive',
            'Easter',
            'Birthday',
            'Twitch'
            }
}, function()
    -- Additional functionality when selected
end)

-- Misc Section
local SectionNPC = mainW:Section('Misc', true)

local AutoKick = mainW:Toggle('Auto Leave', {flag = "DisBoxTp",}, function()
    while mainW.flags.DisBoxTp do
        if #game.Players:GetChildren() > 1 then
            game.Players.LocalPlayer:Kick("Someone Joined")
        end
        wait(1) -- Add a delay to avoid excessive checks
    end
end)

local TpButton = mainW:Button('Teleport To', function()
    if getgenv().NpcName then
        teleportToNPC()
    end
end)

mainW:Dropdown("Teleport To", {
    default = "Select Npc",
    location = getgenv(),
    flag = "NpcName",
    list = {
        "Masked Man",
        "Spook's McDooks",
        "Craftsman",
        "Draedon",
        "Fargield",
        "JohnDoe",
        "Fleabag",
        "Zalgo",
        "Data Reset",
    }
}, function(value)
    getgenv().NpcName = value
end)

function teleportToNPC()
    local plr = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not plr then
        warn("HumanoidRootPart not found in character!")
        return
    end

    local map = game.Workspace.Map
    local npcname = getgenv().NpcName
    local npcLocations = {
        ["Masked Man"] = function()
            return game.Workspace.Market.UpperTorso.CFrame 
        end,
        ["Fargield"] = function() 
            return map.Fargield.UpperTorso.CFrame 
        end,
        ["JohnDoe"] = function() 
            return map.JohnDoe.Model.UpperTorso.CFrame 
        end,
        ["Fleabag"] = function() 
            return map.Fleabag.Fleabag.UpperTorso.CFrame 
        end,
        ["Spook's McDooks"] = function()
            plr.CFrame = map.TeleporterModel:GetChildren()[6].CFrame
            wait(0.5)
            return map.SpookMcDook.Model.UpperTorso.CFrame 
        end,
        ["Craftsman"] = function() 
            plr.CFrame = map.TeleporterModel:GetChildren()[1].CFrame
            wait(0.5)
            return map.WizardDude.HumanoidModel:GetChildren()[2].UpperTorso.CFrame 
        end,
        ["Draedon"] = function() 
            plr.CFrame = map.TeleporterModel:GetChildren()[2].CFrame
            wait(0.5)
            return map.Draedon.Model.UpperTorso.CFrame 
        end,
        ["Zalgo"] = function() 
            plr.CFrame = map.TeleporterModel:GetChildren()[7].CFrame
            wait(0.5)
            return map.Zalgo.UpperTorso.CFrame 
        end,
        ["Data Reset"] = function() 
            plr.CFrame = map.TeleporterModel:GetChildren()[7].CFrame
            wait(0.5)
            return map.DataResetModel.Model.Model.UpperTorso.CFrame 
        end,
    }

    if npcLocations[npcname] then
        local location = npcLocations[npcname]() * CFrame.new(0, 5, 0)
        plr.CFrame = location
    else
        warn("NPC not found in locations table!")
    end
end