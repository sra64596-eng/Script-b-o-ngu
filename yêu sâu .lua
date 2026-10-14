-- Kiểm tra game đã tải xong chưa
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer

-- Tạo ScreenGui chính
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FreezeHubGui"
ScreenGui.ResetOnSpawn = false

-- Bảo vệ GUI khỏi bị xóa khi reset
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = CoreGui
end

-- 1. Nút Bật/Tắt Menu Dạng Hình Tròn ❄️
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "CircleToggleButton"
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 20, 0.15, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 130, 255)
ToggleButton.Text = "❄️"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 26
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(150, 220, 255)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleButton

-- 2. Khung Main Menu (Chính)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 250, 0, 395)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -197)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 115, 230)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Tiêu đề Menu: ❄️ Freeze Hub ❄️
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(0, 115, 230)
Title.Text = "❄️ Freeze Hub ❄️"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Hiển thị FPS
local FPSLabel = Instance.new("TextLabel")
FPSLabel.Size = UDim2.new(0.9, 0, 0, 30)
FPSLabel.Position = UDim2.new(0.05, 0, 0, 50)
FPSLabel.BackgroundColor3 = Color3.fromRGB(20, 35, 60)
FPSLabel.Text = "FPS: Đang tính..."
FPSLabel.TextColor3 = Color3.fromRGB(0, 230, 255)
FPSLabel.TextSize = 13
FPSLabel.Font = Enum.Font.GothamSemibold
FPSLabel.Parent = MainFrame

local FPSCorner = Instance.new("UICorner")
FPSCorner.CornerRadius = UDim.new(0, 6)
FPSCorner.Parent = FPSLabel

-- Nút Định Vị Quái Vật
local ESPButton = Instance.new("TextButton")
ESPButton.Size = UDim2.new(0.9, 0, 0, 40)
ESPButton.Position = UDim2.new(0.05, 0, 0, 90)
ESPButton.BackgroundColor3 = Color3.fromRGB(25, 45, 75)
ESPButton.Text = "Định Vị Quái: TẮT"
ESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPButton.TextSize = 13
ESPButton.Font = Enum.Font.GothamSemibold
ESPButton.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = ESPButton

-- Nút Định Vị Người Chơi (Khung cố định vừa vặn + Dây từ đỉnh màn hình)
local PlayerESPButton = Instance.new("TextButton")
PlayerESPButton.Size = UDim2.new(0.9, 0, 0, 40)
PlayerESPButton.Position = UDim2.new(0.05, 0, 0, 135)
PlayerESPButton.BackgroundColor3 = Color3.fromRGB(25, 45, 75)
PlayerESPButton.Text = "Định Vị Người Chơi: TẮT"
PlayerESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerESPButton.TextSize = 13
PlayerESPButton.Font = Enum.Font.GothamSemibold
PlayerESPButton.Parent = MainFrame

local PlayerESPBtnCorner = Instance.new("UICorner")
PlayerESPBtnCorner.CornerRadius = UDim.new(0, 6)
PlayerESPBtnCorner.Parent = PlayerESPButton

-- Nút Định Vị Nhà
local HouseESPButton = Instance.new("TextButton")
HouseESPButton.Size = UDim2.new(0.9, 0, 0, 40)
HouseESPButton.Position = UDim2.new(0.05, 0, 0, 180)
HouseESPButton.BackgroundColor3 = Color3.fromRGB(25, 45, 75)
HouseESPButton.Text = "Định Vị Nhà: TẮT"
HouseESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HouseESPButton.TextSize = 13
HouseESPButton.Font = Enum.Font.GothamSemibold
HouseESPButton.Parent = MainFrame

local HouseBtnCorner = Instance.new("UICorner")
HouseBtnCorner.CornerRadius = UDim.new(0, 6)
HouseBtnCorner.Parent = HouseESPButton

-- Nút Sáng Trời Tối
local BrightButton = Instance.new("TextButton")
BrightButton.Size = UDim2.new(0.9, 0, 0, 40)
BrightButton.Position = UDim2.new(0.05, 0, 0, 225)
BrightButton.BackgroundColor3 = Color3.fromRGB(25, 45, 75)
BrightButton.Text = "Sáng Trời Tối: TẮT"
BrightButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BrightButton.TextSize = 13
BrightButton.Font = Enum.Font.GothamSemibold
BrightButton.Parent = MainFrame

local BrightCorner = Instance.new("UICorner")
BrightCorner.CornerRadius = UDim.new(0, 6)
BrightCorner.Parent = BrightButton

-- Cập nhật FPS liên tục
local lastTick = tick()
local frameCount = 0
RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local currentTick = tick()
    if currentTick - lastTick >= 1 then
        local fps = math.floor(frameCount / (currentTick - lastTick))
        FPSLabel.Text = "FPS: " .. fps
        frameCount = 0
        lastTick = currentTick
    end
end)

-- 3. Định Vị Quái Vật
local espEnabled = false
local monitoredMonsters = {}

local function createMonsterESP(mob)
    if not mob:FindFirstChild("HumanoidRootPart") then return end
    if mob:FindFirstChild("MonsterESP") then return end
    
    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = "MonsterESP"
    Billboard.Adornee = mob.HumanoidRootPart
    Billboard.Size = UDim2.new(0, 150, 0, 50)
    Billboard.StudsOffset = Vector3.new(0, 3, 0)
    Billboard.AlwaysOnTop = true
    Billboard.Parent = mob

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    TextLabel.TextStrokeTransparency = 0.5
    TextLabel.TextSize = 13
    TextLabel.Font = Enum.Font.GothamBold
    TextLabel.Text = mob.Name
    TextLabel.Parent = Billboard

    table.insert(monitoredMonsters, {Model = mob, Gui = Billboard, Label = TextLabel})
end

local ignoredNPCKeywords = {"npc", "shop", "merchant", "quest", "guide", "citizen", "store"}
local function isNPC(model)
    local nameLower = string.lower(model.Name)
    for _, keyword in ipairs(ignoredNPCKeywords) do
        if string.find(nameLower, keyword) then return true end
    end
    return false
end

local function scanForMonsters()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj ~= LocalPlayer.Character then
            if not Players:GetPlayerFromCharacter(obj) and not isNPC(obj) then
                createMonsterESP(obj)
            end
        end
    end
end

ESPButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        ESPButton.Text = "Định Vị Quái: BẬT"
        ESPButton.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        scanForMonsters()
    else
        ESPButton.Text = "Định Vị Quái: TẮT"
        ESPButton.BackgroundColor3 = Color3.fromRGB(25, 45, 75)
        for _, data in pairs(monitoredMonsters) do
            if data.Gui then data.Gui:Destroy() end
        end
        monitoredMonsters = {}
    end
end)

-- 4. Định Vị Người Chơi (Khung cố định tỷ lệ chuẩn xác, không bị co giãn bất thường)
local playerEspEnabled = false
local monitoredPlayers = {}

local function createPlayerESP(plr)
    if plr == LocalPlayer then return end
    
    local function addESP(char)
        if not char:FindFirstChild("HumanoidRootPart") then return end
        if char:FindFirstChild("CustomPlayerESP") then return end
        
        local Billboard = Instance.new("BillboardGui")
        Billboard.Name = "CustomPlayerESP"
        Billboard.Adornee = char.HumanoidRootPart
        -- Cố định kích thước khung vừa khít thân người chơi
        Billboard.Size = UDim2.new(0, 35, 0, 60)
        Billboard.StudsOffset = Vector3.new(0, 0.5, 0)
        Billboard.AlwaysOnTop = true
        Billboard.Parent = char

        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, 0, 1, 0)
        Frame.BackgroundTransparency = 1
        Frame.Parent = Billboard

        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Color3.fromRGB(0, 170, 255)
        Stroke.Thickness = 1.5
        Stroke.Parent = Frame

        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(4, 0, 0, 25)
        TextLabel.Position = UDim2.new(-1.5, 0, -0.45, 0)
        TextLabel.BackgroundTransparency = 1
        TextLabel.TextColor3 = Color3.fromRGB(0, 220, 255)
        TextLabel.TextStrokeTransparency = 0.5
        TextLabel.TextSize = 12
        TextLabel.Font = Enum.Font.GothamBold
        TextLabel.Text = plr.Name
        TextLabel.Parent = Billboard

        -- Tạo đường dây (Tracer Line) từ đỉnh màn hình xuống
        local TracerLine = Drawing.new("Line")
        TracerLine.Visible = false
        TracerLine.Color = Color3.fromRGB(0, 170, 255)
        TracerLine.Thickness = 1.5
        TracerLine.Transparency = 0.8

        table.insert(monitoredPlayers, {Player = plr, Character = char, Gui = Billboard, Label = TextLabel, Line = TracerLine})
    end

    if plr.Character then
        addESP(plr.Character)
    end
    plr.CharacterAdded:Connect(addESP)
end

PlayerESPButton.MouseButton1Click:Connect(function()
    playerEspEnabled = not playerEspEnabled
    if playerEspEnabled then
        PlayerESPButton.Text = "Định Vị Người Chơi: BẬT"
        PlayerESPButton.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        for _, p in pairs(Players:GetPlayers()) do
            createPlayerESP(p)
        end
    else
        PlayerESPButton.Text = "Định Vị Người Chơi: TẮT"
        PlayerESPButton.BackgroundColor3 = Color3.fromRGB(25, 45, 75)
        for _, data in pairs(monitoredPlayers) do
            if data.Gui then data.Gui:Destroy() end
            if data.Line then data.Line:Remove() end
        end
        monitoredPlayers = {}
    end
end)

Players.PlayerAdded:Connect(function(plr)
    if playerEspEnabled then
        createPlayerESP(plr)
    end
end)

-- 5. Định Vị Nhà
local homePosition = nil
local houseEspEnabled = false
local anchorPart = nil
local houseBillboard = nil
local houseLabel = nil

local function removeHouseESP()
    if houseBillboard then houseBillboard:Destroy() houseBillboard = nil end
    if anchorPart then anchorPart:Destroy() anchorPart = nil end
    homePosition = nil
end

local function createHouseESPAtCurrentPos()
    removeHouseESP()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    homePosition = char.HumanoidRootPart.Position

    local folder = workspace:FindFirstChild("HouseMarkerFolder") or Instance.new("Folder", workspace)
    folder.Name = "HouseMarkerFolder"

    anchorPart = Instance.new("Part")
    anchorPart.Name = "HomeAnchor"
    anchorPart.Size = Vector3.new(1, 1, 1)
    anchorPart.Position = homePosition
    anchorPart.Anchored = true
    anchorPart.CanCollide = false
    anchorPart.Transparency = 1
    anchorPart.Parent = folder

    houseBillboard = Instance.new("BillboardGui")
    houseBillboard.Name = "MyHomeESP"
    houseBillboard.Adornee = anchorPart
    houseBillboard.Size = UDim2.new(0, 150, 0, 50)
    houseBillboard.StudsOffset = Vector3.new(0, 3, 0)
    houseBillboard.AlwaysOnTop = true
    houseBillboard.Parent = anchorPart

    houseLabel = Instance.new("TextLabel")
    houseLabel.Size = UDim2.new(1, 0, 1, 0)
    houseLabel.BackgroundTransparency = 1
    houseLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
    houseLabel.TextStrokeTransparency = 0.5
    houseLabel.TextSize = 14
    houseLabel.Font = Enum.Font.GothamBold
    houseLabel.Text = "Nhà Của Bạn"
    houseLabel.Parent = houseBillboard
end

HouseESPButton.MouseButton1Click:Connect(function()
    houseEspEnabled = not houseEspEnabled
    if houseEspEnabled then
        HouseESPButton.Text = "Định Vị Nhà: BẬT"
        HouseESPButton.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        createHouseESPAtCurrentPos()
    else
        HouseESPButton.Text = "Định Vị Nhà: TẮT"
        HouseESPButton.BackgroundColor3 = Color3.fromRGB(25, 45, 75)
        removeHouseESP()
    end
end)

-- 6. Chức năng Sáng Trời Tối
local brightEnabled = false

local function toggleBrightMode(state)
    brightEnabled = state
    if brightEnabled then
        Lighting.Brightness = 3
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            if not char.HumanoidRootPart:FindFirstChild("PlayerLight") then
                local lightSource = Instance.new("PointLight")
                lightSource.Name = "PlayerLight"
                lightSource.Range = 120
                lightSource.Brightness = 5
                lightSource.Parent = char.HumanoidRootPart
            end
        end
    else
        Lighting.Brightness = 1
        Lighting.GlobalShadows = true
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local light = char.HumanoidRootPart:FindFirstChild("PlayerLight")
            if light then light:Destroy() end
        end
    end
end

BrightButton.MouseButton1Click:Connect(function()
    toggleBrightMode(not brightEnabled)
    if brightEnabled then
        BrightButton.Text = "Sáng Trời Tối: BẬT"
        BrightButton.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
    else
        BrightButton.Text = "Sáng Trời Tối: TẮT"
        BrightButton.BackgroundColor3 = Color3.fromRGB(25, 45, 75)
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    houseEspEnabled = false
    HouseESPButton.Text = "Định Vị Nhà: TẮT"
    HouseESPButton.BackgroundColor3 = Color3.fromRGB(25, 45, 75)
    removeHouseESP()
    
    if brightEnabled then
        task.wait(0.5)
        toggleBrightMode(true)
    end
end)

-- Vòng lặp Cập Nhật Khoảng Cách & Đường Chỉ (Tracer)
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local rootPos = char.HumanoidRootPart.Position

    -- Cập nhật quái
    if espEnabled then
        for i = #monitoredMonsters, 1, -1 do
            local data = monitoredMonsters[i]
            if data.Model and data.Model.Parent and data.Model:FindFirstChild("HumanoidRootPart") then
                local distance = math.floor((data.Model.HumanoidRootPart.Position - rootPos).Magnitude)
                data.Label.Text = string.format("%s\n[%dm]", data.Model.Name, distance)
            else
                if data.Gui then data.Gui:Destroy() end
                table.remove(monitoredMonsters, i)
            end
        end
    end

    -- Cập nhật người chơi (Khung cố định gọn gàng + Dây từ đỉnh màn hình)
    if playerEspEnabled then
        for i = #monitoredPlayers, 1, -1 do
            local data = monitoredPlayers[i]
            if data.Character and data.Character.Parent and data.Character:FindFirstChild("HumanoidRootPart") then
                local distance = math.floor((data.Character.HumanoidRootPart.Position - rootPos).Magnitude)
                data.Label.Text = string.format("%s\n[%dm]", data.Player.Name, distance)
                
                local vector, onScreen = Camera:WorldToViewportPoint(data.Character.HumanoidRootPart.Position)
                if onScreen and data.Line then
                    data.Line.From = Vector2.new(Camera.ViewportSize.X / 2, 0) 
                    data.Line.To = Vector2.new(vector.X, vector.Y)
                    data.Line.Visible = true
                else
                    if data.Line then data.Line.Visible = false end
                end
            else
                if data.Gui then data.Gui:Destroy() end
                if data.Line then data.Line:Remove() end
                table.remove(monitoredPlayers, i)
            end
        end
    else
        for _, data in ipairs(monitoredPlayers) do
            if data.Line then data.Line.Visible = false end
        end
    end

    -- Cập nhật nhà
    if houseEspEnabled and homePosition and houseLabel then
        local distance = math.floor((homePosition - rootPos).Magnitude)
        houseLabel.Text = string.format("Nhà Của Bạn\n[%dm]", distance)
    end
end)
