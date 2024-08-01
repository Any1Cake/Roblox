local repo = "https://raw.githubusercontent.com/Any1Cake/Roblox/main/Scripts/Games/"
local function LoadScript(ScriptName)
    pcall(function()
        local t = 0
        repeat
            local s, r = pcall(function()
                loadstring(game:HttpGet(repo .. ScriptName))()
            end)
            if not s then
                spawn(function()
                    error(error)
                end)
            end
            t = t + 1
            wait(1)
        until getgenv().Executed or t >= 1
    end)
end

local Id = game.PlaceId
local GameId = game.GameId

local PlaceIds = {
    ["Miner's Haven"] = {258258996, "Miner's-Haven.lua"},
    ["Restaurant Tycoon 2"] = {3398014311, "Restaurant-Tycoon-2.lua"},
    -- Add more games here in the format: ["GameName"] = {GameId, "ScriptName.lua"},
}

for gameName, gameInfo in pairs(PlaceIds) do
    if table.find(gameInfo, GameId) then
        LoadScript(gameInfo[2])
        break
    end
end
