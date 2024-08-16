local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/Any1Cake/Roblox/main/Libraries/Rayfield-UI-Library/source.lua', true))()

local Window = Rayfield:CreateWindow({
    Name = "Miner's Haven",
    LoadingTitle = "Loading Script",
    LoadingSubtitle = "By Any1cake",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = "Any1cakeScripts",
       FileName = "Miner's Haven"
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
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0),Workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0),Workspace.CurrentCamera.CFrame)
end)

local Tab1 = Window:CreateTab("Main", nil)
local MainSection = Tab1:CreateSection("Rebirth")

local Value = LocalPlayer.Rebirths

local function loadLayouts()
    task.spawn(function()
        ReplicatedStorage.Layouts:InvokeServer("Load", Rayfield.Flags.layoutone)
        task.wait(getgenv().duration)
        if Rayfield.Flags.autolayout2 then
            ReplicatedStorage.Layouts:InvokeServer("Load", Rayfield.Flags.layouttwo)
        end
    end)
end

local function AutoRebirth()
    task.spawn(function()
        while Rayfield.Flags.autoRebirth do
            ReplicatedStorage.Rebirth:InvokeServer(26)
            task.wait()
        end
    end)
end

local function autoLoad()
    task.spawn(function()
        task.wait(0.75)
        if Rayfield.Flags.autolayout1 then
            loadLayouts()
        end
    end)
end

local ToggleAutoRebirth = Tab1:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Flag = "autoRebirth",
    Callback = function(Value)
        if Rayfield.Flags.autoRebirth then
            AutoRebirth()
        end
    end,
})

local ToggleAutoLayouts = Tab1:CreateToggle({
    Name = "Auto Layouts",
    CurrentValue = false,
    Flag = "autolayout1",
    Callback = function(Value)
        if Rayfield.Flags.autolayout1 then
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
    CurrentOption = "Layout1",
    MultipleOptions = false,
    Flag = "layoutone",
    Callback = function(Option)
    end,
})

local DropdownSecondLayout = Tab1:CreateDropdown({
    Name = "Second Layout",
    Options = {"Layout1","Layout2","Layout3"},
    CurrentOption = "Layout1",
    MultipleOptions = false,
    Flag = "layouttwo",
    Callback = function(Option)
    end,
})

Value:GetPropertyChangedSignal("Value"):Connect(autoLoad)

local Tab2 = Window:CreateTab("Boxes", nil)
local Section2 = Tab2:CreateSection("Boxes")

local function BoxOpener()
    task.spawn(function()
        while Rayfield.Flags.autoOpenBox do
            if Rayfield.Flags.TargetBox == "Open All Boxes" then
                
                local boxList = {
                                "Regular","Unreal","Inferno","Luxury","Red-Banded",
                                "Spectral","Magnificent","Heavenly","Pumkin","Festive",
                                "Easter","Birthday","Cake Raffle","Twitch",
                            }
                
                for _, boxName in ipairs(boxList) do
                    ReplicatedStorage.MysteryBox:InvokeServer(boxName)
                    wait()
                end
            else
                ReplicatedStorage.MysteryBox:InvokeServer(Rayfield.Flags.TargetBox)
                wait()
            end
        end
    end)
end

local ToggleAutoTpBox = Tab2:CreateToggle({
    Name = "Auto Tp To Boxes",
    CurrentValue = false,
    Flag = "autoTpBox",
    Callback = function(Value)
    end,
})

local ToggleAutoOpenBox = Tab2:CreateToggle({
    Name = "Auto Open Boxes",
    CurrentValue = false,
    Flag = "autoOpenBox",
    Callback = function(Value)
        if Rayfield.Flags.autoOpenBox then
            BoxOpener()
        end
    end,
})

local DropdownBox = Tab2:CreateDropdown({
    Name = "Select Box",
    Options = {
                "Open All Boxes",
                "Regular","Unreal","Inferno","Luxury","Red-Banded",
                "Spectral","Magnificent","Heavenly","Pumkin","Festive",
                "Easter","Birthday","Cake Raffle","Twitch",
            },
    CurrentOption = "Open All Boxes",
    MultipleOptions = false,
    Flag = "TargetBox",
    Callback = function(Option)
    end,
})

task.spawn(function()
    local lastPos = LocalPlayer.Character.HumanoidRootPart.CFrame
    local stoptp = true
    while true do
        local char = LocalPlayer.Character
        local bxs = Workspace.Boxes
        
        if Rayfield.Flags.autoTpBox and #bxs:GetChildren() >= 1 then
            for _, v in ipairs(bxs:GetChildren()) do
                char:MoveTo(v.Position)
                wait(0.75)
                stoptp = false
            end
        elseif #bxs:GetChildren() == 0 and not stoptp then 
            char.HumanoidRootPart.CFrame = lastPos
                stoptp = true        
        else
            lastPos = char.HumanoidRootPart.CFrame            
        end
        task.wait(1)
    end
end)

local Tab3 = Window:CreateTab("Misc", nil)
local Section3 = Tab3:CreateSection("Npc")

local function teleportToNPC()
    local plr = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not plr then
        error("HumanoidRootPart not found in character!")
        return
    end

    local Map = Workspace.Map
    local npcName = Rayfield.Flags.NpcName
    local npcLocations = {
        ["Masked Man"] = function() return Workspace.Market.UpperTorso.CFrame end,
        ["Fargield"] = function() return Map.Fargield.UpperTorso.CFrame end,
        ["JohnDoe"] = function() return Map.JohnDoe.Model.UpperTorso.CFrame end,
        ["Fleabag"] = function() return Map.Fleabag.Fleabag.UpperTorso.CFrame end,
        ["Spook's McDooks"] = function()
            plr.CFrame = Map.TeleporterModel:GetChildren()[6].CFrame
            wait(0.5)
            return Map.SpookMcDook.Model.UpperTorso.CFrame end,
        ["Craftsman"] = function() 
            plr.CFrame = Map.TeleporterModel:GetChildren()[1].CFrame
            wait(0.5)
            return Map.WizardDude.HumanoidModel:GetChildren()[2].UpperTorso.CFrame end,
        ["Draedon"] = function() 
            plr.CFrame = Map.TeleporterModel:GetChildren()[2].CFrame
            wait(0.5)
            return Map.Draedon.Model.UpperTorso.CFrame end,
        ["Zalgo"] = function() 
            plr.CFrame = Map.TeleporterModel:GetChildren()[7].CFrame
            wait(0.5) 
            return Map.Zalgo.UpperTorso.CFrame end,
        ["Data Reset"] = function() 
            plr.CFrame = Map.TeleporterModel:GetChildren()[7].CFrame
            wait(0.5)
            return Map.DataResetModel.Model.Model.UpperTorso.CFrame end,
    }

    if npcLocations[npcName] then
        local location = npcLocations[npcName]() * CFrame.new(0, 5, 0)
        plr.CFrame = location
    end
end

local function KickPlayer()
    task.spawn(function ()
        while true do
            if#Players:GetPlayers() > 1 then
                LocalPlayer:Kick("Someone Joined")
            end
            wait(0.5)
        end
    end)
end

local ButtonTpBase = Tab3:CreateButton({
    Name = "Teleport To Base",
    Callback = function()
        for _, v in pairs(Workspace.Tycoons:GetDescendants()) do
            if string.match(v.Name, 'Factory%d') and v.Owner.Value == LocalPlayer.Name then
                LocalPlayer.Character.HumanoidRootPart.CFrame = v.Base.CFrame * CFrame.new(0, 5, 0)
            end
        end
    end,
})

local ButtonTpNpc = Tab3:CreateButton({
    Name = "Teleport To",
    Callback = function()
        if Rayfield.Flags.NpcName then 
            teleportToNPC()
        end
    end,
})

 local DropdownNpc = Tab3:CreateDropdown({
    Name = "Select Npc",
    Options = {
                "Masked Man",
                "Spook's McDooks",
                "Craftsman",
                "Draedon",
                "Fargield",
                "JohnDoe",
                "Fleabag",
                "Zalgo",
                "Data Reset",
            },
    CurrentOption = "Masked Man",
    MultipleOptions = false,
    Flag = "NpcName",
    Callback = function(Option)
    end,
})

local Section31 = Tab3:CreateSection("Random")

local ToggleAutoKick = Tab3:CreateToggle({
    Name = "Auto Kick",
    CurrentValue = false,
    Flag = "autoKick",
    Callback = function(Value)
        if Rayfield.Flags.autoKick then
            KickPlayer()
        end
    end,
})

local Button = Tab3:CreateButton({
    Name = "Destroy UI",
    Callback = function()
        Rayfield:Destroy()
    end,
})

Rayfield:LoadConfiguration()