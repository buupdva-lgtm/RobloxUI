--====================================================--
--  🚀 Roblox Custom UI Script von DIR für Testzwecke
--  UI: Teleport, Speed, Fly
--  Autor: DeinNameHier
--====================================================--

-- UI erstellen
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local TeleportButton = Instance.new("TextButton")
local SpeedButton = Instance.new("TextButton")
local FlyButton = Instance.new("TextButton")

-- GUI Setup
ScreenGui.Name = "CustomUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

-- Hauptfenster
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

-- Titel
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "Custom UI - Testmenu"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

-- Schließen-Button
CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 16

-- Teleport-Button
TeleportButton.Name = "TeleportButton"
TeleportButton.Parent = MainFrame
TeleportButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
TeleportButton.Position = UDim2.new(0.1, 0, 0.25, 0)
TeleportButton.Size = UDim2.new(0.8, 0, 0, 30)
TeleportButton.Text = "Teleport to Spawn"
TeleportButton.TextColor3 = Color3.new(1,1,1)
TeleportButton.Font = Enum.Font.SourceSans
TeleportButton.TextSize = 16

-- Speed-Button
SpeedButton.Name = "SpeedButton"
SpeedButton.Parent = MainFrame
SpeedButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
SpeedButton.Position = UDim2.new(0.1, 0, 0.45, 0)
SpeedButton.Size = UDim2.new(0.8, 0, 0, 30)
SpeedButton.Text = "Speed Hack"
SpeedButton.TextColor3 = Color3.new(1,1,1)
SpeedButton.Font = Enum.Font.SourceSans
SpeedButton.TextSize = 16

-- Fly-Button
FlyButton.Name = "FlyButton"
FlyButton.Parent = MainFrame
FlyButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
FlyButton.Position = UDim2.new(0.1, 0, 0.65, 0)
FlyButton.Size = UDim2.new(0.8, 0, 0, 30)
FlyButton.Text = "Fly Toggle"
FlyButton.TextColor3 = Color3.new(1,1,1)
FlyButton.Font = Enum.Font.SourceSans
FlyButton.TextSize = 16

--====================================================--
-- 🧠 Funktionen
--====================================================--

local player = game.Players.LocalPlayer
local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
local isFlying = false
local bodyVelocity, bodyGyro = nil, nil

-- Schließen
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Teleport
TeleportButton.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 60, 0)
    end
end)

-- Speed
SpeedButton.MouseButton1Click:Connect(function()
    local hum = player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        if hum.WalkSpeed == 16 then
            hum.WalkSpeed = 50
            SpeedButton.Text = "Normal Speed"
            SpeedButton.BackgroundColor3 = Color3.fromRGB(255, 162, 0)
        else
            hum.WalkSpeed = 16
            SpeedButton.Text = "Speed Hack"
            SpeedButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
        end
    end
end)

-- Fly
FlyButton.MouseButton1Click:Connect(function()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    if not isFlying then
        isFlying = true
        FlyButton.Text = "Disable Fly"
        FlyButton.BackgroundColor3 = Color3.fromRGB(255, 162, 0)

        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Velocity = Vector3.new(0,0,0)
        bodyVelocity.Parent = root

        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
        bodyGyro.CFrame = workspace.CurrentCamera.CFrame
        bodyGyro.Parent = root

        task.spawn(function()
            while isFlying and bodyVelocity and bodyGyro do
                task.wait()
                local moveDir = Vector3.zero
                local uis = game:GetService("UserInputService")

                if uis:IsKeyDown(Enum.KeyCode.W) then moveDir += workspace.CurrentCamera.CFrame.LookVector end
                if uis:IsKeyDown(Enum.KeyCode.S) then moveDir -= workspace.CurrentCamera.CFrame.LookVector end
                if uis:IsKeyDown(Enum.KeyCode.A) then moveDir -= workspace.CurrentCamera.CFrame.RightVector end
                if uis:IsKeyDown(Enum.KeyCode.D) then moveDir += workspace.CurrentCamera.CFrame.RightVector end
                if uis:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0,1,0) end
                if uis:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir -= Vector3.new(0,1,0) end

                bodyVelocity.Velocity = moveDir * 50
                bodyGyro.CFrame = workspace.CurrentCamera.CFrame
            end

            if bodyVelocity then bodyVelocity:Destroy() end
            if bodyGyro then bodyGyro:Destroy() end
            bodyVelocity, bodyGyro = nil, nil
        end)

    else
        isFlying = false
        FlyButton.Text = "Fly Toggle"
        FlyButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    end
end)
