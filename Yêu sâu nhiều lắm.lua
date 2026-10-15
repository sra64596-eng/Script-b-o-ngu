-- Delta Executor Script: ⚡ Gemini hub ⚡ (Exclusive Noclip & Super Jump Logic)
-- Theme: Deep Dark with Neon Purple Border (Slight Corner Radius)
-- Features: FPS Counter, Multi-Language Toggle (VI / EN), Mutual Exclusive Noclip & Super Jump, ESP Players, Anti Ragdoll

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Global Toggle States & Language
_G.NoclipEnabled = false
_G.EspPlayersEnabled = false
_G.AntiRagdollEnabled = false
_G.SuperJumpEnabled = false
_G.LanguageVI = true -- Mặc định tiếng Việt (true = VI, false = EN)

local noclipConn = nil
local antiRagdollConn = nil
local superJumpConn = nil
local playerHighlights = {}

-- Clean Old GUI Instance
if CoreGui:FindFirstChild("GeminiHub") then
    CoreGui.GeminiHub:Destroy()
end

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GeminiHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Main Compact Frame (Deep Dark Background + Neon Purple Border)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 230, 0, 250)
MainFrame.Active = true
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 3) -- Bo nhẹ góc
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = MainFrame
MainStroke.Color = Color3.fromRGB(150, 0, 255) -- Viền Tím Neon
MainStroke.Thickness = 2
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Title Bar (Header)
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(18, 15, 25)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 30)

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 8, 0, 0)
TitleText.Size = UDim2.new(0.68, 0, 1, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "⚡ Gemini hub ⚡ | FPS: 60"
TitleText.TextColor3 = Color3.fromRGB(200, 120, 255)
TitleText.TextSize = 10
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- Language Switch Button
local LangBtn = Instance.new("TextButton")
LangBtn.Name = "LangBtn"
LangBtn.Parent = TitleBar
LangBtn.BackgroundColor3 = Color3.fromRGB(35, 25, 50)
LangBtn.Position = UDim2.new(0.72, 0, 0.15, 0)
LangBtn.Size = UDim2.new(0, 58, 0, 20)
LangBtn.Font = Enum.Font.GothamBold
LangBtn.Text = "Lang: VI"
LangBtn.TextColor3 = Color3.fromRGB(255, 200, 100)
LangBtn.TextSize = 10

local LangCorner = Instance.new("UICorner")
LangCorner.CornerRadius = UDim.new(0, 3)
LangCorner.Parent = LangBtn

-- References for Buttons
local NoclipBtn = Instance.new("TextButton")
local EspPlayersBtn = Instance.new("TextButton")
local SuperJumpBtn = Instance.new("TextButton")
local RagdollBtn = Instance.new("TextButton")

-- Function to Update UI Text & States Dynamic
local function updateLanguageUI()
    if _G.LanguageVI then
        LangBtn.Text = "Lang: VI"
        NoclipBtn.Text = _G.NoclipEnabled and "Đi xuyên tường: BẬT" or "Đi xuyên tường: TẮT"
        EspPlayersBtn.Text = _G.EspPlayersEnabled and "ESP Người chơi: BẬT" or "ESP Người chơi: TẮT"
        SuperJumpBtn.Text = _G.SuperJumpEnabled and "Nhảy cao: BẬT" or "Nhảy cao: TẮT"
        RagdollBtn.Text = _G.AntiRagdollEnabled and "Chống văng: BẬT" or "Chống văng: TẮT"
    else
        LangBtn.Text = "Lang: EN"
        NoclipBtn.Text = _G.NoclipEnabled and "Noclip: ON" or "Noclip: OFF"
        EspPlayersBtn.Text = _G.EspPlayersEnabled and "ESP Players: ON" or "ESP Players: OFF"
        SuperJumpBtn.Text = _G.SuperJumpEnabled and "Super Jump: ON" or "Super Jump: OFF"
        RagdollBtn.Text = _G.AntiRagdollEnabled and "Anti Ragdoll: ON" or "Anti Ragdoll: OFF"
    end
end

LangBtn.MouseButton1Click:Connect(function()
    _G.LanguageVI = not _G.LanguageVI
    updateLanguageUI()
end)

-- Calculate FPS Live
local frameCount = 0
local lastUpdate = tick()
RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    if tick() - lastUpdate >= 1 then
        TitleText.Text = "⚡ Gemini hub ⚡ | FPS: " .. tostring(frameCount)
        frameCount = 0
        lastUpdate = tick()
    end
end)

-- Hàm tắt Super Jump
local function disableSuperJump()
    _G.SuperJumpEnabled = false
    SuperJumpBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    SuperJumpBtn.BackgroundColor3 = Color3.fromRGB(20, 18, 28)
    if superJumpConn then
        superJumpConn:Disconnect()
        superJumpConn = nil
    end
    if LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            pcall(function()
                humanoid.JumpPower = 50
            end)
        end
    end
end

-- Button 1: Noclip (Tự động tắt Super Jump nếu đang bật)
NoclipBtn.Name = "NoclipBtn"
NoclipBtn.Parent = MainFrame
NoclipBtn.BackgroundColor3 = Color3.fromRGB(20, 18, 28)
NoclipBtn.Position = UDim2.new(0.06, 0, 0.16, 0)
NoclipBtn.Size = UDim2.new(0.88, 0, 0, 32)
NoclipBtn.Font = Enum.Font.GothamSemibold
NoclipBtn.Text = "Noclip: OFF"
NoclipBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
NoclipBtn.TextSize = 12

local Btn1Corner = Instance.new("UICorner")
Btn1Corner.CornerRadius = UDim.new(0, 3)
Btn1Corner.Parent = NoclipBtn

NoclipBtn.MouseButton1Click:Connect(function()
    _G.NoclipEnabled = not _G.NoclipEnabled
    if _G.NoclipEnabled then
        -- Khi bật Noclip, tự động ép tắt Super Jump
        disableSuperJump()
        
        NoclipBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
        NoclipBtn.BackgroundColor3 = Color3.fromRGB(35, 15, 55)
        if not noclipConn then
            noclipConn = RunService.Stepped:Connect(function()
                if LocalPlayer.Character then
                    for _, p in pairs(LocalPlayer.Character:GetDescendants()) do
                        if p:IsA("BasePart") then p.CanCollide = false end
                    end
                end
            end)
        end
    else
        NoclipBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        NoclipBtn.BackgroundColor3 = Color3.fromRGB(20, 18, 28)
        if noclipConn then
            noclipConn:Disconnect()
            noclipConn = nil
        end
    end
    updateLanguageUI()
end)

-- Button 2: ESP Players
EspPlayersBtn.Name = "EspPlayersBtn"
EspPlayersBtn.Parent = MainFrame
EspPlayersBtn.BackgroundColor3 = Color3.fromRGB(20, 18, 28)
EspPlayersBtn.Position = UDim2.new(0.06, 0, 0.37, 0)
EspPlayersBtn.Size = UDim2.new(0.88, 0, 0, 32)
EspPlayersBtn.Font = Enum.Font.GothamSemibold
EspPlayersBtn.Text = "ESP Players: OFF"
EspPlayersBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
EspPlayersBtn.TextSize = 12

local Btn2Corner = Instance.new("UICorner")
Btn2Corner.CornerRadius = UDim.new(0, 3)
Btn2Corner.Parent = EspPlayersBtn

local function clearPlayerHighlights()
    for _, item in pairs(playerHighlights) do
        if item.Highlight then item.Highlight:Destroy() end
        if item.Billboard then item.Billboard:Destroy() end
    end
    playerHighlights = {}
end

local function setupPlayer(plr)
    if plr == LocalPlayer then return end
    
    local function applyVisuals(char)
        if not char then return end
        
        if playerHighlights[plr] then
            if playerHighlights[plr].Highlight then playerHighlights[plr].Highlight:Destroy() end
            if playerHighlights[plr].Billboard then playerHighlights[plr].Billboard:Destroy() end
        end
        
        local hl = Instance.new("Highlight")
        hl.Name = "PlayerOutline"
        hl.Adornee = char
        hl.FillTransparency = 1
        hl.OutlineColor = Color3.fromRGB(150, 0, 255)
        hl.OutlineTransparency = 0
        hl.Parent = char
        
        local head = char:WaitForChild("Head", 5)
        if head then
            local bb = Instance.new("BillboardGui")
            bb.Name = "RainbowNameTag"
            bb.Adornee = head
            bb.Size = UDim2.new(0, 100, 0, 40)
            bb.StudsOffset = Vector3.new(0, 2, 0)
            bb.AlwaysOnTop = true
            bb.Parent = char
            
            local txt = Instance.new("TextLabel")
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.BackgroundTransparency = 1
            txt.Font = Enum.Font.GothamBold
            txt.TextSize = 14
            txt.TextStrokeTransparency = 0
            txt.Text = plr.Name
            txt.Parent = bb
            
            playerHighlights[plr] = {Highlight = hl, Billboard = bb, TextLabel = txt}
        end
    end
    
    plr.CharacterAdded:Connect(applyVisuals)
    if plr.Character then
        task.spawn(function() applyVisuals(plr.Character) end)
    end
end

local playerOutlineConn = nil
local function startPlayerOutlineLoop()
    if playerOutlineConn then playerOutlineConn:Disconnect() end
    
    playerOutlineConn = RunService.RenderStepped:Connect(function()
        if not _G.EspPlayersEnabled then return end
        
        local hue = (tick() % 3) / 3
        local rainbowColor = Color3.fromHSV(hue, 1, 1)
        
        for plr, data in pairs(playerHighlights) do
            if data.Highlight and data.Highlight.Parent then
                data.Highlight.OutlineColor = rainbowColor
            end
            if data.TextLabel and data.TextLabel.Parent then
                data.TextLabel.TextColor3 = rainbowColor
            end
        end
    end)
end

EspPlayersBtn.MouseButton1Click:Connect(function()
    _G.EspPlayersEnabled = not _G.EspPlayersEnabled
    if _G.EspPlayersEnabled then
        EspPlayersBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
        EspPlayersBtn.BackgroundColor3 = Color3.fromRGB(35, 15, 55)
        
        for _, plr in pairs(Players:GetPlayers()) do
            setupPlayer(plr)
        end
        startPlayerOutlineLoop()
    else
        EspPlayersBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        EspPlayersBtn.BackgroundColor3 = Color3.fromRGB(20, 18, 28)
        
        if playerOutlineConn then
            playerOutlineConn:Disconnect()
            playerOutlineConn = nil
        end
        clearPlayerHighlights()
    end
    updateLanguageUI()
end)

Players.PlayerAdded:Connect(function(plr)
    if _G.EspPlayersEnabled then
        setupPlayer(plr)
    end
end)

-- Button 3: Super Jump (Khóa không cho bật nếu Noclip đang hoạt động)
SuperJumpBtn.Name = "SuperJumpBtn"
SuperJumpBtn.Parent = MainFrame
SuperJumpBtn.BackgroundColor3 = Color3.fromRGB(20, 18, 28)
SuperJumpBtn.Position = UDim2.new(0.06, 0, 0.58, 0)
SuperJumpBtn.Size = UDim2.new(0.88, 0, 0, 32)
SuperJumpBtn.Font = Enum.Font.GothamSemibold
SuperJumpBtn.Text = "Super Jump: OFF"
SuperJumpBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
SuperJumpBtn.TextSize = 12

local Btn3Corner = Instance.new("UICorner")
Btn3Corner.CornerRadius = UDim.new(0, 3)
Btn3Corner.Parent = SuperJumpBtn

SuperJumpBtn.MouseButton1Click:Connect(function()
    -- Nếu Noclip đang BẬT, chặn không cho bật Super Jump
    if _G.NoclipEnabled then
        return
    end

    _G.SuperJumpEnabled = not _G.SuperJumpEnabled
    if _G.SuperJumpEnabled then
        SuperJumpBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
        SuperJumpBtn.BackgroundColor3 = Color3.fromRGB(35, 15, 55)
        
        if not superJumpConn then
            superJumpConn = RunService.Heartbeat:Connect(function()
                if _G.SuperJumpEnabled and LocalPlayer.Character then
                    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        pcall(function()
                            humanoid.UseJumpPower = true
                            humanoid.JumpPower = 120 
                        end)
                    end
                end
            end)
        end
    else
        disableSuperJump()
    end
    updateLanguageUI()
end)

-- Button 4: Anti Ragdoll
RagdollBtn.Name = "RagdollBtn"
RagdollBtn.Parent = MainFrame
RagdollBtn.BackgroundColor3 = Color3.fromRGB(20, 18, 28)
RagdollBtn.Position = UDim2.new(0.06, 0, 0.79, 0)
RagdollBtn.Size = UDim2.new(0.88, 0, 0, 32)
RagdollBtn.Font = Enum.Font.GothamSemibold
RagdollBtn.Text = "Anti Ragdoll: OFF"
RagdollBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
RagdollBtn.TextSize = 12

local Btn4Corner = Instance.new("UICorner")
Btn4Corner.CornerRadius = UDim.new(0, 3)
Btn4Corner.Parent = RagdollBtn

RagdollBtn.MouseButton1Click:Connect(function()
    _G.AntiRagdollEnabled = not _G.AntiRagdollEnabled
    if _G.AntiRagdollEnabled then
        RagdollBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
        RagdollBtn.BackgroundColor3 = Color3.fromRGB(35, 15, 55)
        
        if not antiRagdollConn then
            antiRagdollConn = RunService.Heartbeat:Connect(function()
                if _G.AntiRagdollEnabled and LocalPlayer.Character then
                    local char = LocalPlayer.Character
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    
                    if hrp then
                        local currentVelocity = hrp.AssemblyLinearVelocity
                        if math.abs(currentVelocity.X) > 25 or math.abs(currentVelocity.Z) > 25 then
                            hrp.AssemblyLinearVelocity = Vector3.new(0, currentVelocity.Y, 0)
                        end
                    end
                    
                    if humanoid then
                        pcall(function()
                            humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                            humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                        end)
                    end
                end
            end)
        end
    else
        RagdollBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        RagdollBtn.BackgroundColor3 = Color3.fromRGB(20, 18, 28)
        
        if antiRagdollConn then
            antiRagdollConn:Disconnect()
            antiRagdollConn = nil
        end
        
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                pcall(function()
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                end)
            end
        end
    end
    updateLanguageUI()
end)

-- Khởi chạy giao diện ngôn ngữ ban đầu
updateLanguageUI()

-- Main Frame Dragging Logic
local dragging, dragInput, dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

RunService.RenderStepped:Connect(function()
    if dragging and dragInput then
        local delta = dragInput.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Floating HUB Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "HUBButton"
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(12, 10, 18)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
ToggleBtn.Size = UDim2.new(0, 42, 0, 42)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "HUB"
ToggleBtn.TextColor3 = Color3.fromRGB(200, 100, 255)
ToggleBtn.TextSize = 12
ToggleBtn.Active = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 4)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Parent = ToggleBtn
ToggleStroke.Color = Color3.fromRGB(150, 0, 255)
ToggleStroke.Thickness = 1.5

-- Dragging HUB Button
local btnDragging, btnDragInput, btnDragStart, btnStartPos

ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        btnDragging = true
        btnDragStart = input.Position
        btnStartPos = ToggleBtn.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                btnDragging = false
            end
        end)
    end
end)

ToggleBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        btnDragInput = input
    end
end)

RunService.RenderStepped:Connect(function()
    if btnDragging and btnDragInput then
        local delta = btnDragInput.Position - btnDragStart
        ToggleBtn.Position = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X, btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y)
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

print("⚡ Gemini hub ⚡ Loaded Successfully!")
