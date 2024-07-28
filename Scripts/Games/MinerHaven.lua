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

function loadLayouts()
    task.spawn(function()
        game:GetService("ReplicatedStorage").Layouts:InvokeServer("Load", getgenv().layoutone)
        task.wait(getgenv().duration)
        if mainW.flags.seclayout then
            game:GetService("ReplicatedStorage").Layouts:InvokeServer("Load", getgenv().layoutwo)
        end
    end)
end

function farmRebirth()
    task.spawn(function()
        while mainW.flags.aReb do
            game:GetService("ReplicatedStorage").Rebirth:InvokeServer(26)
            task.wait()
        end
    end)
end

function autoLoad()
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
    default = 'First Layout',
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
    default = 'Second Layout',
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
local shouldTeleport = true

local TptoBoxes = mainW:Toggle('Tp to Boxes', {flag = "BoxTp",}, function()
    while true do
        if mainW.flags.BoxTp then
            local bxs = game:GetService("Workspace").Boxes
            local plr = game:GetService("Players").LocalPlayer
            local char = plr.Character
            local i = 1

            if #bxs:GetChildren() == 0 then
                plr.Character.HumanoidRootPart.CFrame = lastPos
                shouldTeleport = true
            else
                if shouldTeleport then
                local v = bxs:GetChildren()[i]
                char:MoveTo(v.Position)
                wait(0.75)
                i = i % #bxs:GetChildren() + 1
                end
            end
        end
        wait() -- Add a small delay to prevent high CPU usage
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

-- NPC Section
local SectionNPC = mainW:Section('NPC', true)

-- Function to open a shop in the PlayerGui
local function openShop(shopName)
    game.Players.LocalPlayer.PlayerGui.GUI[shopName].Visible = true;
end

-- Define buttons to open different shops
local shopButtons = {
    {text = 'Masked Man Shop', shop = 'EventShop'},
    {text = 'Box Shop', shop = 'SpookMcDookShop'},
    --{text = 'St. Patty Shop', shop = 'Patrick'}  
}

-- Create buttons for each shop
for _, shopBtn in ipairs(shopButtons) do
    mainW:Button('Open ' .. shopBtn.text, function()
        openShop(shopBtn.shop)
    end)
end
