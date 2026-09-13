-- ==========================================================
-- ⚡ TUẤT KỲ HUB ⚡ - ULTRA NEON CYBER EDITION
-- ==========================================================

-- Danh sách URL Scripts (Đã làm sạch lỗi đường dẫn)
local lemonScriptURL   = "https://raw.githubusercontent.com/lennonxscripts/lennonhubv2/refs/heads/main/stealaneggv2"
local mirandaScriptURL = "https://raw.githubusercontent.com/miirandahub/loader/refs/heads/main/stealaeggs"
local rubuScriptURL    = "https://raw.githubusercontent.com/Bubu2k/Rubutv/refs/heads/main/RubuHopSeverlow.lua"

-- Tự động xóa Gui cũ nếu đã tồn tại trước đó
if game:GetService("CoreGui"):FindFirstChild("TuatKyHubGui") then
    game:GetService("CoreGui"):FindFirstChild("TuatKyHubGui"):Destroy()
end

-- Khởi tạo ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TuatKyHubGui"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

------------------------------------------------------------------
-- 1. NÚT TRÒN NỔI (TOGGLE BUTTON) - THIẾT KẾ CYBER NEON VIP
------------------------------------------------------------------
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
ToggleButton.Position = UDim2.new(0, 20, 0.4, 0)
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Font = Enum.Font.FredokaOne
ToggleButton.Text = "⚡\nTUẤT KỲ"
ToggleButton.TextColor3 = Color3.fromRGB(255, 215, 0)
ToggleButton.TextSize = 12.000
ToggleButton.Active = true
ToggleButton.Draggable = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(255, 215, 0)
ToggleStroke.Thickness = 2.5
ToggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ToggleStroke.Parent = ToggleButton

------------------------------------------------------------------
-- 2. KHUNG MENU CHÍNH (MAIN FRAME)
------------------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(16, 17, 24)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -155)
MainFrame.Size = UDim2.new(0, 300, 0, 310)
MainFrame.Active = true
MainFrame.Visible = false -- Mặc định ẩn, bấm nút tròn để bật

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 215, 0)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- Thanh Tiêu Đề
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(25, 27, 38)
Title.Size = UDim2.new(1, 0, 0, 48)
Title.Font = Enum.Font.FredokaOne
Title.Text = "   ⚡ Tuất Kỳ Hub ⚡"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 18.000
Title.TextXAlignment = Enum.TextXAlignment.Left

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 16)
TitleCorner.Parent = Title

-- Nút Tắt Nhanh (X)
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = Title
CloseButton.BackgroundColor3 = Color3.fromRGB(235, 55, 65)
CloseButton.Position = UDim2.new(1, -36, 0, 10)
CloseButton.Size = UDim2.new(0, 28, 0, 28)
CloseButton.Font = Enum.Font.FredokaOne
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14.000

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

------------------------------------------------------------------
-- 3. CÁC NÚT KÍCH HOẠT SCRIPT
------------------------------------------------------------------
-- Nút 1: Lemon Hub
local LemonBtn = Instance.new("TextButton")
LemonBtn.Name = "LemonBtn"
LemonBtn.Parent = MainFrame
LemonBtn.BackgroundColor3 = Color3.fromRGB(35, 165, 90)
LemonBtn.Position = UDim2.new(0.08, 0, 0.20, 0)
LemonBtn.Size = UDim2.new(0.84, 0, 0, 50)
LemonBtn.Font = Enum.Font.SourceSansBold
LemonBtn.Text = "🚀 Lemon Hub V2 (Steal Egg)"
LemonBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LemonBtn.TextSize = 15.000

local LemonCorner = Instance.new("UICorner")
LemonCorner.CornerRadius = UDim.new(0, 10)
LemonCorner.Parent = LemonBtn

-- Nút 2: Miranda Hub
local MirandaBtn = Instance.new("TextButton")
MirandaBtn.Name = "MirandaBtn"
MirandaBtn.Parent = MainFrame
MirandaBtn.BackgroundColor3 = Color3.fromRGB(140, 50, 210)
MirandaBtn.Position = UDim2.new(0.08, 0, 0.44, 0)
MirandaBtn.Size = UDim2.new(0.84, 0, 0, 50)
MirandaBtn.Font = Enum.Font.SourceSansBold
MirandaBtn.Text = "🔮 Miranda Hub (Steal Egg)"
MirandaBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MirandaBtn.TextSize = 15.000

local MirandaCorner = Instance.new("UICorner")
MirandaCorner.CornerRadius = UDim.new(0, 10)
MirandaCorner.Parent = MirandaBtn

-- Nút 3: Rubu Hop Server
local RubuBtn = Instance.new("TextButton")
RubuBtn.Name = "RubuBtn"
RubuBtn.Parent = MainFrame
RubuBtn.BackgroundColor3 = Color3.fromRGB(225, 100, 30)
RubuBtn.Position = UDim2.new(0.08, 0, 0.68, 0)
RubuBtn.Size = UDim2.new(0.84, 0, 0, 50)
RubuBtn.Font = Enum.Font.SourceSansBold
RubuBtn.Text = "🌐 Rubu Hop Server Ít Người"
RubuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RubuBtn.TextSize = 15.000

local RubuCorner = Instance.new("UICorner")
RubuCorner.CornerRadius = UDim.new(0, 10)
RubuCorner.Parent = RubuBtn

------------------------------------------------------------------
-- 4. KÉO THẢ DI CHUYỂN BẢNG MENU
------------------------------------------------------------------
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

------------------------------------------------------------------
-- 5. XỬ LÝ SỰ KIỆN NÚT BẤM & THỰC THI SCRIPT
------------------------------------------------------------------
local function toggleGui()
    MainFrame.Visible = not MainFrame.Visible
end

-- Bật/tắt bằng nút nổi hoặc phím X
ToggleButton.MouseButton1Click:Connect(toggleGui)
CloseButton.MouseButton1Click:Connect(toggleGui)

-- Nhấn phím 'K' trên máy tính để Ẩn/Hiện Menu
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.K then
        toggleGui()
    end
end)

-- Execute Lemon Hub
LemonBtn.MouseButton1Click:Connect(function()
    LemonBtn.Text = "⏳ Đang tải Lemon..."
    local success, err = pcall(function()
        loadstring(game:HttpGet(lemonScriptURL))()
    end)
    if success then
        LemonBtn.Text = "✅ Đã chạy Lemon Hub!"
    else
        LemonBtn.Text = "❌ Lỗi kết nối!"
        warn("Lỗi Lemon Hub:", err)
    end
    task.wait(2)
    LemonBtn.Text = "🚀 Lemon Hub V2 (Steal Egg)"
end)

-- Execute Miranda Hub
MirandaBtn.MouseButton1Click:Connect(function()
    MirandaBtn.Text = "⏳ Đang tải Miranda..."
    local success, err = pcall(function()
        loadstring(game:HttpGet(mirandaScriptURL))()
    end)
    if success then
        MirandaBtn.Text = "✅ Đã chạy Miranda Hub!"
    else
        MirandaBtn.Text = "❌ Lỗi kết nối!"
        warn("Lỗi Miranda Hub:", err)
    end
    task.wait(2)
    MirandaBtn.Text = "🔮 Miranda Hub (Steal Egg)"
end)

-- Execute Rubu Hop Server
RubuBtn.MouseButton1Click:Connect(function()
    RubuBtn.Text = "⏳ Đang chuyển Server..."
    local success, err = pcall(function()
        loadstring(game:HttpGet(rubuScriptURL))()
    end)
    if success then
        RubuBtn.Text = "✅ Đang nhảy Server..."
    else
        RubuBtn.Text = "❌ Lỗi Hop Server!"
        warn("Lỗi Rubu Hop Server:", err)
    end
    task.wait(2)
    RubuBtn.Text = "🌐 Rubu Hop Server Ít Người"
end)
