-- Part 1: Basic Structure and GUI
-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local Camera = Workspace.CurrentCamera

-- Player
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Variables
local flying = false
local speedEnabled = false
local jumpEnabled = false
local aimbotEnabled = false
local espEnabled = false
local noClipEnabled = false
local infiniteJumpEnabled = false

-- Simple GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ExploitGUI"
screenGui.Parent = CoreGui
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.2)
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Active = true
mainFrame.Draggable = true

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Parent = mainFrame
titleBar.BackgroundColor3 = Color3.new(0.15, 0.15, 0.25)
titleBar.BorderSizePixel = 0
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.Size = UDim2.new(1, 0, 0, 40)

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Parent = titleBar
title.BackgroundColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 10, 0, 0)
title.Size = UDim2.new(0, 200, 1, 0)
title.Font = Enum.Font.SourceSansBold
title.Text = "Velocity Exploit"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 18

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Parent = titleBar
closeButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
closeButton.BorderSizePixel = 0
closeButton.Position = UDim2.new(1, -40, 0, 5)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.TextSize = 16

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Parent = mainFrame
contentFrame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.15)
contentFrame.BorderSizePixel = 0
contentFrame.Position = UDim2.new(0, 0, 0, 40)
contentFrame.Size = UDim2.new(1, 0, 1, -40)

print("Part 1 loaded: GUI structure created")
-- Part 2: Helper Functions
-- Create Toggle Function
local function createToggle(name, y, callback)
    local frame = Instance.new("Frame")
    frame.Name = name .. "Frame"
    frame.Parent = contentFrame
    frame.BackgroundColor3 = Color3.new(0.12, 0.12, 0.2)
    frame.BorderSizePixel = 0
    frame.Position = UDim2.new(0, 10, 0, y)
    frame.Size = UDim2.new(1, -20, 0, 30)
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Parent = frame
    label.BackgroundColor3 = Color3.new(1, 1, 1)
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Font = Enum.Font.SourceSans
    label.Text = name
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggle = Instance.new("TextButton")
    toggle.Name = "Toggle"
    toggle.Parent = frame
    toggle.BackgroundColor3 = Color3.new(0.7, 0.2, 0.2)
    toggle.BorderSizePixel = 0
    toggle.Position = UDim2.new(0.8, 0, 0.25, 0)
    toggle.Size = UDim2.new(0, 50, 0, 20)
    toggle.Font = Enum.Font.SourceSans
    toggle.Text = ""
    toggle.TextSize = 14
    
    local state = false
    
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.BackgroundColor3 = state and Color3.new(0.2, 0.7, 0.2) or Color3.new(0.7, 0.2, 0.2)
        callback(state)
    end)
    
    return toggle
end

-- Create Button Function
local function createButton(name, y, callback)
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Parent = contentFrame
    button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.3)
    button.BorderSizePixel = 0
    button.Position = UDim2.new(0, 10, 0, y)
    button.Size = UDim2.new(1, -20, 0, 30)
    button.Font = Enum.Font.SourceSans
    button.Text = name
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 14
    
    button.MouseButton1Click:Connect(callback)
    
    return button
end

print("Part 2 loaded: Helper functions created")
-- Part 3: Fly Function
-- Fly Function
local function fly(enabled)
    flying = enabled
    
    if enabled then
        local flyPart = Instance.new("Part")
        flyPart.Name = "FlyPart"
        flyPart.Parent = character
        flyPart.Anchored = true
        flyPart.CanCollide = false
        flyPart.Size = Vector3.new(5, 1, 5)
        flyPart.Transparency = 1
        
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(10000, 10000, 10000)
        bv.Parent = character.HumanoidRootPart
        bv.Name = "FlyBV"
        
        local bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(10000, 10000, 10000)
        bg.Parent = character.HumanoidRootPart
        bg.Name = "FlyBG"
        
        local flyConnection
        flyConnection = RunService.Heartbeat:Connect(function()
            if flying then
                local cam = Workspace.CurrentCamera
                bg.CFrame = cam.CFrame
                
                local moveVector = Vector3.new(0, 0, 0)
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveVector = moveVector + cam.CFrame.lookVector * 50
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveVector = moveVector - cam.CFrame.lookVector * 50
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveVector = moveVector - cam.CFrame.rightVector * 50
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveVector = moveVector + cam.CFrame.rightVector * 50
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveVector = moveVector + Vector3.new(0, 50, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    moveVector = moveVector + Vector3.new(0, -50, 0)
                end
                
                bv.Velocity = moveVector
            end
        end)
        
        -- Store connection for cleanup
        flyPart:SetAttribute("FlyConnection", flyConnection)
    else
        -- Stop flying
        local flyPart = character:FindFirstChild("FlyPart")
        if flyPart then
            local connection = flyPart:GetAttribute("FlyConnection")
            if connection then
                connection:Disconnect()
            end
            flyPart:Destroy()
        end
        
        local bv = character.HumanoidRootPart:
        -- Part 4: Aimbot Function
-- Aimbot Function
local function aimbot(enabled)
    aimbotEnabled = enabled
    
    local aimbotConnection
    aimbotConnection = RunService.Heartbeat:Connect(function()
        if aimbotEnabled then
            local closestPlayer = nil
            local closestDistance = math.huge
            
            for _, targetPlayer in ipairs(Players:GetPlayers()) do
                if targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local targetPart = targetPlayer.Character.HumanoidRootPart
                    local distance = (targetPart.Position - character.HumanoidRootPart.Position).Magnitude
                    
                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = targetPlayer
                    end
                end
            end
            
            if closestPlayer and closestPlayer.Character:FindFirstChild("Head") then
                local targetPos = closestPlayer.Character.Head.Position
                local lookAt = CFrame.new(Camera.CFrame.Position, targetPos)
                Camera.CFrame = Camera.CFrame:Lerp(lookAt, 0.1)
            end
        end
    end)
    
    -- Store connection for cleanup
    if character:FindFirstChild("AimbotConnection") then
        character.AimbotConnection:Disconnect()
    end
    
    local aimbotValue = Instance.new("ObjectValue")
    aimbotValue.Name = "AimbotConnection"
    aimbotValue.Parent = character
    aimbotValue.Value = aimbotConnection
end

print("Part 4 loaded: Aimbot function created")
        -- Part 5: ESP/Wallhack Function
-- ESP Function
local function esp(enabled)
    espEnabled = enabled
    
    -- Remove existing ESP
    for _, obj in ipairs(Workspace:GetChildren()) do
        if obj:IsA("Highlight") and obj.Name == "ESP" then
            obj:Destroy()
        end
    end
    
    if enabled then
        -- Create ESP for all players
        for _, targetPlayer in ipairs(Players:GetPlayers()) do
            if targetPlayer ~= player and targetPlayer.Character then
                local highlight = Instance.new("Highlight")
                highlight.Name = "ESP"
                highlight.Parent = targetPlayer.Character
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
                highlight.FillColor = targetPlayer.Team and targetPlayer.Team.TeamColor.Color or Color3.new(1, 0, 0)
            end
        end
        
        -- Create ESP for new players
        Players.PlayerAdded:Connect(function(newPlayer)
            if espEnabled and newPlayer ~= player then
                newPlayer.CharacterAdded:Connect(function(char)
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESP"
                    highlight.Parent = char
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.FillColor = newPlayer.Team and newPlayer.Team.TeamColor.Color or Color3.new(1, 0, 0)
                end)
            end
        end)
    end
end

print("Part 5 loaded: ESP function created")
        -- Part 6: NoClip Function
-- NoClip Function
local function noClip(enabled)
    noClipEnabled = enabled
    
    if enabled then
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
        
        -- Handle new parts
        character.ChildAdded:Connect(function(child)
            if noClipEnabled and child:IsA("BasePart") then
                child.CanCollide = false
            end
        end)
    else
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

print("Part 6 loaded: NoClip function created")
        -- Part 7: UI Controls and Final Setup
-- Create Toggles and Buttons
createToggle("Fly", 10, function(state)
    fly(state)
end)

createToggle("Speed", 50, function(state)
    speedEnabled = state
    if state then
        humanoid.WalkSpeed = 30
    else
        humanoid.WalkSpeed = 16
    end
end)

createToggle("High Jump", 90, function(state)
    jumpEnabled = state
    if state then
        humanoid.JumpPower = 50
    else
        humanoid.JumpPower = 15
    end
end)

createToggle("Aimbot", 130, function(state)
    aimbot(state)
end)

createToggle("ESP/Wallhack", 170, function(state)
    esp(state)
end)

createToggle("NoClip", 210, function(state)
    noClip(state)
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if infiniteJumpEnabled then
        humanoid.Jump = true
    end
end)

createToggle("Infinite Jump", 250, function(state)
    infiniteJumpEnabled = state
end)

-- Character respawn handling
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    
    -- Reapply settings if needed
    if speedEnabled then
        humanoid.WalkSpeed = 30
    end
    if jumpEnabled then
        humanoid.JumpPower = 50
    end
    if noClipEnabled then
        noClip(true)
    end
end)

print("Part 7 loaded: UI controls and final setup complete")
print("Full script loaded successfully!")
