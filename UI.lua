-- Luau Executor Menu
-- Load via: loadstring(game:HttpGet("YOUR_GITHUB_RAW_URL"))()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

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
mainFrame.Size = UDim2.new(0, 500, 0, 350)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
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
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y)
end)

-- Button Erstellungs-Funktion
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
    
    -- Hover-Effekt
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 85)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 65)}):Play()
    end)
    
    button.MouseButton1Click:Connect(callback)
    
    return button
end

-- Beispiel-Buttons
createButton("🏃 Speed Boost", function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 50
        print("Speed erhöht auf 50")
    end
end)

createButton("🦘 Jump Power", function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = 100
        print("Jump Power erhöht auf 100")
    end
end)

createButton("💫 Noclip Toggle", function()
    local noclip = not getgenv().noclipEnabled
    getgenv().noclipEnabled = noclip
    
    if noclip then
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
        print("Noclip deaktiviert")
    end
end)

createButton("👁️ ESP (Player Names)", function()
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
    print("ESP aktiviert")
end)

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

-- Schließen-Funktion
closeButton.MouseButton1Click:Connect(function()
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
        TweenService:Create(mainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 500, 0, 350)}):Play()
        minimizeButton.Text = "—"
    end
end)

-- Einblend-Animation
mainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 
    {Size = UDim2.new(0, 500, 0, 350)}
):Play()

print("Executor Menu erfolgreich geladen!")
