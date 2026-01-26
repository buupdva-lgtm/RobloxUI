--====================================================--
--  🌿 WeedHub by Pacey   (Lern-UI für eigene Spiele)
--====================================================--

-- UI-Objekte erstellen
local plr = game.Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
ScreenGui.Name = "WeedHubUI"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Position = UDim2.new(0.5, -150, 0.5, -120)
Frame.Size = UDim2.new(0, 300, 0, 280)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(15,15,15)
Title.Text = "WeedHub by Pacey"
Title.TextColor3 = Color3.fromRGB(0,255,0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20

local function makeButton(text, posY)
	local b = Instance.new("TextButton", Frame)
	b.Size = UDim2.new(0.8,0,0,30)
	b.Position = UDim2.new(0.1,0,posY,0)
	b.BackgroundColor3 = Color3.fromRGB(50,150,50)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.SourceSans
	b.TextSize = 16
	b.Text = text
	b.BorderSizePixel = 0
	return b
end

local btnTeleport = makeButton("Teleport (Demo)", 0.18)
local btnRunSpeed = makeButton("Change WalkSpeed (Demo)", 0.33)
local btnCamera  = makeButton("Toggle Camera Mode", 0.48)
local btnDebug   = makeButton("Show Debug Info", 0.63)
local btnTheme   = makeButton("Toggle Dark/Light", 0.78)

-------------------------------------------------------
-- Funktionen
-------------------------------------------------------
local cam = workspace.CurrentCamera
local dark = true
local flyCam = false

btnTeleport.MouseButton1Click:Connect(function()
	if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
		plr.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(0, 10, 0))
		print("[WeedHub] Spieler testweise verschoben.")
	end
end)

btnRunSpeed.MouseButton1Click:Connect(function()
	local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
	if not hum then return end
	if hum.WalkSpeed == 16 then
		hum.WalkSpeed = 30
		btnRunSpeed.Text = "Restore WalkSpeed"
		print("[WeedHub] Geschwindigkeit erhöht (Demo).")
	else
		hum.WalkSpeed = 16
		btnRunSpeed.Text = "Change WalkSpeed (Demo)"
		print("[WeedHub] Geschwindigkeit normal.")
	end
end)

btnCamera.MouseButton1Click:Connect(function()
	if flyCam then
		cam.CameraType = Enum.CameraType.Custom
		flyCam = false
		btnCamera.Text = "Toggle Camera Mode"
		print("[WeedHub] Kamera wieder normal.")
	else
		cam.CameraType = Enum.CameraType.Scriptable
		cam.CFrame = cam.CFrame * CFrame.new(0,2,0)
		flyCam = true
		btnCamera.Text = "Restore Camera"
		print("[WeedHub] Freie Kamera aktiviert (Demo).")
	end
end)

btnDebug.MouseButton1Click:Connect(function()
	local char = plr.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	print("------ WeedHub Debug ------")
	print("Spieler:", plr.Name)
	print("Position:", char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart.Position)
	print("WalkSpeed:", hum and hum.WalkSpeed)
	print("CameraType:", cam.CameraType)
	print("-----------------------------")
end)

btnTheme.MouseButton1Click:Connect(function()
	if dark then
		dark = false
		Frame.BackgroundColor3 = Color3.fromRGB(220,220,220)
		for _,b in ipairs(Frame:GetChildren()) do
			if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(0,120,0) end
		end
		btnTheme.Text = "Toggle Dark Mode"
	else
		dark = true
		Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
		for _,b in ipairs(Frame:GetChildren()) do
			if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(50,150,50) end
		end
		btnTheme.Text = "Toggle Light Mode"
	end
end)
