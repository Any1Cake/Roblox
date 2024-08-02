local SaveExecution = true -- Set the flag to true in BoolValue

local replicatedStorage = game:GetService("ReplicatedStorage")
local isGameExecutedValue = replicatedStorage:FindFirstChild("IsGameExecuted")
if not isGameExecutedValue then
    isGameExecutedValue = Instance.new("BoolValue")
    isGameExecutedValue.Name = "IsGameExecuted"
    isGameExecutedValue.Parent = replicatedStorage
end

local games = {
    [258258996] = "Miner's Haven",
    [3398014311] = "Restaurant Tycoon 2",
}

local isGameFound = false
local isGameExecuted = isGameExecutedValue.Value -- Retrieve the flag from BoolValue
local CoreGui = game:GetService("StarterGui")
for placeId, gameName in pairs(games) do
    if game.PlaceId == placeId then
        isGameFound = true
        if not isGameExecuted then -- Check if the game script has not been executed yet
            isGameExecutedValue.Value = SaveExecution
            local formattedGameName = gameName:gsub("%s+", "-") -- Replace spaces with your choice
            local scriptURL = "https://raw.githubusercontent.com/Any1Cake/Roblox/main/Scripts/Games/" .. formattedGameName .. ".lua"
            
            CoreGui:SetCore("SendNotification", {
                Title = "Game Found!",
                Text = "Executing " .. gameName .. " Script",
                Icon = "rbxassetid://10885644072",
                Duration = 1.5,
            })
            loadstring(game:HttpGet(scriptURL, true))()
        else
            CoreGui:SetCore("SendNotification", {
                Title = "Game Already Executed!",
                Text = "The game script has already been executed.",
                Icon = "rbxassetid://10885644072",
                Duration = 1.5,
            })
        end
    end
end

if not isGameFound then
    CoreGui:SetCore("SendNotification", {
        Title = "Game Not Found!",
        Text = "The game you are playing is not in the list.",
        Icon = "rbxassetid://10885644072",
        Duration = 1.5,
    })
end