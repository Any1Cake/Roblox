warn("Anti afk running")
game:GetService("Players").LocalPlayer.Idled:connect(function()
warn("Anti afk ran")
game:GetService("VirtualUser"):CaptureController()
game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Marco8642/science/main/ui%20libs2"))()
local example = library:CreateWindow({
  text = "Trucking Empire"
})
example:AddToggle("Auto Farm", function(state)
  _G.test = (state and true or false)
while _G.test do
  wait()
pcall(function()   
  if not game:GetService("Workspace")["Puntos de Trabajo"]["Port Colombia"]:FindFirstChildOfClass("Part") then
      local car = game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent
      car.PrimaryPart = car.Body["#Weight"]
      car:SetPrimaryPartCFrame(CFrame.new(-61726.46484375, 85, 2413.074951171875))
      car.PrimaryPart.Anchored = true
      wait(2)
      car.PrimaryPart.Anchored = false
end
  if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("JobGui") then
  local car = game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent
  car.PrimaryPart = car.Body["#Weight"]
  car:SetPrimaryPartCFrame(CFrame.new(-61726.46484375, 85, 2413.074951171875))
  wait(1)
     local jobprox = nil
  local distance = math.huge
  for i,v in pairs(game:GetService("Workspace")["Puntos de Trabajo"]["Port Colombia"]:GetChildren()) do
      if v.ClassName == "Part" and v:FindFirstChildOfClass("ProximityPrompt") and v:FindFirstChildOfClass("ProximityPrompt").Enabled == true  and not game.Players.LocalPlayer.PlayerGui:FindFirstChild("JobGui")  then
  local Dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).magnitude
  if Dist < distance then
  distance = Dist
  jobprox = v
  end
  end
  end
     local car = game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent
  car.PrimaryPart = car.Body["#Weight"]
  car:SetPrimaryPartCFrame(jobprox.CFrame)
  task.wait()
      fireproximityprompt(jobprox:FindFirstChildOfClass("ProximityPrompt"))
  repeat wait()
  until game.Players.LocalPlayer.PlayerGui:FindFirstChild("JobGui") or game:GetService("Workspace"):FindFirstChild(game.Players.LocalPlayer.Name.."'s Trailer") or _G.test == false
  end
  if game.Players.LocalPlayer.PlayerGui:FindFirstChild("JobGui") then
      wait(3)
      repeat wait(0.1)
      for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.JobGui.Frame.ChooseJob.Oil_Tanker.SelectButton.MouseButton1Click)) do
          v:Fire()
          end
         until game:GetService("Players").LocalPlayer.PlayerGui.JobGui.Frame:FindFirstChild("OilFrame") or game:GetService("Workspace"):FindFirstChild(game.Players.LocalPlayer.Name.."'s Trailer") or _G.test == false
         for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.JobGui.Frame.Oil_Frame:GetChildren()) do
          if v.Name ~= "C_Carpado" then
              v:Destroy()
          end
      end
  wait()
          repeat wait()
              pcall(function()
              local loc =game:GetService("Players").LocalPlayer.PlayerGui.JobGui.Frame.OversizedFrame["C_Carpado"].InfoFrame.LOCKED
              loc.Visible = false
              mousemoverel(loc.AbsolutePosition.X+10,loc.AbsolutePosition.Y+40,1,true,game,0)
              wait(0.1)
                  mouse1click()
                  wait(0.1)
              end)
          until game:GetService("Workspace"):FindFirstChild(game.Players.LocalPlayer.Name.."'s Trailer") or not game.Players.LocalPlayer.PlayerGui:FindFirstChild("JobGui") or _G.test == false
          wait(1)
          local car = game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent
          car.PrimaryPart = car.Body["#Weight"]
          repeat wait()
          car:SetPrimaryPartCFrame(game:GetService("Workspace"):FindFirstChild(game.Players.LocalPlayer.Name.."'s Trailer").PrimaryPart.CFrame*CFrame.new(0,0,-55))
          wait(0.5)
          game:GetService("ReplicatedStorage").connect:FireServer(game:GetService("Players").LocalPlayer)
          wait(2)
          until   car.Body.connect:FindFirstChild("BallSocketConstraint") or _G.test == false
      end
  if not game:GetService("Workspace")["Delivery_Points"].Sawmill:FindFirstChild("Sawmill_Detector") then
      local car = game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent
      car.PrimaryPart = car.Body["#Weight"]
      car:SetPrimaryPartCFrame(CFrame.new(19233.404296875, 3000, -6995.3759765625))
      game:GetService("Workspace"):FindFirstChild(game.Players.LocalPlayer.Name.."'s Trailer"):SetPrimaryPartCFrame(CFrame.new(19233.404296875, 3020, -6995.3759765625))
      task.wait()
      car.PrimaryPart.Anchored = true
      wait(5)
      car.PrimaryPart.Anchored = false
  wait()
  repeat wait(0.1)
  for i,v in pairs(game:GetService("Workspace")["Delivery_Points"].Sawmill:GetChildren()) do
      if v.ClassName == "Part" and v:FindFirstChildOfClass("ProximityPrompt") then
  fireproximityprompt(v:FindFirstChildOfClass("ProximityPrompt"))
      end
      end
      until game:GetService("Players").LocalPlayer.PlayerGui.CollectGui.Dialog.Visible == true or not   game:GetService("Workspace"):FindFirstChild(game.Players.LocalPlayer.Name.."'s Trailer") or _G.test == false
   repeat wait()
       local loc =game:GetService("Players").LocalPlayer.PlayerGui.CollectGui.Dialog.Content.Footer.Normal
       mousemoverel(loc.AbsolutePosition.X+10,loc.AbsolutePosition.Y+40,1,true,game,0)
       wait(0.1)
       mouse1click()
                  wait(0.1)
   until not  game:GetService("Workspace"):FindFirstChild(game.Players.LocalPlayer.Name.."'s Trailer") or game:GetService("Players").LocalPlayer.PlayerGui.CollectGui.Dialog.Visible == false  or _G.test == false
    
  elseif game:GetService("Workspace")["Delivery_Points"].Sawmill:FindFirstChild("Sawmill_Detector") and game:GetService("Workspace"):FindFirstChild(game.Players.LocalPlayer.Name.."'s Trailer") then
   local car = game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent
   local car = game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent
   car.PrimaryPart = car.Body["#Weight"]
   car:SetPrimaryPartCFrame(CFrame.new(19233.404296875, 3000, -6995.3759765625))
   game:GetService("Workspace"):FindFirstChild(game.Players.LocalPlayer.Name.."'s Trailer"):SetPrimaryPartCFrame(CFrame.new(19233.404296875, 3020, -6995.3759765625))
   task.wait()
   car.PrimaryPart.Anchored = true
   wait(1)
   car.PrimaryPart.Anchored = false     
   repeat wait(0.1)
   for i,v in pairs(game:GetService("Workspace")["Delivery_Points"].Sawmill:GetChildren()) do
      if v.ClassName == "Part" and v:FindFirstChildOfClass("ProximityPrompt") then
  fireproximityprompt(v:FindFirstChildOfClass("ProximityPrompt"))
      end
      end
 until game:GetService("Players").LocalPlayer.PlayerGui.CollectGui.Dialog.Visible == true or not   game:GetService("Workspace"):FindFirstChild(game.Players.LocalPlayer.Name.."'s Trailer") or _G.test == false
repeat wait()
  local loc =game:GetService("Players").LocalPlayer.PlayerGui.CollectGui.Dialog.Content.Footer.Normal
  mousemoverel(loc.AbsolutePosition.X+10,loc.AbsolutePosition.Y+40,1,true,game,0)
  wait(0.1)
  mouse1click()
             wait(0.1)
until not   game:GetService("Workspace"):FindFirstChild(game.Players.LocalPlayer.Name.."'s Trailer") or game:GetService("Players").LocalPlayer.PlayerGui.CollectGui.Dialog.Visible == false or _G.test == false
  wait(1)
  end
  end)
  end
end)
