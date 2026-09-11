-- Khởi tạo thư viện Fluent GUI
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Tạo Cửa sổ Menu
local Window = Fluent:CreateWindow({
    Title = "Teleport System",
    SubTitle = "v2.0 Fix Error",
    TabWidth = 150,
    Size = UDim2.fromOffset(480, 320),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Phím Ctrl Trái trên PC để ẩn/hiện menu
})

-- Tạo Tab chính
local Tabs = {
    Main = Window:AddTab({ Title = "Teleport", Icon = "map-pin" })
}

-- Biến lưu tọa độ
local savedCFrame = nil

-- === CHỨC NĂNG CHÍNH ===

Tabs.Main:AddParagraph({
    Title = "Hệ thống Teleport",
    Content = "Lưu vị trí hiện tại và khôi phục khi cần."
})

-- 1. Nút Lưu vị trí
Tabs.Main:AddButton({
    Title = "📌 Lưu vị trí hiện tại",
    Description = "Ghi nhớ tọa độ nhân vật",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            savedCFrame = player.Character.HumanoidRootPart.CFrame
            Fluent:Notify({
                Title = "Thành công",
                Content = "Đã lưu tọa độ hiện tại!",
                Duration = 2.5
            })
        end
    end
})

-- 2. Nút Teleport đi chỗ khác
Tabs.Main:AddButton({
    Title = "🚀 Teleport đi chỗ khác (+50m)",
    Description = "Dịch chuyển lên trên cao 50m",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
            Fluent:Notify({
                Title = "Dịch chuyển",
                Content = "Đã di chuyển tới vị trí mới!",
                Duration = 2
            })
        end
    end
})

-- 3. Nút Teleport quay lại vị trí đã lưu
Tabs.Main:AddButton({
    Title = "🔄 Teleport về vị trí cũ",
    Description = "Dịch chuyển về tọa độ đã lưu",
    Callback = function()
        local player = game.Players.LocalPlayer
        if savedCFrame then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = savedCFrame
                Fluent:Notify({
                    Title = "Thành công",
                    Content = "Đã quay về vị trí ban đầu!",
                    Duration = 2.5
                })
            end
        else
            Fluent:Notify({
                Title = "Cảnh báo",
                Content = "Bạn chưa lưu vị trí nào!",
                Duration = 3
            })
        end
    end
})

Window:SelectTab(1)

-- === PHẦN NÚT NỔI ẨN/HIỆN MENU (FIX LỖI CORE-GUI CHO MOBILE) ===

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Xóa nút cũ nếu đã tồn tại
if playerGui:FindFirstChild("DeltaToggleGui") then
    playerGui.DeltaToggleGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DeltaToggleGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleMenuBtn"
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0, 15, 0.4, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Text = "MENU"
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 14
toggleBtn.Active = true
toggleBtn.Draggable = true -- Có thể kéo di chuyển nút trên màn hình
toggleBtn.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0) -- Nút tròn
corner.Parent = toggleBtn

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 170, 255)
stroke.Thickness = 2
stroke.Parent = toggleBtn

-- Bắt sự kiện bấm nút để Bật / Tắt Menu
toggleBtn.MouseButton1Click:Connect(function()
    Window:Minimize()
end)
