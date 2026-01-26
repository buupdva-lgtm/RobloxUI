-- Luau Executor Menu v2
-- Load via: loadstring(game:HttpGet("YOUR_GITHUB_RAW_URL"))()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Global Settings
getgenv().MenuSettings = getgenv().MenuSettings or {
    speedBoostEnabled = false,
    noclipEnabled = false,
    espEnabled = false,
    speedBoostKey = Enum.KeyCode.Q,
    originalWalkSpeed = 16,
    originalJumpPower = 50
}

-- Entferne alte Instanzen falls vorhanden
if playerGui:FindFirstChild("ExecutorMenu") then
    playerGui:FindFirstChild("ExecutorMenu"):Destroy()
end

-- Hauptcontainer erstellen
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ExecutorMenu"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Hauptframe
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 400)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Abgerundete Ecken
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Schatten-Effekt
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 30, 1, 30)
shadow.Position = UDim2.new(0, -15, 0, -15)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxasset://textures/ui/Shadow.png"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.ZIndex = 0
shadow.Parent = mainFrame

-- Titelleiste
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBar

-- Untere Ecken abflachen
local titleCover = Instance.new("Frame")
titleCover.Size = UDim2.new(1, 0, 0, 10)
titleCover.Position = UDim2.new(0, 0, 1, -10)
titleCover.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
titleCover.BorderSizePixel = 0
titleCover.Parent = titleBar

-- Titel Text
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -100, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🎮 Executor Menu"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Schließen Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 16
closeButton.Font = Enum.Font.GothamBold
closeButton.BorderSizePixel = 0
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 5)
closeCorner.Parent = closeButton

-- Minimize Button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -70, 0, 5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
minimizeButton.Text = "—"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextSize = 16
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.BorderSizePixel = 0
minimizeButton.Parent = titleBar

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 5)
minimizeCorner.Parent = minimizeButton

-- Content Container
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -20, 1, -60)
contentFrame.Position = UDim2.new(0, 10, 0, 50)
contentFrame.BackgroundTransparency = 1
contentFrame.BorderSizePixel = 0
contentFrame.ScrollBarThickness = 6
contentFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 120)
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
contentFrame.Parent = mainFrame

local contentLayout = Instance.new("UIListLayout")
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Padding = UDim.new(0, 10)
contentLayout.Parent = contentFrame

-- Automatische Canvas-Größe anpassen
contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 10)
end)

-- Toggle Button Erstellungs-Funktion
local function createToggleButton(name, emoji, defaultState, callback)
    local container = Instance.new("Frame")
    container.Name = name .. "Container"
    container.Size = UDim2.new(1, 0, 0, 40)
    container.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    container.BorderSizePixel = 0
    container.Parent = contentFrame
    
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 8)
    containerCorner.Parent = container
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = emoji .. " " .. name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(0, 50, 0, 26)
    toggleButton.Position = UDim2.new(1, -60, 0.5, -13)
    toggleButton.BackgroundColor3 = defaultState and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(150, 50, 50)
    toggleButton.Text = defaultState and "ON" or "OFF"
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.TextSize = 12
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.BorderSizePixel = 0
    toggleButton.Parent = container
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggleButton
    
    -- Hover-Effekt
    container.MouseEnter:Connect(function()
        TweenService:Create(container, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 85)}):Play()
    end)
    
    container.MouseLeave:Connect(function()
        TweenService:Create(container, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 65)}):Play()
    end)
    
    toggleButton.MouseButton1Click:Connect(function()
        local newState = callback()
        toggleButton.Text = newState and "ON" or "OFF"
        TweenService:Create(toggleButton, TweenInfo.new(0.2), {
            BackgroundColor3 = newState and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(150, 50, 50)
        }):Play()
    end)
    
    return container, toggleButton
end

-- Keybind Button Erstellungs-Funktion
local function createKeybindButton(name, emoji, defaultKey, callback)
    local container = Instance.new("Frame")
    container.Name = name .. "Container"
    container.Size = UDim2.new(1, 0, 0, 40)
    container.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    container.BorderSizePixel = 0
    container.Parent = contentFrame
    
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 8)
    containerCorner.Parent = container
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -100, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = emoji .. " " .. name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container
    
    local keybindButton = Instance.new("TextButton")
    keybindButton.Name = "KeybindButton"
    keybindButton.Size = UDim2.new(0, 80, 0, 26)
    keybindButton.Position = UDim2.new(1, -90, 0.5, -13)
    keybindButton.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
    keybindButton.Text = defaultKey.Name
    keybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    keybindButton.TextSize = 12
    keybindButton.Font = Enum.Font.GothamBold
    keybindButton.BorderSizePixel = 0
    keybindButton.Parent = container
    
    local keybindCorner = Instance.new("UICorner")
    keybindCorner.CornerRadius = UDim.new(0, 6)
    keybindCorner.Parent = keybindButton
    
    -- Hover-Effekt
    container.MouseEnter:Connect(function()
        TweenService:Create(container, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 85)}):Play()
    end)
    
    container.MouseLeave:Connect(function()
        TweenService:Create(container, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 65)}):Play()
    end)
    
    local waitingForKey = false
    keybindButton.MouseButton1Click:Connect(function()
        if waitingForKey then return end
        waitingForKey = true
        keybindButton.Text = "..."
        keybindButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
        
        local connection
        connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                waitingForKey = false
                local newKey = input.KeyCode
                keybindButton.Text = newKey.Name
                keybindButton.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
                callback(newKey)
                connection:Disconnect()
            end
        end)
    end)
    
    return container, keybindButton
end

-- Standard Button (nicht toggle)
local function createButton(name, callback)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, 0, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    button.Font = Enum.Font.Gotham
    button.BorderSizePixel = 0
    button.Parent = contentFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 85)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 65)}):Play()
    end)
    
    button.MouseButton1Click:Connect(callback)
    
    return button
end

-- ===== FEATURES =====

-- Speed Boost Funktion
local function toggleSpeedBoost()
    getgenv().MenuSettings.speedBoostEnabled = not getgenv().MenuSettings.speedBoostEnabled
    
    if getgenv().MenuSettings.speedBoostEnabled then
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            getgenv().MenuSettings.originalWalkSpeed = player.Character.Humanoid.WalkSpeed
            player.Character.Humanoid.WalkSpeed = 50
        end
        
        -- Connection für neue Characters
        if getgenv().speedBoostConnection then
            getgenv().speedBoostConnection:Disconnect()
        end
        
        getgenv().speedBoostConnection = player.CharacterAdded:Connect(function(char)
            wait(0.1)
            if getgenv().MenuSettings.speedBoostEnabled and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = 50
            end
        end)
        
        print("Speed Boost aktiviert (Speed: 50)")
    else
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = getgenv().MenuSettings.originalWalkSpeed
        end
        
        if getgenv().speedBoostConnection then
            getgenv().speedBoostConnection:Disconnect()
        end
        
        print("Speed Boost deaktiviert")
    end
    
    return getgenv().MenuSettings.speedBoostEnabled
end

-- Speed Boost Toggle
createToggleButton("Speed Boost", "🏃", getgenv().MenuSettings.speedBoostEnabled, toggleSpeedBoost)

-- Speed Boost Keybind
createKeybindButton("Speed Boost Keybind", "⌨️", getgenv().MenuSettings.speedBoostKey, function(newKey)
    getgenv().MenuSettings.speedBoostKey = newKey
    print("Speed Boost Keybind geändert zu: " .. newKey.Name)
end)

-- Jump Power Toggle
createToggleButton("Jump Power", "🦘", false, function()
    local enabled = not (player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.JumpPower > 50)
    
    if enabled then
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            getgenv().MenuSettings.originalJumpPower = player.Character.Humanoid.JumpPower
            player.Character.Humanoid.JumpPower = 100
        end
        print("Jump Power aktiviert (Power: 100)")
    else
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = getgenv().MenuSettings.originalJumpPower
        end
        print("Jump Power deaktiviert")
    end
    
    return enabled
end)

-- Noclip Toggle
createToggleButton("Noclip", "💫", getgenv().MenuSettings.noclipEnabled, function()
    getgenv().MenuSettings.noclipEnabled = not getgenv().MenuSettings.noclipEnabled
    
    if getgenv().MenuSettings.noclipEnabled then
        getgenv().noclipConnection = game:GetService("RunService").Stepped:Connect(function()
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
        print("Noclip aktiviert")
    else
        if getgenv().noclipConnection then
            getgenv().noclipConnection:Disconnect()
        end
        if player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        print("Noclip deaktiviert")
    end
    
    return getgenv().MenuSettings.noclipEnabled
end)

-- ESP Toggle
createToggleButton("ESP (Player Names)", "👁️", getgenv().MenuSettings.espEnabled, function()
    getgenv().MenuSettings.espEnabled = not getgenv().MenuSettings.espEnabled
    
    if getgenv().MenuSettings.espEnabled then
        -- ESP für existierende Spieler
        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("Head") then
                local head = otherPlayer.Character.Head
                if not head:FindFirstChild("PlayerESP") then
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "PlayerESP"
                    billboard.Adornee = head
                    billboard.Size = UDim2.new(0, 100, 0, 40)
                    billboard.StudsOffset = Vector3.new(0, 2, 0)
                    billboard.AlwaysOnTop = true
                    billboard.Parent = head
                    
                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = otherPlayer.Name
                    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    nameLabel.TextStrokeTransparency = 0.5
                    nameLabel.TextSize = 14
                    nameLabel.Font = Enum.Font.GothamBold
                    nameLabel.Parent = billboard
                end
            end
        end
        
        -- ESP für neue Spieler
        getgenv().espConnection = Players.PlayerAdded:Connect(function(newPlayer)
            newPlayer.CharacterAdded:Connect(function(char)
                wait(0.5)
                if getgenv().MenuSettings.espEnabled and char:FindFirstChild("Head") then
                    local head = char.Head
                    if not head:FindFirstChild("PlayerESP") then
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "PlayerESP"
                        billboard.Adornee = head
                        billboard.Size = UDim2.new(0, 100, 0, 40)
                        billboard.StudsOffset = Vector3.new(0, 2, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = head
                        
                        local nameLabel = Instance.new("TextLabel")
                        nameLabel.Size = UDim2.new(1, 0, 1, 0)
                        nameLabel.BackgroundTransparency = 1
                        nameLabel.Text = newPlayer.Name
                        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        nameLabel.TextStrokeTransparency = 0.5
                        nameLabel.TextSize = 14
                        nameLabel.Font = Enum.Font.GothamBold
                        nameLabel.Parent = billboard
                    end
                end
            end)
        end)
        
        print("ESP aktiviert")
    else
        -- ESP entfernen
        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer.Character and otherPlayer.Character:FindFirstChild("Head") then
                local esp = otherPlayer.Character.Head:FindFirstChild("PlayerESP")
                if esp then
                    esp:Destroy()
                end
            end
        end
        
        if getgenv().espConnection then
            getgenv().espConnection:Disconnect()
        end
        
        print("ESP deaktiviert")
    end
    
    return getgenv().MenuSettings.espEnabled
end)

-- Standard Buttons
createButton("🔄 Reset Character", function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Health = 0
    end
end)

createButton("📍 Teleport to Spawn", function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 5, 0)
    end
end)

-- Keybind Listener für Speed Boost
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == getgenv().MenuSettings.speedBoostKey then
        toggleSpeedBoost()
    end
end)

-- Drag-Funktion für das Fenster
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Schließen-Funktion mit Cleanup
closeButton.MouseButton1Click:Connect(function()
    -- Alle Features deaktivieren
    if getgenv().MenuSettings.speedBoostEnabled then
        toggleSpeedBoost()
    end
    
    if getgenv().MenuSettings.noclipEnabled and getgenv().noclipConnection then
        getgenv().noclipConnection:Disconnect()
    end
    
    if getgenv().MenuSettings.espEnabled then
        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer.Character and otherPlayer.Character:FindFirstChild("Head") then
                local esp = otherPlayer.Character.Head:FindFirstChild("PlayerESP")
                if esp then esp:Destroy() end
            end
        end
        if getgenv().espConnection then
            getgenv().espConnection:Disconnect()
        end
    end
    
    screenGui:Destroy()
end)

-- Minimize-Funktion
local minimized = false
minimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(mainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 500, 0, 40)}):Play()
        minimizeButton.Text = "+"
    else
        TweenService:Create(mainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 500, 0, 400)}):Play()
        minimizeButton.Text = "—"
    end
end)

-- Einblend-Animation
mainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 
    {Size = UDim2.new(0, 500, 0, 400)}
):Play()

print("Executor Menu v2 erfolgreich geladen!")
print("Speed Boost Keybind: " .. getgenv().MenuSettings.speedBoostKey.Name)
