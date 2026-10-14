-- ======================================================
-- SCRIPT: BREAK AND STEAL AN EGG (V45 - EXTREME SPEED 500)
-- Giao diện: Menu Tab bự, tùy chỉnh tốc độ tối đa lên đến 500 + Xuyên quái
-- ======================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- Xóa GUI cũ nếu đã tồn tại
if game:GetService("CoreGui"):FindFirstChild("EggStealGuiV45") then
    game:GetService("CoreGui").EggStealGuiV45:Destroy()
end

-- 1. ScreenGui Chính
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EggStealGuiV45"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- 2. Nút Tròn Bật/Tắt Menu Nhỏ (📜) - Drag được
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
ToggleBtn.Text = "📜"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 22
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

-- 3. Khung Menu Bự Chính
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 380, 0, 270)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 150, 255)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Header Bar
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 35)
Header.BackgroundColor3 = Color3.fromRGB(28, 28, 40)
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "EGG STEAL HUB - V45 EXTREME SPEED"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -32, 0, 2)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 18
CloseBtn.Parent = Header

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Tab Sidebar (Trái)
local TabSidebar = Instance.new("Frame")
TabSidebar.Size = UDim2.new(0, 110, 1, -45)
TabSidebar.Position = UDim2.new(0, 8, 0, 40)
TabSidebar.BackgroundTransparency = 1
TabSidebar.Parent = MainFrame

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Padding = UDim.new(0, 6)
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Parent = TabSidebar

-- Content Area (Phải)
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -134, 1, -45)
ContentArea.Position = UDim2.new(0, 124, 0, 40)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

local tabs = {}
local tabButtons = {}

local function CreateTab(tabName, icon)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 35)
    TabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    TabBtn.Text = icon .. " " .. tabName
    TabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    TabBtn.Font = Enum.Font.SourceSansBold
    TabBtn.TextSize = 13
    TabBtn.Parent = TabSidebar

    local TabBtnCorner = Instance.new("UICorner")
    TabBtnCorner.CornerRadius = UDim.new(0, 6)
    TabBtnCorner.Parent = TabBtn

    local TabPage = Instance.new("ScrollingFrame")
    TabPage.Size = UDim2.new(1, 0, 1, 0)
    TabPage.BackgroundTransparency = 1
    TabPage.Visible = false
    TabPage.ScrollBarThickness = 3
    TabPage.Parent = ContentArea

    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Padding = UDim.new(0, 8)
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Parent = TabPage

    tabs[tabName] = TabPage
    tabButtons[tabName] = TabBtn

    TabBtn.MouseButton1Click:Connect(function()
        for name, page in pairs(tabs) do
            page.Visible = (name == tabName)
        end
        for name, btn in pairs(tabButtons) do
            if name == tabName then
                btn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            else
                btn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
                btn.TextColor3 = Color3.fromRGB(180, 180, 180)
            end
        end
    end)

    return TabPage
end

local function AddToggle(tabContainer, icon, text, callback)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, -6, 0, 36)
    Row.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
    Row.Parent = tabContainer

    local RowCorner = Instance.new("UICorner")
    RowCorner.CornerRadius = UDim.new(0, 6)
    RowCorner.Parent = Row

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, 130, 1, 0)
    Label.Position = UDim2.new(0, 8, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = icon .. " " .. text
    Label.TextColor3 = Color3.fromRGB(240, 240, 240)
    Label.Font = Enum.Font.SourceSansSemibold
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Row

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 50, 0, 24)
    Btn.Position = UDim2.new(1, -56, 0.5, -12)
    Btn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    Btn.Text = "OFF"
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.SourceSansBold
    Btn.TextSize = 11
    Btn.Parent = Row

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 4)
    BtnCorner.Parent = Btn

    local state = false
    Btn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            Btn.BackgroundColor3 = Color3.fromRGB(40, 180, 80)
            Btn.Text = "ON"
        else
            Btn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
            Btn.Text = "OFF"
        end
        task.spawn(function() callback(state) end)
    end)
end

-- Tạo Tab
local MainTab = CreateTab("Main", "🎯")
local PositionTab = CreateTab("Position", "📍")
local SettingsTab = CreateTab("Settings", "⚙️")

tabs["Main"].Visible = true
tabButtons["Main"].BackgroundColor3 = Color3.fromRGB(0, 120, 255)
tabButtons["Main"].TextColor3 = Color3.fromRGB(255, 255, 255)

-- ======================================================
-- LOGIC TỰ ĐỘNG CHẠY TỐC ĐỘ CAO ĐẾN 500 + XUYÊN QUÁI
-- ======================================================
local savedWalkPosition = nil
local autoWalkActive = false
local runSpeed = 100 -- Mặc định tốc độ cao

local function AddButtonRow(tabContainer, icon, text, btnText, callback)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, -6, 0, 36)
    Row.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
    Row.Parent = tabContainer

    local RowCorner = Instance.new("UICorner")
    RowCorner.CornerRadius = UDim.new(0, 6)
    RowCorner.Parent = Row

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, 130, 1, 0)
    Label.Position = UDim2.new(0, 8, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = icon .. " " .. text
    Label.TextColor3 = Color3.fromRGB(240, 240, 240)
    Label.Font = Enum.Font.SourceSansSemibold
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Row

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 50, 0, 24)
    Btn.Position = UDim2.new(1, -56, 0.5, -12)
    Btn.BackgroundColor3 = Color3.fromRGB(220, 120, 0)
    Btn.Text = btnText
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.SourceSansBold
    Btn.TextSize = 11
    Btn.Parent = Row

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 4)
    BtnCorner.Parent = Btn

    Btn.MouseButton1Click:Connect(function()
        callback(Btn)
    end)
    return Btn
end

-- 1. Nút Set Walk Point
AddButtonRow(PositionTab, "📌", "Set Walk Point", "SET", function()
    pcall(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            savedWalkPosition = char.HumanoidRootPart.Position
        end
    end)
end)

-- 2. Nút Chỉnh Tốc Độ Lên Tới 500 (100 ➔ 250 ➔ 500 ➔ 100)
AddButtonRow(PositionTab, "⚡", "Speed Level", "100", function(btnObj)
    if runSpeed == 100 then
        runSpeed = 250
        btnObj.Text = "250 (Super)"
        btnObj.BackgroundColor3 = Color3.fromRGB(220, 80, 0)
    elseif runSpeed == 250 then
        runSpeed = 500
        btnObj.Text = "500 (Turbo)"
        btnObj.BackgroundColor3 = Color3.fromRGB(220, 30, 30)
    else
        runSpeed = 100
        btnObj.Text = "100 (Fast)"
        btnObj.BackgroundColor3 = Color3.fromRGB(220, 120, 0)
    end
end)

-- Vòng lặp di chuyển tốc độ cực đại + xuyên mọi quái vật/NPC
RunService.Heartbeat:Connect(function()
    if not autoWalkActive then return end
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not humanoid or not hrp then return end

        -- Xuyên qua quái vật & chướng ngại vật tuyệt đối
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end

        if not savedWalkPosition then
            savedWalkPosition = hrp.Position
        end

        local currentPos = hrp.Position
        local targetPos = Vector3.new(savedWalkPosition.X, currentPos.Y, savedWalkPosition.Z)
        local distance = (targetPos - currentPos).Magnitude

        if distance > 2.5 then
            local direction = (targetPos - currentPos).Unit
            hrp.AssemblyLinearVelocity = Vector3.new(direction.X * runSpeed, hrp.AssemblyLinearVelocity.Y, direction.Z * runSpeed)
            humanoid:MoveTo(targetPos)
        end
    end)
end)

-- ======================================================
-- TAB MAIN: NO DROP & AUTO STEAL & AUTO WALK BACK
-- ======================================================
local noDropActive = false
AddToggle(MainTab, "🛡️", "No Drop", function(state)
    noDropActive = state
end)

RunService.Heartbeat:Connect(function()
    if not noDropActive then return end
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local vel = hrp.AssemblyLinearVelocity
            if math.abs(vel.X) > 45 or math.abs(vel.Z) > 45 then
                hrp.AssemblyLinearVelocity = Vector3.new(0, vel.Y, 0)
            end
        end
    end)
end)

AddToggle(MainTab, "🏃", "Extreme Walk Back", function(state)
    autoWalkActive = state
    if state then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") and not savedWalkPosition then
                savedWalkPosition = char.HumanoidRootPart.Position
            end
        end)
    end
end)

local function IsValidPetOrDrop(obj)
    if obj:IsA("Model") and obj:FindFirstChildOfClass("Humanoid") then return false end
    local ancestorModel = obj:FindFirstAncestorOfClass("Model")
    if ancestorModel and ancestorModel:FindFirstChildOfClass("Humanoid") then return false end

    local name = obj.Name:lower()
    local blacklist = {"mob", "enemy", "monster", "guard", "boss", "npc", "shop", "merge", "craft", "upgrade", "machine"}
    for _, word in ipairs(blacklist) do
        if name:find(word) then return false end
    end
    return true
end

local stealActive = false
local function AutoStealRoutine()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, obj in pairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and IsValidPetOrDrop(obj) then
            local part = obj:IsA("BasePart") and obj or (obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart"))
            
            if part and part.Anchored == false and not part:IsDescendantOf(workspace.CurrentCamera) then
                local dist = (part.Position - hrp.Position).Magnitude
                if dist <= 55 then
                    if part:FindFirstChild("TouchInterest") then
                        firetouchinterest(hrp, part, 0)
                        firetouchinterest(hrp, part, 1)
                    end
                end
            end
        end

        if obj:IsA("ProximityPrompt") then
            local val = obj.Parent
            if val and IsValidPetOrDrop(val) then
                local promptPart = val:IsA("BasePart") and val or val:FindFirstChildWhichIsA("BasePart")
                if promptPart and (promptPart.Position - hrp.Position).Magnitude <= 20 then
                    obj.HoldDuration = 0
                    fireproximityprompt(obj)
                end
            end
        end
    end
end

AddToggle(MainTab, "🚀", "Auto Steal", function(state)
    stealActive = state
    while stealActive do
        pcall(AutoStealRoutine)
        task.wait(0.12)
    end
end)

-- ======================================================
-- TAB SETTINGS: FIX LAG GIẤC CHIỀU (SUNSET)
-- ======================================================
AddToggle(SettingsTab, "🌅", "Fix Lag Sunset", function(state)
    pcall(function()
        if state then
            Lighting.ClockTime = 18.5
            Lighting.Brightness = 1.5
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(220, 150, 120)
            for _, v in pairs(Lighting:GetChildren()) do
                if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then
                    v.Enabled = false
                end
            end
        else
            Lighting.ClockTime = 14
            Lighting.Brightness = 2
            Lighting.GlobalShadows = true
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            for _, v in pairs(Lighting:GetChildren()) do
                if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then
                    v.Enabled = true
                end
            end
        end
    end)
end)
