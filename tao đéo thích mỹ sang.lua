-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- TÊN MENU
local MENU_NAME = "NEXUS BLUE HUB"

-- Bảng Màu Theme Xanh Dương
local NAVY_BG = Color3.fromRGB(10, 15, 25)
local CARD_BG = Color3.fromRGB(20, 30, 45)
local PRIMARY_BLUE = Color3.fromRGB(0, 140, 255)
local BRIGHT_BLUE = Color3.fromRGB(0, 200, 255)
local DARK_BLUE = Color3.fromRGB(0, 70, 150)

-- 1. TẠO SCREEN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NexusBlueMenuGui"
ScreenGui.Parent = CoreGui or LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- 2. KHUNG MENU CHÍNH
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = NAVY_BG
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true -- Mở sẵn menu khi chạy script

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = PRIMARY_BLUE
MainStroke.Thickness = 2.5
MainStroke.Parent = MainFrame

-- Thanh Tiêu Đề Menu Chính
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundColor3 = PRIMARY_BLUE
Title.Size = UDim2.new(1, 0, 0, 36)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "   " .. MENU_NAME
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- Nút Đóng X
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Title
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.Size = UDim2.new(0, 35, 1, 0)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16

-- 3. NÚT TOGGLE MENU HÌNH TRÒN
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "CircleToggleBtn"
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = NAVY_BG
ToggleBtn.Position = UDim2.new(0.02, 0, 0.15, 0)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Text = "NEXUS"
ToggleBtn.TextColor3 = BRIGHT_BLUE
ToggleBtn.TextSize = 11
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Visible = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = PRIMARY_BLUE
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

-- Hàm ẩn/hiện menu chính
local function toggleUI()
    MainFrame.Visible = not MainFrame.Visible
end

CloseBtn.MouseButton1Click:Connect(toggleUI)
ToggleBtn.MouseButton1Click:Connect(toggleUI)

-- 4. HIỂN THỊ FPS
local FpsCard = Instance.new("Frame")
FpsCard.Parent = MainFrame
FpsCard.Position = UDim2.new(0.05, 0, 0.18, 0)
FpsCard.Size = UDim2.new(0.9, 0, 0, 32)
FpsCard.BackgroundColor3 = CARD_BG

local FpsCorner = Instance.new("UICorner")
FpsCorner.CornerRadius = UDim.new(0, 8)
FpsCorner.Parent = FpsCard

local FpsStroke = Instance.new("UIStroke")
FpsStroke.Color = DARK_BLUE
FpsStroke.Thickness = 1
FpsStroke.Parent = FpsCard

local FpsLabel = Instance.new("TextLabel")
FpsLabel.Parent = FpsCard
FpsLabel.Size = UDim2.new(1, 0, 1, 0)
FpsLabel.BackgroundTransparency = 1
FpsLabel.TextColor3 = BRIGHT_BLUE
FpsLabel.Font = Enum.Font.SourceSansBold
FpsLabel.TextSize = 14
FpsLabel.Text = "FPS: --"

RunService.RenderStepped:Connect(function(step)
    FpsLabel.Text = "FPS: " .. tostring(math.floor(1 / step))
end)

-- 5. VÒNG TRÒN FOV
local FovCircle = Drawing.new("Circle")
FovCircle.Color = BRIGHT_BLUE
FovCircle.Thickness = 1.5
FovCircle.NumSides = 60
FovCircle.Filled = false
FovCircle.Transparency = 0.8
FovCircle.Radius = 120
FovCircle.Visible = false

local function isEnemy(player)
    if player == LocalPlayer then return false end
    if LocalPlayer.Team ~= nil and player.Team ~= nil then
        return player.Team ~= LocalPlayer.Team
    end
    return true
end

-- 6. CHỨC NĂNG GĂM TÂM & FOV
local aimGlowEnabled = false

local AimFovBtn = Instance.new("TextButton")
AimFovBtn.Parent = MainFrame
AimFovBtn.Position = UDim2.new(0.05, 0, 0.35, 0)
AimFovBtn.Size = UDim2.new(0.9, 0, 0, 36)
AimFovBtn.BackgroundColor3 = CARD_BG
AimFovBtn.TextColor3 = Color3.fromRGB(200, 220, 255)
AimFovBtn.Font = Enum.Font.SourceSansBold
AimFovBtn.TextSize = 13
AimFovBtn.Text = "Găm Tâm FOV: OFF"

local AimCorner = Instance.new("UICorner")
AimCorner.CornerRadius = UDim.new(0, 8)
AimCorner.Parent = AimFovBtn

local AimStroke = Instance.new("UIStroke")
AimStroke.Color = DARK_BLUE
AimStroke.Thickness = 1.5
AimStroke.Parent = AimFovBtn

AimFovBtn.MouseButton1Click:Connect(function()
    aimGlowEnabled = not aimGlowEnabled
    FovCircle.Visible = aimGlowEnabled
    
    if aimGlowEnabled then
        AimFovBtn.Text = "Găm Tâm FOV: ON"
        AimFovBtn.BackgroundColor3 = DARK_BLUE
        AimFovBtn.TextColor3 = BRIGHT_BLUE
        AimStroke.Color = BRIGHT_BLUE
    else
        AimFovBtn.Text = "Găm Tâm FOV: OFF"
        AimFovBtn.BackgroundColor3 = CARD_BG
        AimFovBtn.TextColor3 = Color3.fromRGB(200, 220, 255)
        AimStroke.Color = DARK_BLUE
    end
end)

local function getTargetInFOV()
    local closestPlayer = nil
    local shortestDistance = FovCircle.Radius
    local centerScreen = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, player in pairs(Players:GetPlayers()) do
        if isEnemy(player) and player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local partPos, onScreen = Camera:WorldToViewportPoint(player.Character.Head.Position)
            if onScreen then
                local distance = (Vector2.new(partPos.X, partPos.Y) - centerScreen).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end
    return closestPlayer
end

-- 7. CHỨC NĂNG ESP KHUNG, ĐƯỜNG KẺ & THANH MÁU (HEALTH ESP)
local espEnabled = false
local espDrawings = {}

local EspBtn = Instance.new("TextButton")
EspBtn.Parent = MainFrame
EspBtn.Position = UDim2.new(0.05, 0, 0.54, 0)
EspBtn.Size = UDim2.new(0.9, 0, 0, 36)
EspBtn.BackgroundColor3 = CARD_BG
EspBtn.TextColor3 = Color3.fromRGB(200, 220, 255)
EspBtn.Font = Enum.Font.SourceSansBold
EspBtn.TextSize = 13
EspBtn.Text = "Khung, Kẻ & Máu: OFF"

local EspCorner = Instance.new("UICorner")
EspCorner.CornerRadius = UDim.new(0, 8)
EspCorner.Parent = EspBtn

local EspStroke = Instance.new("UIStroke")
EspStroke.Color = DARK_BLUE
EspStroke.Thickness = 1.5
EspStroke.Parent = EspBtn

local function createPlayerEsp(plr)
    if plr == LocalPlayer then return end
    
    local box = Drawing.new("Square")
    box.Color = PRIMARY_BLUE
    box.Thickness = 1.5
    box.Filled = false
    box.Visible = false

    local tracer = Drawing.new("Line")
    tracer.Color = PRIMARY_BLUE
    tracer.Thickness = 1.5
    tracer.Visible = false

    local healthBarBg = Drawing.new("Line")
    healthBarBg.Color = Color3.fromRGB(30, 30, 30)
    healthBarBg.Thickness = 3
    healthBarBg.Visible = false

    local healthBar = Drawing.new("Line")
    healthBar.Color = Color3.fromRGB(0, 255, 0)
    healthBar.Thickness = 1.5
    healthBar.Visible = false

    espDrawings[plr] = {Box = box, Tracer = tracer, HealthBarBg = healthBarBg, HealthBar = healthBar}
end

local function removePlayerEsp(plr)
    if espDrawings[plr] then
        espDrawings[plr].Box:Remove()
        espDrawings[plr].Tracer:Remove()
        espDrawings[plr].HealthBarBg:Remove()
        espDrawings[plr].HealthBar:Remove()
        espDrawings[plr] = nil
    end
end

for _, plr in pairs(Players:GetPlayers()) do createPlayerEsp(plr) end
Players.PlayerAdded:Connect(createPlayerEsp)
Players.PlayerRemoving:Connect(removePlayerEsp)

EspBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        EspBtn.Text = "Khung, Kẻ & Máu: ON"
        EspBtn.BackgroundColor3 = DARK_BLUE
        EspBtn.TextColor3 = BRIGHT_BLUE
        EspStroke.Color = BRIGHT_BLUE
    else
        EspBtn.Text = "Khung, Kẻ & Máu: OFF"
        EspBtn.BackgroundColor3 = CARD_BG
        EspBtn.TextColor3 = Color3.fromRGB(200, 220, 255)
        EspStroke.Color = DARK_BLUE
    end
end)

-- VÒNG LẶP RENDERSTEPPED CẬP NHẬT LIÊN TỤC
RunService.RenderStepped:Connect(function()
    FovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    if aimGlowEnabled then
        local target = getTargetInFOV()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.Head.Position)
        end
    end

    for plr, drawing in pairs(espDrawings) do
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")

        if espEnabled and isEnemy(plr) and hrp and hum and hum.Health > 0 then
            local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
            
            if onScreen then
                local head = char:FindFirstChild("Head")
                local headPos = head and Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0)) or pos
                local legPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                
                local height = math.abs(headPos.Y - legPos.Y)
                local width = height / 1.5

                drawing.Box.Size = Vector2.new(width, height)
                drawing.Box.Position = Vector2.new(pos.X - width / 2, pos.Y - height / 2)
                drawing.Box.Visible = true

                drawing.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, 0)
                drawing.Tracer.To = Vector2.new(pos.X, pos.Y - height / 2)
                drawing.Tracer.Visible = true

                local healthPercent = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                local barX = (pos.X - width / 2) - 6
                local barTopY = pos.Y - height / 2
                local barBottomY = pos.Y + height / 2

                drawing.HealthBarBg.From = Vector2.new(barX, barTopY)
                drawing.HealthBarBg.To = Vector2.new(barX, barBottomY)
                drawing.HealthBarBg.Visible = true

                local currentBarHeight = height * healthPercent
                drawing.HealthBar.From = Vector2.new(barX, barBottomY)
                drawing.HealthBar.To = Vector2.new(barX, barBottomY - currentBarHeight)
                drawing.HealthBar.Color = Color3.fromRGB(255 * (1 - healthPercent), 255 * healthPercent, 0)
                drawing.HealthBar.Visible = true
            else
                drawing.Box.Visible = false
                drawing.Tracer.Visible = false
                drawing.HealthBarBg.Visible = false
                drawing.HealthBar.Visible = false
            end
        else
            drawing.Box.Visible = false
            drawing.Tracer.Visible = false
            drawing.HealthBarBg.Visible = false
            drawing.HealthBar.Visible = false
        end
    end
end)
