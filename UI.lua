-- Advanced Roblox Script with GUI
-- Creator: GLM 4.6
-- Platform: Venice.ai

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Variables
local AimbotEnabled = false
local WallhackEnabled = false
local SpeedEnabled = false
local FlyEnabled = false
local JumpPowerEnabled = false
local AnimationsEnabled = false
local SkinChangerEnabled = false
local AimbotTarget = nil
 flySpeed = 50
 speedValue = 25
 jumpPowerValue = 50
 aimbotFOV = 150
 aimbotSmoothness = 0.2
 aimbotTeamCheck = false
 aimbotVisibleCheck = true

-- Animation IDs
local AnimationList = {
    ["Dance"] = "rbxassetid://507771019",
    ["Laugh"] = "rbxassetid://129423030",
    ["Wave"] = "rbxassetid://507770669",
    ["Cheer"] = "rbxassetid://507770453",
    ["Point"] = "rbxassetid://507770682"
}

-- Config System
local Configs = {}
local ConfigFolder = "AdvancedScriptConfigs"
local ConfigName = "Default"

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AdvancedScriptGUI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -250)
MainFrame.Size = UDim2.new(0, 600, 0, 500)
MainFrame.ClipsDescendants = true

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TopBar.BorderSizePixel = 0
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.Size = UDim2.new(1, 0, 0, 40)

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Advanced Script Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -40, 0, 5)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14

-- Tab Buttons
local TabButtons = {}
local Tabs = {}

local TabFrame = Instance.new("Frame")
TabFrame.Name = "TabFrame"
TabFrame.Parent = MainFrame
TabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TabFrame.BorderSizePixel = 0
TabFrame.Position = UDim2.new(0, 0, 0, 40)
TabFrame.Size = UDim2.new(0, 150, 1, -40)

local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
ContentFrame.BorderSizePixel = 0
ContentFrame.Position = UDim2.new(0, 150, 0, 40)
ContentFrame.Size = UDim2.new(1, -150, 1, -40)

-- Create Tabs
local function CreateTab(name, id)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name .. "Tab"
    TabButton.Parent = TabFrame
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    TabButton.BorderSizePixel = 0
    TabButton.Position = UDim2.new(0, 5, 0, 5 + (#TabButtons * 45))
    TabButton.Size = UDim2.new(1, -10, 0, 40)
    TabButton.Font = Enum.Font.Gotham
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 14
    TabButton.TextXAlignment = Enum.TextXAlignment.Left
    TabButton.AutoButtonColor = false
    
    local Tab = Instance.new("ScrollingFrame")
    Tab.Name = name .. "Content"
    Tab.Parent = ContentFrame
    Tab.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    Tab.BorderSizePixel = 0
    Tab.Position = UDim2.new(0, 0, 0, 0)
    Tab.Size = UDim2.new(1, 0, 1, 0)
    Tab.Visible = false
    Tab.ScrollBarThickness = 5
    Tab.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 70)
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Tab
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)
    
    TabButtons[name] = TabButton
    Tabs[name] = Tab
    
    -- Tab Button Click
    TabButton.MouseButton1Click:Connect(function()
        for _, tab in pairs(Tabs) do
            tab.Visible = false
        end
        for _, btn in pairs(TabButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        end
        Tab.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    end)
    
    return Tab
end

-- Create Toggle Button
local function CreateToggle(parent, name, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Name = name .. "Frame"
    Frame.Parent = parent
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    Frame.BorderSizePixel = 0
    Frame.Size = UDim2.new(1, -10, 0, 40)
    Frame.LayoutOrder = #parent:GetChildren()
    
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Parent = Frame
    Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Font = Enum.Font.Gotham
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local Toggle = Instance.new("TextButton")
    Toggle.Name = "Toggle"
    Toggle.Parent = Frame
    Toggle.BackgroundColor3 = default and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    Toggle.BorderSizePixel = 0
    Toggle.Position = UDim2.new(0.75, 0, 0.25, 0)
    Toggle.Size = UDim2.new(0, 50, 0, 20)
    Toggle.Font = Enum.Font.Gotham
    Toggle.Text = ""
    Toggle.TextSize = 14
    
    local State = default
    
    Toggle.MouseButton1Click:Connect(function()
        State = not State
        Toggle.BackgroundColor3 = State and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
