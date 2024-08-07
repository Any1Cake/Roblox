local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/Any1Cake/Roblox/main/Libraries/Rayfield/Library-Code.lua', true))()

local SaveExecution = true 
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local isGameExecutedValue = ReplicatedStorage:FindFirstChild("IsGameExecuted")
if not isGameExecutedValue then
    isGameExecutedValue = Instance.new("BoolValue")
    isGameExecutedValue.Name = "IsGameExecuted"
    isGameExecutedValue.Parent = ReplicatedStorage
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
            
            Rayfield:Notify({
                Title = "Script Found!",
                Content = "Executing " .. gameName .. " Script",
                Duration = 6.5,
                Image = 4483362458,
                Actions = { -- Notification Buttons
                   Ignore = {
                      Name = "Okay!",
                      Callback = function()
                   end
                },
             },
             })
            
            loadstring(game:HttpGet(scriptURL, true))()

            
            local vu = game:GetService("VirtualUser")
                Players.LocalPlayer.Idled:connect(function()
                vu:Button2Down(Vector2.new(0,0),Workspace.CurrentCamera.CFrame)
                task.wait(1)
                vu:Button2Up(Vector2.new(0,0),Workspace.CurrentCamera.CFrame)
            end)
            
        else
            Rayfield:Notify({
                Title = "Script Already Executed!",
                Content = "The game script has already been executed.",
                Duration = 6.5,
                Image = 4483362458,
                Actions = { -- Notification Buttons
                   Ignore = {
                      Name = "Okay!",
                      Callback = function()
                   end
                },
             },
             })
        end
    end
end

if not isGameFound then
    Rayfield:Notify({
        Title = "Script Not Found!",
        Content = "The game you are playing is not in the list.",
        Duration = 6.5,
        Image = 4483362458,
        Actions = { -- Notification Buttons
           Ignore = {
              Name = "Okay!",
              Callback = function()
           end
        },
     },
     })
end

