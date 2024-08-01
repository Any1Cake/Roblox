--loadstring(game:HttpGet(https://raw.githubusercontent.com/Any1Cake/Roblox/main/Loader.lua, true))()
local repo = "https://raw.githubusercontent.com/Any1Cake/Roblox/main/Scripts/Games/"

local function LoadScript(ScriptName)
    local CoreGui = game:GetService("StarterGui")
    
    pcall(function()
        local t = 0
        repeat
            local s, r = pcall(function()
                loadstring(game:HttpGet(repo .. ScriptName, true))()
            end)
            if not success then
                spawn(function()
                    error(r)
                end)
            end
            t = t + 1
            wait(1)
        until getgenv().Executed or t >= 1
    end)
    
    -- Notification for script loaded
    CoreGui:SetCore("SendNotification", {
        Title = "Script Loaded",
        Text = "The script has been successfully loaded.",
        Icon = "rbxassetid://10885644072",
        Duration = 2.5,
    })
end

local Id = game.PlaceId
local GameId = game.GameId

local PlaceIds = {
    ["Miner's Haven"] = {258258996, "Miner's-Haven.lua"},
    ["Restaurant Tycoon 2"] = {3398014311, "Restaurant-Tycoon-2.lua"},
    -- Add more games here in the format: ["GameName"] = {GameId, "ScriptName.lua"},
}

local isGameSupported = false
local supportedGameName = ""
for gameName, gameInfo in pairs(PlaceIds) do
    if table.find(gameInfo, GameId) then
        isGameSupported = true
        supportedGameName = gameName
        break
    end
end

if isGameSupported then
    -- Notification for supported game and loading
    game.StarterGui:SetCore("SendNotification", {
        Title = "Game Supported",
        Text = "Loading " .. supportedGameName .. " script",
        Icon = "rbxassetid://10885644072",
        Duration = 2.5,
    })
    
    LoadScript(PlaceIds[supportedGameName][2])
else
    -- Notification for unsupported game
    game.StarterGui:SetCore("SendNotification", {
        Title = "Game Not Supported",
        Text = "This game is not supported by the script.",
        Icon = "rbxassetid://10885644072",
        Duration = 2.5,
    })
end
