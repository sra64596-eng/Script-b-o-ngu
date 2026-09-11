-- Tạo giao diện GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VIPMenuGui_PermanentESP"
ScreenGui.ResetOnSpawn = false

local Success, _ = pcall(function()
    ScreenGui.Parent = game.CoreGui
end)
if not Success then
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
end

---------------------------------------------------------
-- 1. NÚT MỞ/TẮT MENU ON-SCREEN
---------------------------------------------------------
local OpenMenuBtn = Instance.new("TextButton")
OpenMenuBtn.Parent = ScreenGui
OpenMenuBtn.Size = UDim2.new(0, 80, 0, 35)
OpenMenuBtn.Position = UDim2.new(0.02, 0, 0.15, 0)
OpenMenuBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
OpenMenuBtn.Text = "MENU"
OpenMenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenMenuBtn.Font = Enum.Font.SourceSansBold
OpenMenuBtn.TextSize = 14
OpenMenuBtn.Active = true
OpenMenuBtn.Draggable = true

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = OpenMenuBtn

---------------------------------------------------------
-- 2. BẢNG MENU CHÍNH
---------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 220, 0, 245)
MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 10)
FrameCorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "VIP MENU (PERMANENT ESP)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 13

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

local MenuVisible = true
OpenMenuBtn.MouseButton1Click:Connect(function()
    MenuVisible = not MenuVisible
    MainFrame.Visible = MenuVisible
end)

---------------------------------------------------------
-- 3. CÁC NÚT BẤM TÍNH NĂNG
---------------------------------------------------------
local function CreateButton(text, posY)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.Size = UDim2.new(0, 200, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    btn.Text = text .. ": TẮT"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    return btn
end

local BtnAimbot = CreateButton("Aim Mượt", 45)
local BtnFOV = CreateButton("Vòng FOV Cố Định", 90)
local BtnESP = CreateButton("Định Vị ESP Đỏ", 135)
local BtnWideFOV = CreateButton("Góc Nhìn Rộng (Cam)", 180)

---------------------------------------------------------
-- 4. KHAI BÁO TÍNH NĂNG
---------------------------------------------------------
local AimOn = false
local FOVOn = false
local ESPOn = false
local WideFOVOn = false

local AimFOVRadius = 100
local NormalCamFOV = 70
local WideCamFOV = 100
local Smoothness = 0.25

local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Thickness = 1.5
FOVCircle.Radius = AimFOVRadius
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Filled = false
FOVCircle.Transparency = 1

BtnAimbot.MouseButton1Click:Connect(function()
    AimOn = not AimOn
    BtnAimbot.Text = AimOn and "Aim Mượt: BẬT" or "Aim Mượt: TẮT"
    BtnAimbot.BackgroundColor3 = AimOn and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
end)

BtnFOV.MouseButton1Click:Connect(function()
    FOVOn = not FOVOn
    FOVCircle.Visible = FOVOn
    BtnFOV.Text = FOVOn and "Vòng FOV Cố Định: BẬT" or "Vòng FOV Cố Định: TẮT"
    BtnFOV.BackgroundColor3 = FOVOn and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
end)

BtnWideFOV.MouseButton1Click:Connect(function()
    WideFOVOn = not WideFOVOn
    BtnWideFOV.Text = WideFOVOn and "Góc Nhìn Rộng: BẬT" or "Góc Nhìn Rộng: TẮT"
    BtnWideFOV.BackgroundColor3 = WideFOVOn and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
    
    if not WideFOVOn then
        workspace.CurrentCamera.FieldOfView = NormalCamFOV
    end
end)

---------------------------------------------------------
-- 5. HỆ THỐNG ĐỊNH VỊ ESP ĐỎ VĨNH CỬU (FIX LỖI MẤT ĐỊNH VỊ)
---------------------------------------------------------
local function ApplyHighlight(character)
    if not character then return end
    
    local highlight = character:FindFirstChild("PermanentESPHighlight")
    if not highlight then
        highlight = Instance.new("Highlight")
        highlight.Name = "PermanentESPHighlight"
        highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Màu đỏ
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- Viền trắng
        highlight.FillTransparency = 0.3
        highlight.OutlineTransparency = 0
        highlight.Parent = character
    end
end

local function RemoveHighlight(character)
    if character and character:FindFirstChild("PermanentESPHighlight") then
        character.PermanentESPHighlight:Destroy()
    end
end

BtnESP.MouseButton1Click:Connect(function()
    ESPOn = not ESPOn
    BtnESP.Text = ESPOn and "Định Vị ESP Đỏ: BẬT" or "Định Vị ESP Đỏ: TẮT"
    BtnESP.BackgroundColor3 = ESPOn and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
    
    if not ESPOn then
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr.Character then
                RemoveHighlight(plr.Character)
            end
        end
    end
end)

-- Tự động gắn ESP ngay khi người chơi mới kết nối hoặc hồi sinh
local function TrackPlayer(plr)
    if plr == game.Players.LocalPlayer then return end
    
    plr.CharacterAdded:Connect(function(char)
        if ESPOn then
            char:WaitForChild("Humanoid", 5)
            ApplyHighlight(char)
        end
    end)
    
    if plr.Character then
        ApplyHighlight(plr.Character)
    end
end

for _, plr in pairs(game.Players:GetPlayers()) do
    TrackPlayer(plr)
end
game.Players.PlayerAdded:Connect(TrackPlayer)

---------------------------------------------------------
-- 6. VÒNG LẶP XỬ LÝ CHÍNH
---------------------------------------------------------
game:GetService("RunService").RenderStepped:Connect(function()
    local Cam = workspace.CurrentCamera
    local CenterScreen = Vector2.new(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2)
    
    if WideFOVOn then
        Cam.FieldOfView = WideCamFOV
    end

    FOVCircle.Position = CenterScreen

    -- Duyệt quét định vị liên tục (Chống bị trôi/mất ESP)
    if ESPOn then
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                if plr.Character.Humanoid.Health > 0 then
                    ApplyHighlight(plr.Character)
                else
                    RemoveHighlight(plr.Character)
                end
            end
        end
    end

    -- AIMBOT MƯỢT
    if AimOn then
        local TargetHead = nil
        local ShortestDist = AimFOVRadius

        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= game.Players.LocalPlayer and plr.Character then
                local Hum = plr.Character:FindFirstChildOfClass("Humanoid")
                local Head = plr.Character:FindFirstChild("Head")
                
                if Hum and Hum.Health > 0 and Head and Head.Position.Y > workspace.FallenPartsDestroyHeight then
                    local ScreenPos, OnScreen = Cam:WorldToViewportPoint(Head.Position)
                    
                    if OnScreen then
                        local Dist = (Vector2.new(ScreenPos.X, ScreenPos.Y) - CenterScreen).Magnitude
                        if Dist < ShortestDist then
                            ShortestDist = Dist
                            TargetHead = Head
                        end
                    end
                end
            end
        end

        if TargetHead then
            local TargetCFrame = CFrame.lookAt(Cam.CFrame.Position, TargetHead.Position)
            Cam.CFrame = Cam.CFrame:Lerp(TargetCFrame, Smoothness)
        end
    end
end)
