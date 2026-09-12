-- Tải thư viện Giao diện Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Khởi tạo Menu ⚡ Tuất kỳ hub ⚡
local Window = Rayfield:CreateWindow({
   Name = "⚡ Tuất kỳ hub ⚡",
   LoadingTitle = "Đang tải ⚡ Tuất kỳ hub ⚡...",
   LoadingSubtitle = "by Tuất Kỳ Developer",
   ConfigurationSaving = {
      Enabled = false,
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false,
})

-- Tạo các Tab chức năng
local VisualsTab = Window:CreateTab("👁️ Visuals (Định Vị)", 4483362458)
local MainTab = Window:CreateTab("⚡ Bổ Trợ (Item)", 4483362458)
local DefenseTab = Window:CreateTab("🛡️ Bảo Vệ (Anti)", 4483362458)

-- Biến lưu trạng thái
local ESP_All_Enabled = false
local FastPickup_Enabled = false
local AntiTrap_Enabled = false

-- Lưu trữ danh sách đối tượng vẽ ESP
local ESP_Objects = {}

-- Hàm xóa ESP
local function ClearESP(player)
    if ESP_Objects[player] then
        if ESP_Objects[player].Box then ESP_Objects[player].Box:Remove() end
        if ESP_Objects[player].Tracer then ESP_Objects[player].Tracer:Remove() end
        ESP_Objects[player] = nil
    end
end

-- Hàm tạo nét vẽ Drawing 2D
local function CreateESP(player)
    if player == game.Players.LocalPlayer then return end
    
    local box = Drawing.new("Square")
    box.Color = Color3.fromRGB(255, 0, 0)
    box.Thickness = 2
    box.Filled = false
    box.Visible = false

    local tracer = Drawing.new("Line")
    tracer.Color = Color3.fromRGB(255, 0, 0)
    tracer.Thickness = 1.5
    tracer.Visible = false

    ESP_Objects[player] = {
        Box = box,
        Tracer = tracer
    }
end

for _, plr in pairs(game.Players:GetPlayers()) do
    CreateESP(plr)
end

game.Players.PlayerAdded:Connect(CreateESP)
game.Players.PlayerRemoving:Connect(ClearESP)

-- Vòng lặp chính (RenderStepped) - Định Vị Xa
game:GetService("RunService").RenderStepped:Connect(function()
    local Camera = workspace.CurrentCamera
    local TopScreenPosition = Vector2.new(Camera.ViewportSize.X / 2, 0)

    for player, drawings in pairs(ESP_Objects) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local hrp = player.Character.HumanoidRootPart
            local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)

            if onScreen and ESP_All_Enabled then
                local head = player.Character:FindFirstChild("Head")
                local headPos = head and Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0)) or screenPos
                local legPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                
                local height = math.abs(headPos.Y - legPos.Y)
                local width = height / 1.5

                drawings.Box.Size = Vector2.new(width, height)
                drawings.Box.Position = Vector2.new(screenPos.X - width / 2, screenPos.Y - height / 2)
                drawings.Box.Visible = true

                drawings.Tracer.From = TopScreenPosition
                drawings.Tracer.To = Vector2.new(screenPos.X, screenPos.Y - height / 2)
                drawings.Tracer.Visible = true
            else
                drawings.Box.Visible = false
                drawings.Tracer.Visible = false
            end
        else
            drawings.Box.Visible = false
            drawings.Tracer.Visible = false
        end
    end
end)

-- Vòng lặp Anti Trap Tối Ưu (Fix Lỗi Không Lụm Đồ)
game:GetService("RunService").Heartbeat:Connect(function()
    if AntiTrap_Enabled then
        local lp = game.Players.LocalPlayer
        if lp and lp.Character then
            local char = lp.Character
            local hum = char:FindFirstChildOfClass("Humanoid")
            
            -- 1. Xóa các mối nối bẫy (Weld/Seat) đang giữ nhân vật
            for _, obj in pairs(char:GetDescendants()) do
                if obj:IsA("Weld") or obj:IsA("WeldConstraint") or obj:IsA("Seat") then
                    if obj.Name:lower():find("trap") or obj.Name:lower():find("hold") or obj.Name:lower():find("freeze") then
                        obj:Destroy()
                    end
                end
            end
            
            -- 2. Gỡ bỏ trạng thái kẹt di chuyển nhưng giữ trạng thái tương tác
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") and part.Anchored then
                    part.Anchored = false
                end
            end
            
            -- 3. Khôi phục tự do vận động để lụm vật phẩm mượt mà
            if hum then
                if hum.PlatformStand then hum.PlatformStand = false end
                if hum.Sit then hum.Sit = false end
                if hum.WalkSpeed < 16 then hum.WalkSpeed = 16 end
            end
        end
    end
end)

-- Xử lý 1-Click Nhặt Vật Phẩm (Tối ưu khoảng cách tương tác)
local function OptimizePrompt(prompt)
    if FastPickup_Enabled and prompt:IsA("ProximityPrompt") then
        prompt.HoldDuration = 0
        prompt.RequiresLineOfSight = false -- Nhặt đồ xuyên qua vật cản/bẫy
        prompt.MaxActivationDistance = 25  -- Mở rộng tầm với nhặt đồ
    end
end

game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
    if FastPickup_Enabled then
        fireproximityprompt(prompt)
    end
end)

workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("ProximityPrompt") then
        OptimizePrompt(descendant)
    end
end)

-- Nút điều khiển UI

VisualsTab:CreateSection("Định Vị Tầm Xa")
VisualsTab:CreateToggle({
   Name = "Bật/Tắt Định vị Xa (Khung + Dây Đỏ Mép Trên)",
   CurrentValue = false,
   Flag = "TuatKy_MaxDistance_ESP",
   Callback = function(Value)
      ESP_All_Enabled = Value
   end,
})

MainTab:CreateSection("Tương Tác Vật Phẩm")
MainTab:CreateToggle({
   Name = "Bật 1-Click Nhặt Vật Phẩm (Instant Pickup)",
   CurrentValue = false,
   Flag = "TuatKy_InstantPickup",
   Callback = function(Value)
      FastPickup_Enabled = Value
      if Value then
          for _, prompt in pairs(workspace:GetDescendants()) do
              if prompt:IsA("ProximityPrompt") then
                  OptimizePrompt(prompt)
              end
          end
      end
   end,
})

DefenseTab:CreateSection("Tính Năng Chống Bẫy Cải Tiến")
DefenseTab:CreateToggle({
   Name = "Bật Anti Trap Fix (Vừa Kháng Bẫy Vừa Nhặt Item)",
   CurrentValue = false,
   Flag = "TuatKy_AntiTrap_Fix",
   Callback = function(Value)
      AntiTrap_Enabled = Value
   end,
})

-- Thông báo
Rayfield:Notify({
   Title = "⚡ Tuất kỳ hub ⚡",
   Content = "Đã sửa lỗi Anti Trap! Bây giờ bạn có thể nhặt đồ bình thường khi dính bẫy.",
   Duration = 5,
   Image = 4483362458,
})
