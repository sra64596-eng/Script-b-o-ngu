-- Tạo giao diện GUI Tuất kỳ hub (Tông Màu Đỏ)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TuatKyHub_VIP_Red"
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
OpenMenuBtn.Name = "ToggleHubBtn"
OpenMenuBtn.Parent = ScreenGui
OpenMenuBtn.Size = UDim2.new(0, 100, 0, 40)
OpenMenuBtn.Position = UDim2.new(0.02, 0, 0.15, 0)
OpenMenuBtn.BackgroundColor3 = Color3.fromRGB(25, 15, 15)
OpenMenuBtn.Text = "TUẤT KỲ"
OpenMenuBtn.TextColor3 = Color3.fromRGB(255, 40, 40)
OpenMenuBtn.Font = Enum.Font.SourceSansBold
OpenMenuBtn.TextSize = 16
OpenMenuBtn.Active = true
OpenMenuBtn.Draggable = true

local OpenBtnCorner = Instance.new("UICorner")
OpenBtnCorner.CornerRadius = UDim.new(0, 10)
OpenBtnCorner.Parent = OpenMenuBtn

local OpenBtnStroke = Instance.new("UIStroke")
OpenBtnStroke.Thickness = 1.5
OpenBtnStroke.Color = Color3.fromRGB(255, 40, 40)
OpenBtnStroke.Parent = OpenMenuBtn

---------------------------------------------------------
-- 2. BẢNG MENU CHÍNH (TUẤT KỲ HUB)
---------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 240, 0, 250)
MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 12)
FrameCorner.Parent = MainFrame

local MainFrameStroke = Instance.new("UIStroke")
MainFrameStroke.Thickness = 1.5
MainFrameStroke.Color = Color3.fromRGB(255, 40, 40)
MainFrameStroke.Parent = MainFrame

-- Thanh Tiêu Đề
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 42)
Title.Text = "TUẤT KỲ HUB"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

local TitleStroke = Instance.new("UIStroke")
TitleStroke.Thickness = 1
TitleStroke.Color = Color3.fromRGB(255, 40, 40)
TitleStroke.Parent = Title

-- Xử lý ẩn/hiện menu
local MenuVisible = true
OpenMenuBtn.MouseButton1Click:Connect(function()
    MenuVisible = not MenuVisible
    MainFrame.Visible = MenuVisible
end)

---------------------------------------------------------
-- 3. CÁC NÚT TÍNH NĂNG & THANH CHỈNH TỐC ĐỘ CHẠY
---------------------------------------------------------
local function CreateButton(text, posY)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.Size = UDim2.new(0, 220, 0, 38)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(35, 25, 25)
    btn.Text = text .. " : TẮT"
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 15
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(75, 40, 40)
    stroke.Parent = btn

    return btn, stroke
end

local BtnAimbot, StrokeAimbot = CreateButton("Aim Mượt", 52)
local BtnESP, StrokeESP = CreateButton("Định Vị Khung + Dây Đỏ", 100)
local BtnSpeed, StrokeSpeed = CreateButton("Tốc Độ Chạy", 148)

---------------------------------------------------------
-- KHU VỰC ĐIỀU CHỈNH TỐC ĐỘ (GIỚI HẠN TỐI ĐA 30)
---------------------------------------------------------
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Parent = MainFrame
SpeedFrame.Size = UDim2.new(0, 220, 0, 40)
SpeedFrame.Position = UDim2.new(0, 10, 0, 196)
SpeedFrame.BackgroundColor3 = Color3.fromRGB(30, 20, 20)

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 8)
SpeedCorner.Parent = SpeedFrame

local SpeedStroke = Instance.new("UIStroke")
SpeedStroke.Thickness = 1
SpeedStroke.Color = Color3.fromRGB(75, 40, 40)
SpeedStroke.Parent = SpeedFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = SpeedFrame
SpeedLabel.Size = UDim2.new(0, 120, 1, 0)
SpeedLabel.Position = UDim2.new(0, 10, 0, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Tốc Độ (Max 30):"
SpeedLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
SpeedLabel.Font = Enum.Font.SourceSansBold
SpeedLabel.TextSize = 14
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedInput = Instance.new("TextBox")
SpeedInput.Parent = SpeedFrame
SpeedInput.Size = UDim2.new(0, 75, 0, 26)
SpeedInput.Position = UDim2.new(1, -85, 0.5, -13)
SpeedInput.BackgroundColor3 = Color3.fromRGB(45, 25, 25)
SpeedInput.Text = "30"
SpeedInput.TextColor3 = Color3.fromRGB(255, 80, 80)
SpeedInput.Font = Enum.Font.SourceSansBold
SpeedInput.TextSize = 14

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = SpeedInput

local InputStroke = Instance.new("UIStroke")
InputStroke.Thickness = 1
InputStroke.Color = Color3.fromRGB(255, 40, 40)
InputStroke.Parent = SpeedInput

---------------------------------------------------------
-- 4. KHAI BÁO TÍNH NĂNG & XỬ LÝ CHỐNG DI CHUYỂN NGƯỢC
---------------------------------------------------------
local AimOn = false
local ESPOn = false
local SpeedOn = false
local CustomSpeed = 30
local MAX_SPEED = 30

local AimFOVRadius = 130
local Smoothness = 0.25

-- Vòng Tròn FOV
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Thickness = 1.5
FOVCircle.Radius = AimFOVRadius
FOVCircle.Color = Color3.fromRGB(255, 40, 40)
FOVCircle.Filled = false
FOVCircle.Transparency = 1

BtnAimbot.MouseButton1Click:Connect(function()
    AimOn = not AimOn
    FOVCircle.Visible = AimOn
    
    BtnAimbot.Text = AimOn and "Aim Mượt : BẬT" or "Aim Mượt : TẮT"
    BtnAimbot.TextColor3 = AimOn and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
    BtnAimbot.BackgroundColor3 = AimOn and Color3.fromRGB(180, 30, 30) or Color3.fromRGB(35, 25, 25)
    StrokeAimbot.Color = AimOn and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(75, 40, 40)
end)

-- Bật/Tắt Tốc Độ Chạy
BtnSpeed.MouseButton1Click:Connect(function()
    SpeedOn = not SpeedOn
    BtnSpeed.Text = SpeedOn and "Tốc Độ Chạy : BẬT" or "Tốc Độ Chạy : TẮT"
    BtnSpeed.TextColor3 = SpeedOn and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
    BtnSpeed.BackgroundColor3 = SpeedOn and Color3.fromRGB(180, 30, 30) or Color3.fromRGB(35, 25, 25)
    StrokeSpeed.Color = SpeedOn and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(75, 40, 40)
    
    local char = game.Players.LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = 16 -- Đưa về chuẩn khi tắt
    end
end)

-- Nhập tốc độ và kiểm tra giới hạn <= 30
SpeedInput.FocusLost:Connect(function()
    local num = tonumber(SpeedInput.Text)
    if num then
        if num > MAX_SPEED then
            num = MAX_SPEED
        elseif num < 16 then
            num = 16
        end
        CustomSpeed = num
        SpeedInput.Text = tostring(CustomSpeed)
    else
        SpeedInput.Text = tostring(CustomSpeed)
    end
end)

-- Hàm kiểm tra người chơi có trong trận không
local function IsPlayerInMatch(plr)
    if not plr or plr == game.Players.LocalPlayer then return false end
    local char = plr.Character
    if not char then return false end
    
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    local head = char:FindFirstChild("Head")
    
    if not (hum and root and head and hum.Health > 0) then return false end
    if root.Position.Y < workspace.FallenPartsDestroyHeight then return false end
    if char:FindFirstChildOfClass("ForceField") then return false end
    
    local inGameFolder = workspace:FindFirstChild("InGame") or workspace:FindFirstChild("Playing") or workspace:FindFirstChild("PlayersInMatch")
    if inGameFolder and not inGameFolder:FindFirstChild(plr.Name) then return false end
    
    return true
end

---------------------------------------------------------
-- 5. HỆ THỐNG ESP KHUNG VUÔNG + DÂY NỐI
---------------------------------------------------------
local ESPCache = {}

local function CreateESPForPlayer(plr)
    if ESPCache[plr] then return end
    
    local Box = Drawing.new("Square")
    Box.Visible = false
    Box.Color = Color3.fromRGB(255, 30, 30)
    Box.Thickness = 1.5
    Box.Filled = false
    
    local Line = Drawing.new("Line")
    Line.Visible = false
    Line.Color = Color3.fromRGB(255, 30, 30)
    Line.Thickness = 1.5
    
    ESPCache[plr] = {Box = Box, Line = Line}
end

local function RemoveESPForPlayer(plr)
    if ESPCache[plr] then
        if ESPCache[plr].Box then ESPCache[plr].Box:Remove() end
        if ESPCache[plr].Line then ESPCache[plr].Line:Remove() end
        ESPCache[plr] = nil
    end
end

BtnESP.MouseButton1Click:Connect(function()
    ESPOn = not ESPOn
    BtnESP.Text = ESPOn and "Định Vị Khung + Dây : BẬT" or "Định Vị Khung + Dây : TẮT"
    BtnESP.TextColor3 = ESPOn and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
    BtnESP.BackgroundColor3 = ESPOn and Color3.fromRGB(180, 30, 30) or Color3.fromRGB(35, 25, 25)
    StrokeESP.Color = ESPOn and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(75, 40, 40)
    
    if not ESPOn then
        for _, drawObjects in pairs(ESPCache) do
            drawObjects.Box.Visible = false
            drawObjects.Line.Visible = false
        end
    end
end)

game.Players.PlayerRemoving:Connect(RemoveESPForPlayer)

---------------------------------------------------------
-- 6. VÒNG LẶP XỬ LÝ CƠ CHẾ CHỐNG LAG GIẬT (RENDERSTEPPED)
---------------------------------------------------------
game:GetService("RunService").RenderStepped:Connect(function()
    local Cam = workspace.CurrentCamera
    local CenterScreen = Vector2.new(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2)
    local TopScreen = Vector2.new(Cam.ViewportSize.X / 2, 0)

    FOVCircle.Position = CenterScreen

    -- XỬ LÝ TỐC ĐỘ CHẠY KHÔNG BỊ GIẬT LẠI VỊ TRÍ CŨ
    if SpeedOn then
        local myChar = game.Players.LocalPlayer.Character
        local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        
        if myHum and myRoot and myHum.MoveDirection.Magnitude > 0 then
            -- Áp dụng gia tốc vật lý tự nhiên thay vì thay đổi thuộc tính thô
            myHum.WalkSpeed = math.min(CustomSpeed, MAX_SPEED)
            local moveVector = myHum.MoveDirection * (math.min(CustomSpeed, MAX_SPEED) - myHum.WalkSpeed)
            myRoot.AssemblyLinearVelocity = Vector3.new(
                myHum.MoveDirection.X * math.min(CustomSpeed, MAX_SPEED),
                myRoot.AssemblyLinearVelocity.Y,
                myHum.MoveDirection.Z * math.min(CustomSpeed, MAX_SPEED)
            )
        end
    end

    -- Cập nhật Định vị ESP
    if ESPOn then
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= game.Players.LocalPlayer then
                CreateESPForPlayer(plr)
                local esp = ESPCache[plr]
                
                if IsPlayerInMatch(plr) then
                    local char = plr.Character
                    local root = char.HumanoidRootPart
                    local head = char.Head
                    
                    local RootPos, OnScreen = Cam:WorldToViewportPoint(root.Position)
                    local HeadPos = Cam:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                    local LegPos = Cam:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))
                    
                    if OnScreen then
                        local Height = math.abs(HeadPos.Y - LegPos.Y)
                        local Width = Height / 1.5
                        
                        esp.Box.Size = Vector2.new(Width, Height)
                        esp.Box.Position = Vector2.new(RootPos.X - Width / 2, HeadPos.Y)
                        esp.Box.Visible = true
                        
                        esp.Line.From = TopScreen
                        esp.Line.To = Vector2.new(RootPos.X, HeadPos.Y)
                        esp.Line.Visible = true
                    else
                        esp.Box.Visible = false
                        esp.Line.Visible = false
                    end
                else
                    if esp then
                        esp.Box.Visible = false
                        esp.Line.Visible = false
                    end
                end
            end
        end
    end

    -- Cập nhật AIMBOT MƯỢT
    if AimOn then
        local TargetHead = nil
        local ShortestDist = AimFOVRadius

        for _, plr in pairs(game.Players:GetPlayers()) do
            if IsPlayerInMatch(plr) then
                local Head = plr.Character.Head
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

        if TargetHead then
            local TargetCFrame = CFrame.lookAt(Cam.CFrame.Position, TargetHead.Position)
            Cam.CFrame = Cam.CFrame:Lerp(TargetCFrame, Smoothness)
        end
    end
end)
