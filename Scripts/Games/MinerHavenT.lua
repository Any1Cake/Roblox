
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/MohyTheHay/Roblox/main/Rayfield-GUI-Library/Library-Code.lua'))()

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



==========================================================================
--[[]
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