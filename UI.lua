-- 🔧 Roblox Noclip Menü mit Design & Shortcut
-- Wichtig: Nur in deinem eigenen Spiel zum Testen oder Debuggen verwenden!

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local noclip = false

-- 🎨 GUI-Erstellung
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NoclipMenu"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 160, 0, 70)
frame.Position = UDim2.new(0, 20, 0, 20)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BackgroundTransparency = 0.3
frame.BorderSizePixel = 0
frame.Parent = screenGui

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Parent = frame

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 0, 25)
label.BackgroundTransparency = 1
label.Text = "🔮 Noclip Menü"
label.TextColor3 = Color3.new(1, 1, 1)
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -20, 0, 30)
button.Position = UDim2.new(0, 10, 0, 35)
button.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.GothamBold
button.TextScaled = true
button.Text = "Noclip: AUS"
button.Parent = frame

local corner1 = Instance.new("UICorner", frame)
corner1.CornerRadius = UDim.new(0, 8)

local corner2 = Instance.new("UICorner", button)
corner2.CornerRadius = UDim.new(0, 6)

-- ⚙️ Funktionen
local function setNoclip(state)
	noclip = state
	if noclip then
		button.Text = "Noclip: AN"
		button.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
	else
		button.Text = "Noclip: AUS"
		button.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
	end
end

local function toggleNoclip()
	setNoclip(not noclip)
end

button.MouseButton1Click:Connect(toggleNoclip)

UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.N then
		toggleNoclip()
	end
end)

-- 🧱 Physikfunktion, damit du durch Wände gehst
RunService.Stepped:Connect(function()
	if noclip and player.Character then
		for _, part in pairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then
				part.CanCollide = false
			end
		end
	end
end)

-- Rücksetzen, wenn man respawnt
player.CharacterAdded:Connect(function(char)
	character = char
	if noclip then
		task.wait(1)
		for _, part in pairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)
