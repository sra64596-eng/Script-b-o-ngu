-- [[ TUẤT KỲ TELEPORT HUB UI ]]
-- Creator: Tuất Kỳ

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Check & Destroy Old UI
if CoreGui:FindFirstChild("TuatKyHub") then
    CoreGui.TuatKyHub:Destroy()
end

-- Create ScreenGui
local TuatKyHub = Instance.new("ScreenGui")
TuatKyHub.Name = "TuatKyHub"
TuatKyHub.Parent = CoreGui
TuatKyHub.ResetOnSpawn = false

-- State Variables
local savedCFrame = nil
local autoSaveEnabled = false

-- [[ MAIN TOGGLE BUTTON ]]
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = TuatKyHub
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0.4, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(18, 21, 30)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Text = "🐕"
ToggleBtn.TextSize = 22
ToggleBtn.Draggable = true

local ToggleCorner = Instance.new("UICorner", ToggleBtn)
ToggleCorner.CornerRadius = UDim.new(0, 12)

local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Color = Color3.fromRGB(34, 197, 94)
ToggleStroke.Thickness = 1.5

-- [[ MAIN FRAME ]]
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = TuatKyHub
MainFrame.Size = UDim2.new(0, 320, 0, 360)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 21, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 16)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(34, 197, 94)
MainStroke.Transparency = 0.5

-- Title Header
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -40, 0, 40)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "TUẤT KỲ HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.TextSize = 14

-- Info Label
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Parent = MainFrame
InfoLabel.Size = UDim2.new(1, -30, 0, 40)
InfoLabel.Position = UDim2.new(0, 15, 0, 45)
InfoLabel.BackgroundColor3 = Color3.fromRGB(9, 10, 15)
InfoLabel.TextColor3 = Color3.fromRGB(150, 200, 150)
InfoLabel.Text = "Tọa độ: Chưa lưu"
InfoLabel.TextSize = 12
InfoLabel.Font = Enum.Font.Code
local InfoCorner = Instance.new("UICorner", InfoLabel)
InfoCorner.CornerRadius = UDim.new(0, 8)

-- Function: Save Location
local SaveBtn = Instance.new("TextButton")
SaveBtn.Parent = MainFrame
SaveBtn.Size = UDim2.new(1, -30, 0, 38)
SaveBtn.Position = UDim2.new(0, 15, 0, 95)
SaveBtn.BackgroundColor3 = Color3.fromRGB(27, 32, 46)
SaveBtn.Text = "💾 Lưu Vị Trí Hiện Tại"
SaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveBtn.Font = Enum.Font.GothamSemibold
SaveBtn.TextSize = 12
Instance.new("UICorner", SaveBtn).CornerRadius = UDim.new(0, 10)

SaveBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        savedCFrame = char.HumanoidRootPart.CFrame
        local pos = savedCFrame.Position
        InfoLabel.Text = string.format("X: %.1f | Y: %.1f | Z: %.1f", pos.X, pos.Y, pos.Z)
    end
end)

-- Function: Teleport Back
local TeleBackBtn = Instance.new("TextButton")
TeleBackBtn.Parent = MainFrame
TeleBackBtn.Size = UDim2.new(1, -30, 0, 42)
TeleBackBtn.Position = UDim2.new(0, 15, 0, 140)
TeleBackBtn.BackgroundColor3 = Color3.fromRGB(22, 197, 94)
TeleBackBtn.Text = "⚡ Teleport Về Chỗ Cũ"
TeleBackBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleBackBtn.Font = Enum.Font.GothamBold
TeleBackBtn.TextSize = 13
Instance.new("UICorner", TeleBackBtn).CornerRadius = UDim.new(0, 10)

TeleBackBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        if savedCFrame then
            char.HumanoidRootPart.CFrame = savedCFrame
        end
    end
end)

-- Toggle Menu Visibility Animation
local menuVisible = true
local function toggleUI()
    menuVisible = not menuVisible
    MainFrame.Visible = menuVisible
end

ToggleBtn.MouseButton1Click:Connect(toggleUI)
CloseBtn.MouseButton1Click:Connect(toggleUI)

print("Tuất Kỳ Hub Loaded Successfully!")
