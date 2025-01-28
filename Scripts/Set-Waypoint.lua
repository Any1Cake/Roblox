local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WaypointUI"
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

local function createButton(text, position, parent, callback)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0.9, 0, 0.15, 0)
	button.Position = position
	button.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
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

local mainFrame = createFrame("MainFrame", UDim2.new(0, 160, 0, 250), UDim2.new(0.5, -80, 0.5, -125), screenGui)
createLabel("Manage Tab", UDim2.new(1, 0, 0.15, 0), UDim2.new(0, 0, 0, 0), mainFrame)

local historyFrame = createFrame("HistoryFrame", UDim2.new(0, 160, 0, 250), UDim2.new(1.1, 0, 0, 0), mainFrame)
historyFrame.Visible = false
createLabel("History Tab", UDim2.new(1, 0, 0.15, 0), UDim2.new(0, 0, 0, 0), historyFrame)

local waypoints = {}
local historyButtons = {}

-- Create 4 placeholder buttons in the history frame
for i = 1, 4 do
	local button = createButton("Not Set", UDim2.new(0.05, 0, 0.2 * i, 0), historyFrame, function() end)
	table.insert(historyButtons, button)
end

createButton("Set Waypoint", UDim2.new(0.05, 0, 0.2, 0), mainFrame, function()
	local namePromptFrame = createFrame("NamePromptFrame", UDim2.new(0, 160, 0, 100), UDim2.new(0.5, -80, 0.5, -80), screenGui)

	local nameTextBox = Instance.new("TextBox")
	nameTextBox.Size = UDim2.new(0.8, 0, 0.4, 0)
	nameTextBox.Position = UDim2.new(0.1, 0, 0.2, 0)
	nameTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	nameTextBox.Text = "Enter waypoint name"
	nameTextBox.TextScaled = true
	nameTextBox.Parent = namePromptFrame

	createButton("Done", UDim2.new(0.05, 0, 0.7, 0), namePromptFrame, function()
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
				local newButton = createButton(waypoint.name, UDim2.new(0.05, 0, 0.2 * #historyButtons, 0), historyFrame, function()
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(waypoint.position)
					print("Teleported to waypoint: " .. waypoint.name)
				end)
				table.insert(historyButtons, newButton)
			end
		end
		namePromptFrame:Destroy()
	end)
end)

createButton(
	"Goto Waypoint",
	UDim2.new(0.05, 0, 0.4, 0), 
	mainFrame, 
	function()
		if #waypoints > 0 then
			local lastWaypoint = waypoints[#waypoints]
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(lastWaypoint.position)
			print("Teleported to waypoint: " .. lastWaypoint.name)
		else
			print("No waypoint set!")
		end
	end)

createButton(
	"View History", 
	UDim2.new(0.05, 0, 0.6, 0), 
	mainFrame, 
	function()
		historyFrame.Visible = not historyFrame.Visible
	end)

createButton(
	"Clear History", 
	UDim2.new(0.05, 0, 0.8, 0), 
	mainFrame, 
	function()
		waypoints = {}
		for _, button in ipairs(historyButtons) do
			button.Text = "Not Set"
			button.MouseButton1Click:Connect(function() end) -- Clear button functionality
		end
		print("Waypoint history cleared!")
	end)
