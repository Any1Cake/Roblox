-- Get the current Place ID
local currentPlaceId = game.PlaceId

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WaypointUI1"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local function createFrame(name, size, position, parent)
	local frame = Instance.new("Frame")
	frame.Name = name
	frame.Size = size
	frame.Position = position
	frame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
	frame.BorderSizePixel = 0
	frame.Parent = parent
	frame.Active = true
	frame.Draggable = true

	local uiGradient = Instance.new("UIGradient")
	uiGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 220, 220))
	}
	uiGradient.Parent = frame

	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 15)
	uiCorner.Parent = frame

	local uiStroke = Instance.new("UIStroke")
	uiStroke.Thickness = 2
	uiStroke.Color = Color3.fromRGB(180, 180, 180)
	uiStroke.Parent = frame

	return frame
end

local function createLabel(text, size, position, parent)
	local label = Instance.new("TextLabel")
	label.Size = size
	label.Position = position
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(50, 50, 50)
	label.Font = Enum.Font.FredokaOne
	label.TextScaled = true
	label.Parent = parent

	local textSizeConstraint = Instance.new("UITextSizeConstraint")
	textSizeConstraint.MaxTextSize = 24
	textSizeConstraint.MinTextSize = 24
	textSizeConstraint.Parent = label

	label.ZIndex = 2

	return label
end

local function createButton(text, size, position, color, parent, callback)
	local button = Instance.new("TextButton")
	local size1 = size or UDim2.new(0.9, 0, 0.15, 0)  -- Default size
	local color1 = color or Color3.fromRGB(0, 150, 255)  -- Default color
	button.Size = size1
	button.Position = position
	button.BackgroundColor3 = color1
	button.Text = text
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.Gotham
	button.TextScaled = true
	button.Parent = parent

	local textSizeConstraint = Instance.new("UITextSizeConstraint")
	textSizeConstraint.MaxTextSize = 20
	textSizeConstraint.MinTextSize = 10
	textSizeConstraint.Parent = button

	local buttonCorner = Instance.new("UICorner")
	buttonCorner.CornerRadius = UDim.new(0, 12)
	buttonCorner.Parent = button

	button.ZIndex = 1

	button.MouseButton1Click:Connect(callback)
	return button
end

local function earthTab()
	-- Define the target CFrames
	local cframes = {
		CFrame.new(-2602.50781, 339.165161, 1922.82642, -0.638691902, 4.8589226e-09, -0.769462585, 1.0652087e-09, 1, 5.43052048e-09, 0.769462585, 2.64879119e-09, -0.638691902),
		CFrame.new(-2567.93677, 330.28067, 1869.33203, -0.717625916, -6.37488498e-08, 0.696428776, 2.42485743e-09, 1, 9.40354425e-08, -0.696428776, 6.91710085e-08, -0.717625916), -- Replace with your second target CFrame
	}

	-- Get the player
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

	-- Teleport through each CFrame with a delay
	for _, targetCFrame in ipairs(cframes) do
		humanoidRootPart.CFrame = targetCFrame
		task.wait(1) -- Wait 1 second before teleporting to the next CFrame
	end
end
 
local function moonTab()
	local mainFrame = createFrame("MainFrame", UDim2.new(0, 160, 0, 250), UDim2.new(0.5, -80, 0.5, -125), screenGui)
	createLabel("Manage Tab", UDim2.new(1, 0, 0.15, 0), UDim2.new(0, 0, 0, 0), mainFrame)

	local historyFrame = createFrame("HistoryFrame", UDim2.new(0, 160, 0, 250), UDim2.new(1.1, 0, 0, 0), mainFrame)
	historyFrame.Visible = false
	createLabel("History Tab", UDim2.new(1, 0, 0.15, 0), UDim2.new(0, 0, 0, 0), historyFrame)

	local waypoints = {}
	local historyButtons = {}

	-- Create 4 placeholder buttons in the history frame
	for i = 1, 4 do
		local button = createButton("Not Set", nil, UDim2.new(0.05, 0, 0.2 * i, 0), nil, historyFrame, function() end)
		table.insert(historyButtons, button)
	end

	createButton("Set Waypoint", nil, UDim2.new(0.05, 0, 0.2, 0), nil, mainFrame, function()
		local namePromptFrame = createFrame("NamePromptFrame", UDim2.new(0, 160, 0, 100), UDim2.new(0.5, -80, 0.5, -80), screenGui)

		local nameTextBox = Instance.new("TextBox")
		nameTextBox.Size = UDim2.new(0.8, 0, 0.4, 0)
		nameTextBox.Position = UDim2.new(0.1, 0, 0.2, 0)
		nameTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		nameTextBox.Text = "Enter waypoint name"
		nameTextBox.TextScaled = true
		nameTextBox.Parent = namePromptFrame

		createButton("Done", nil, UDim2.new(0.05, 0, 0.7, 0), nil, namePromptFrame, function()
			if nameTextBox.Text ~= "" and nameTextBox.Text ~= "Enter waypoint name" then
				local waypoint = {
					position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position,
					name = nameTextBox.Text
				}
				table.insert(waypoints, waypoint)
				print("Waypoint set: " .. waypoint.name .. " at " .. tostring(waypoint.position))

				-- Update an existing button or create a new one if needed
				local updated = false
				for _, button in ipairs(historyButtons) do
					if button.Text == "Not Set" then
						button.Text = waypoint.name
						button.MouseButton1Click:Connect(function()
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(waypoint.position)
							print("Teleported to waypoint: " .. waypoint.name)
						end)
						updated = true
						break
					end
				end

				if not updated then
					local newButton = createButton(waypoint.name, nil, UDim2.new(0.05, 0, 0.2 * #historyButtons, 0), nil, historyFrame, 
						function()
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(waypoint.position)
						print("Teleported to waypoint: " .. waypoint.name)
					end)
					table.insert(historyButtons, newButton)
				end
			end
			namePromptFrame:Destroy()
		end)
	end)

	createButton("Goto Waypoint", nil, UDim2.new(0.05, 0, 0.4, 0), nil, mainFrame, 
		function()
			if #waypoints > 0 then
				local lastWaypoint = waypoints[#waypoints]
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(lastWaypoint.position)
				print("Teleported to waypoint: " .. lastWaypoint.name)
			else
				print("No waypoint set!")
			end
		end)

	createButton("View History", nil, UDim2.new(0.05, 0, 0.6, 0), nil, mainFrame, 
		function()
			historyFrame.Visible = not historyFrame.Visible
		end)

	createButton("Clear History", nil, UDim2.new(0.05, 0, 0.8, 0), nil, mainFrame, 
		function()
			waypoints = {}
			for _, button in ipairs(historyButtons) do
				button.Text = "Not Set"
				button.MouseButton1Click:Connect(function() end) -- Clear button functionality
			end
			print("Waypoint history cleared!")
		end)
end

local function marsTab()
	
end

local mainFrame = createFrame("MainFrame", UDim2.new(0, 160, 0, 100), UDim2.new(0.5, -80, 0.5, -125), screenGui)
createLabel("Manage Tab", UDim2.new(1, 0, 0.4, 0), UDim2.new(0, 0, 0, 0), mainFrame)

local Button1 = createButton("Start Script", UDim2.new(0.9, 0, 0.38, 0), UDim2.new(0.05, 0, 0.5, 0), nil, mainFrame, 
	function() 
		moonTab()
		mainFrame.Visible = false
		-- Define logic for each Place ID
		if currentPlaceId == 5000143962 then -- Earth
			print("Running script for Place ID", currentPlaceId)
			earthTab()

		elseif currentPlaceId == 5534753974 then -- Moon
			print("Running script for Place ID", currentPlaceId)
			moonTab()

		elseif currentPlaceId == 567890123 then
			-- Logic for Place ID 567890123
			print("Running script for Place ID", currentPlaceId)
			-- Add the code specific to this place here
			-- Example: Display a GUI
			local player = game.Players.LocalPlayer
			local gui = Instance.new("ScreenGui")
			local textLabel = Instance.new("TextLabel")
			textLabel.Size = UDim2.new(0.5, 0, 0.1, 0)
			textLabel.Position = UDim2.new(0.25, 0, 0.45, 0)
			textLabel.Text = "Welcome to Place 567890123!"
			textLabel.Parent = gui
			gui.Parent = player:WaitForChild("PlayerGui")

		else
			-- If the Place ID is not recognized
			warn("No script logic defined for this Place ID:", currentPlaceId)
		end

	end)

