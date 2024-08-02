local games = {
    [258258996] = "Miner's Haven",
    [3398014311] = "Restaurant Tycoon 2",
}

local isGameFound = false
local CoreGui = game:GetService("StarterGui")
for placeId, gameName in pairs(games) do
    if game.PlaceId == placeId then
        isGameFound = true
        local formattedGameName = gameName:gsub("%s+", "-") -- Replace spaces with hyphens
        local scriptURL = "https://raw.githubusercontent.com/Any1Cake/Roblox/main/Scripts/Games/" .. formattedGameName .. ".lua"
        
        CoreGui:SetCore("SendNotification", {
            Title = "Game Found!",
            Text = "Executing " .. gameName .. " Script",
            Icon = "rbxassetid://10885644072",
            Duration = 1.5,
        })
        loadstring(game:HttpGet(scriptURL, true))()
        break
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
