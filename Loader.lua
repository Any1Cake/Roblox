local SaveExecution = true 
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
    [9772878203] = "Raise a Floppa 2"
}

local isGameFound = false
local isGameExecuted = isGameExecutedValue.Value
local CoreGui = game:GetService("StarterGui")
for placeId, gameName in pairs(games) do
    if game.PlaceId == placeId then
        isGameFound = true
        if not isGameExecuted then
            isGameExecutedValue.Value = SaveExecution
            local formattedGameName = gameName:gsub("%s+", "-") -- Replace spaces with your choice
            local scriptURL = "https://raw.githubusercontent.com/Any1Cake/Roblox/main/Scripts/Games/" .. formattedGameName .. ".lua"
            
            CoreGui:SetCore("SendNotification", {
                Title = "Game Found!",
                Text = "Executing " .. gameName .. " Script",
                Icon = "rbxassetid://10885644072",
                Duration = 2.5,
            })
            
            loadstring(game:HttpGet(scriptURL, true))()

            
            local vu = game:GetService("VirtualUser")
                Players.LocalPlayer.Idled:connect(function()
                vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                task.wait(1)
                vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            end)
            
        else
            CoreGui:SetCore("SendNotification", {
                Title = "Game Already Executed!",
                Text = "The game script has already been executed.",
                Icon = "rbxassetid://10885644072",
                Duration = 2.5,
            })
        end
    end
end

if not isGameFound then
    CoreGui:SetCore("SendNotification", {
        Title = "Game Not Found!",
        Text = "The game you are playing is not in the list.",
        Icon = "rbxassetid://10885644072",
        Duration = 2.5,
    })
end
