-- 🌌 Noclip Menü mit Auto-Start, Animation & Tastatur-Shortcut
-- ⚠️ Nur für DEINE eigenen Roblox-Spiele gedacht (nicht zum Exploiten)! ⚠️

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local noclip = false
local animating = true

-- 🪟 GUI-Erstellung
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NoclipMenu"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 180, 0, 80)
frame.Position = UDim2.new(0, 20, 0, 20)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BackgroundTransparency = 1 -- Start transparent
frame.BorderSizePixel = 0
frame.Parent = screenGui

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Parent = frame

-- Abrundung
local corner1 = Instance.new("UICorner", frame)
corner1.CornerRadius = UDim.new(0, 8)

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 0, 28)
label.BackgroundTransparency = 1
label.Text = "🔮 Noclip Menü"
label.TextColor3 = Color3.new(1, 1, 1)
label.Font = Enum.Font.GothamBold
label.TextScaled = true
label.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -20, 0, 32)
button.Position = UDim2.new(0, 10, 0, 40)
button.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.GothamBold
button.TextScaled = true
button.Text = "Noclip: AUS"
button.Parent = frame

local corner2 = Instance.new("UICorner", button)
corner2.CornerRadius = UDim.new(0, 6)

-- ✨ Einblend-Animation beim Start
frame.Position = UDim2.new(0, 20, 0, -100) -- Start außerhalb des Bildschirms
local tween = TweenService:Create(
	frame,
	TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	{Position = UDim2.new(0, 20, 0, 20), BackgroundTransparency = 0.3}
)
tween:Play()
tween.Completed:Connect(function()
	animating = false
end)

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

-- 🚶 Durch Wände laufen
RunService.Stepped:Connect(function()
	if noclip and player.Character then
		for _, part in pairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then
				part.CanCollide = false
			end
		end
	end
end)

-- 💀 Nach Respawn wieder aktivieren
player.CharacterAdded:Connect(function(char)
	if noclip then
		task.wait(1)
		for _, part in pairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)
