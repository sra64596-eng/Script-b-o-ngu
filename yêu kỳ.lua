-- Kiểm tra game đã tải xong chưa
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- ==================== CÀI ĐẶT KEY CỦA BẠN ====================
local MY_SECRET_KEY = "FreezeHub_VIP_2026"

-- 1. BẢNG NHẬP KEY
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "FreezeHubKeyGui"
KeyGui.ResetOnSpawn = false
KeyGui.Parent = CoreGui

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 300, 0, 190)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -95)
KeyFrame.BackgroundColor3 = Color3.fromRGB(12, 20, 38)
KeyFrame.BorderSizePixel = 0
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = KeyGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 14)
KeyCorner.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(0, 115, 230)
KeyStroke.Thickness = 2
KeyStroke.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 45)
KeyTitle.BackgroundColor3 = Color3.fromRGB(0, 115, 230)
KeyTitle.Text = "❄️ Nhập Key Freeze Hub ❄️"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.TextSize = 15
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Parent = KeyFrame

local KeyTitleCorner = Instance.new("UICorner")
KeyTitleCorner.CornerRadius = UDim.new(0, 14)
KeyTitleCorner.Parent = KeyTitle

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.85, 0, 0, 42)
KeyBox.Position = UDim2.new(0.075, 0, 0, 60)
KeyBox.BackgroundColor3 = Color3.fromRGB(20, 35, 60)
KeyBox.PlaceholderText = "Nhập key của bạn vào đây..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.PlaceholderColor3 = Color3.fromRGB(140, 170, 200)
KeyBox.TextSize = 13
KeyBox.Font = Enum.Font.Gotham
KeyBox.Parent = KeyFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 8)
BoxCorner.Parent = KeyBox

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.85, 0, 0, 40)
SubmitBtn.Position = UDim2.new(0.075, 0, 0, 115)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
SubmitBtn.Text = "Xác Nhận Key"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.TextSize = 14
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.Parent = KeyFrame

local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 8)
SubmitCorner.Parent = SubmitBtn

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.new(0, 0, 0, 162)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
StatusLabel.TextSize = 12
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = KeyKeyFrame or KeyFrame


-- ==================== 2. HÀM MỞ MENU CHÍNH (ĐÃ TÁCH BIỆT HOÀN TOÀN) ====================
local function launchFreezeHub()
    KeyGui:Destroy()

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FreezeHubGui"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = CoreGui

    -- Nút tròn mở menu ❄️
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

    -- Khung Menu Chính
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 280, 0, 420)
    MainFrame.Position = UDim2.new(0.5, -140, 0.5, -210)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 20, 38)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(0, 115, 230)
    MainStroke.Thickness = 1.5
    MainStroke.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundColor3 = Color3.fromRGB(0, 115, 230)
    Title.Text = "❄️ Freeze Hub ❄️"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 12)
    TitleCorner.Parent = Title

    ToggleButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    -- Hiển thị FPS
    local FPSLabel = Instance.new("TextLabel")
    FPSLabel.Size = UDim2.new(0.9, 0, 0, 35)
    FPSLabel.Position = UDim2.new(0.05, 0, 0, 50)
    FPSLabel.BackgroundColor3 = Color3.fromRGB(18, 30, 52)
    FPSLabel.Text = "FPS: Đang tính..."
    FPSLabel.TextColor3 = Color3.fromRGB(0, 230, 255)
    FPSLabel.TextSize = 13
    FPSLabel.Font = Enum.Font.GothamSemibold
    FPSLabel.Parent = MainFrame

    local FPSCorner = Instance.new("UICorner")
    FPSCorner.CornerRadius = UDim.new(0, 8)
    FPSCorner.Parent = FPSLabel

    -- Hàm tạo nút chức năng tách biệt hoàn toàn
    local function createButton(name, posY)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.9, 0, 0, 45)
        btn.Position = UDim2.new(0.05, 0, 0, posY)
        btn.BackgroundColor3 = Color3.fromRGB(22, 40, 68)
        btn.Text = name .. ": TẮT"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 13
        btn.Font = Enum.Font.GothamSemibold
        btn.Parent = MainFrame

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = btn

        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(40, 75, 120)
        stroke.Thickness = 1.2
        stroke.Parent = btn

        return btn
    end

    local ESPButton = createButton("Định Vị Quái", 95)
    local PlayerESPButton = createButton("Định Vị Người Chơi", 150)
    local HouseESPButton = createButton("Định Vị Nhà", 205)
    local BrightButton = createButton("Sáng Trời Tối", 260)

    local StatusInfo = Instance.new("TextLabel")
    StatusInfo.Size = UDim2.new(0.9, 0, 0, 35)
    StatusInfo.Position = UDim2.new(0.05, 0, 0, 320)
    StatusInfo.BackgroundTransparency = 1
    StatusInfo.Text = "Trạng thái: Đã tách biệt module"
    StatusInfo.TextColor3 = Color3.fromRGB(120, 170, 220)
    StatusInfo.TextSize = 12
    StatusInfo.Font = Enum.Font.GothamItalic
    StatusInfo.Parent = MainFrame

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

    -- ==================== MODULE 1: ĐỊNH VỊ QUÁI ====================
    local espEnabled = false
    local monitoredMonsters = {}
    local ignoredNPCKeywords = {"npc", "shop", "merchant", "quest", "guide", "citizen", "store"}

    local function isNPC(model)
        local nameLower = string.lower(model.Name)
        for _, keyword in ipairs(ignoredNPCKeywords) do
            if string.find(nameLower, keyword) then return true end
        end
        return false
    end

    ESPButton.MouseButton1Click:Connect(function()
        espEnabled = not espEnabled
        if espEnabled then
            ESPButton.Text = "Định Vị Quái: BẬT"
            ESPButton.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj ~= LocalPlayer.Character then
                    if not Players:GetPlayerFromCharacter(obj) and not isNPC(obj) then
                        if not obj:FindFirstChild("MonsterESP") and obj:FindFirstChild("HumanoidRootPart") then
                            local Billboard = Instance.new("BillboardGui")
                            Billboard.Name = "MonsterESP"
                            Billboard.Adornee = obj.HumanoidRootPart
                            Billboard.Size = UDim2.new(0, 150, 0, 50)
                            Billboard.StudsOffset = Vector3.new(0, 3, 0)
                            Billboard.AlwaysOnTop = true
                            Billboard.Parent = obj

                            local TextLabel = Instance.new("TextLabel")
                            TextLabel.Size = UDim2.new(1, 0, 1, 0)
                            TextLabel.BackgroundTransparency = 1
                            TextLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
                            TextLabel.TextStrokeTransparency = 0.5
                            TextLabel.TextSize = 13
                            TextLabel.Font = Enum.Font.GothamBold
                            TextLabel.Text = obj.Name
                            TextLabel.Parent = Billboard

                            table.insert(monitoredMonsters, {Model = obj, Gui = Billboard, Label = TextLabel})
                        end
                    end
                end
            end
        else
            ESPButton.Text = "Định Vị Quái: TẮT"
            ESPButton.BackgroundColor3 = Color3.fromRGB(22, 40, 68)
            for _, data in ipairs(monitoredMonsters) do
                if data.Gui then data.Gui:Destroy() end
            end
            monitoredMonsters = {}
        end
    end)

    RunService.RenderStepped:Connect(function()
        if espEnabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local rootPos = char.HumanoidRootPart.Position
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
        end
    end)

    -- ==================== MODULE 2: ĐỊNH VỊ NGƯỜI CHƠI ====================
    local playerEspEnabled = false
    local monitoredPlayers = {}

    local function setupPlayerESP(plr)
        if plr == LocalPlayer then return end
        local function applyESP(char)
            if not char:FindFirstChild("HumanoidRootPart") then return end
            if char:FindFirstChild("CustomPlayerESP") then return end
            
            local Billboard = Instance.new("BillboardGui")
            Billboard.Name = "CustomPlayerESP"
            Billboard.Adornee = char.HumanoidRootPart
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

            table.insert(monitoredPlayers, {Player = plr, Character = char, Gui = Billboard, Label = TextLabel})
        end

        if plr.Character then applyESP(plr.Character) end
        plr.CharacterAdded:Connect(applyESP)
    end

    PlayerESPButton.MouseButton1Click:Connect(function()
        playerEspEnabled = not playerEspEnabled
        if playerEspEnabled then
            PlayerESPButton.Text = "Định Vị Người Chơi: BẬT"
            PlayerESPButton.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
            for _, p in ipairs(Players:GetPlayers()) do
                setupPlayerESP(p)
            end
        else
            PlayerESPButton.Text = "Định Vị Người Chơi: TẮT"
            PlayerESPButton.BackgroundColor3 = Color3.fromRGB(22, 40, 68)
            for _, data in ipairs(monitoredPlayers) do
                if data.Gui then data.Gui:Destroy() end
            end
            monitoredPlayers = {}
        end
    end)

    RunService.RenderStepped:Connect(function()
        if playerEspEnabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local rootPos = char.HumanoidRootPart.Position
                for i = #monitoredPlayers, 1, -1 do
                    local data = monitoredPlayers[i]
                    if data.Character and data.Character.Parent and data.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = math.floor((data.Character.HumanoidRootPart.Position - rootPos).Magnitude)
                        data.Label.Text = string.format("%s\n[%dm]", data.Player.Name, distance)
                    else
                        if data.Gui then data.Gui:Destroy() end
                        table.remove(monitoredPlayers, i)
                    end
                end
            end
        end
    end)

    -- ==================== MODULE 3: ĐỊNH VỊ NHÀ ====================
    local houseEspEnabled = false
    local homePosition = nil
    local anchorPart = nil
    local houseBillboard = nil
    local houseLabel = nil

    HouseESPButton.MouseButton1Click:Connect(function()
        houseEspEnabled = not houseEspEnabled
        if houseEspEnabled then
            local char = LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then
                houseEspEnabled = false
                return
            end
            HouseESPButton.Text = "Định Vị Nhà: BẬT"
            HouseESPButton.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
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
        else
            HouseESPButton.Text = "Định Vị Nhà: TẮT"
            HouseESPButton.BackgroundColor3 = Color3.fromRGB(22, 40, 68)
            if houseBillboard then houseBillboard:Destroy() houseBillboard = nil end
            if anchorPart then anchorPart:Destroy() anchorPart = nil end
            homePosition = nil
        end
    end)

    RunService.RenderStepped:Connect(function()
        if houseEspEnabled and homePosition and houseLabel then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local distance = math.floor((homePosition - char.HumanoidRootPart.Position).Magnitude)
                houseLabel.Text = string.format("Nhà Của Bạn\n[%dm]", distance)
            end
        end
    end)

    -- ==================== MODULE 4: SÁNG TRỜI TỐI ====================
    local brightEnabled = false

    BrightButton.MouseButton1Click:Connect(function()
        brightEnabled = not brightEnabled
        if brightEnabled then
            BrightButton.Text = "Sáng Trời Tối: BẬT"
            BrightButton.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
            Lighting.Brightness = 3
            Lighting.ClockTime = 14
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") and not char.HumanoidRootPart:FindFirstChild("PlayerLight") then
                local lightSource = Instance.new("PointLight")
                lightSource.Name = "PlayerLight"
                lightSource.Range = 120
                lightSource.Brightness = 5
                lightSource.Parent = char.HumanoidRootPart
            end
        else
            BrightButton.Text = "Sáng Trời Tối: TẮT"
            BrightButton.BackgroundColor3 = Color3.fromRGB(22, 40, 68)
            Lighting.Brightness = 1
            Lighting.GlobalShadows = true
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local light = char.HumanoidRootPart:FindFirstChild("PlayerLight")
                if light then light:Destroy() end
            end
        end
    end)
end

-- Xác thực Key
SubmitBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == MY_SECRET_KEY then
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
        StatusLabel.Text = "Thành công! Đang mở Hub..."
        task.wait(0.4)
        launchFreezeHub()
    else
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        StatusLabel.Text = "Sai Key! Vui lòng nhập lại."
    end
end)
