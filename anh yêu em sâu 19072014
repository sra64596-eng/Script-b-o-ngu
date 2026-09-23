local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ----------------------------------------------------
-- 🛡️ [ANTI-BAN / BYPASS MODULE]
-- ----------------------------------------------------
pcall(function()
	local gmt = getrawmetatable(game)
	if setreadonly then setreadonly(gmt, false) else make_writeable(gmt) end

	local oldNamecall = gmt.__namecall
	local oldIndex = gmt.__index

	gmt.__namecall = newcclosure(function(self, ...)
		local method = getnamecallmethod()
		if not checkcaller() and (method == "Kick" or method == "kick") then
			return nil
		end
		return oldNamecall(self, ...)
	end)

	gmt.__index = newcclosure(function(self, key)
		if not checkcaller() and self:IsA("Humanoid") and (key == "WalkSpeed" or key == "walkSpeed" or key == "SwimSpeed") then
			return 16
		end
		return oldIndex(self, key)
	end)

	if setreadonly then setreadonly(gmt, true) else make_readonly(gmt) end
end)

-- ----------------------------------------------------
-- ⚙️ TRẠNG THÁI TOÀN CỤC & THEME
-- ----------------------------------------------------
local MenuVisible = true
local ESP_Enabled = false
local Speed_Enabled = false
local MaxDistance = 1500

local DEFAULT_SPEED = 16
local BOOST_SPEED = 120 -- Tốc độ di chuyển tăng cường

local TerritoryList = {}
local CurrentTerritoryIndex = 0

local MeatList = {}
local CurrentMeatIndex = 0

local WaterList = {}
local CurrentWaterIndex = 0

local THEME = {
	PrimaryBtn = Color3.fromRGB(0, 160, 180),
	ActiveBtn = Color3.fromRGB(0, 210, 160),
	Background = Color3.fromRGB(15, 18, 24),
	CardBG = Color3.fromRGB(24, 28, 36),
	Stroke = Color3.fromRGB(0, 220, 200),
	TextMain = Color3.fromRGB(240, 250, 255),
	TextSub = Color3.fromRGB(0, 220, 200)
}

-- ----------------------------------------------------
-- 1. GIAO DIỆN MENU CHÍNH
-- ----------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PrimevalMenu_V13_WaterFix"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 240, 0, 360)
MainFrame.Position = UDim2.new(0.02, 0, 0.2, 0)
MainFrame.BackgroundColor3 = THEME.Background
MainFrame.BackgroundTransparency = 0.1
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = MenuVisible
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 8)

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = THEME.Stroke
UIStroke.Thickness = 1.5

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.8, 0, 0, 30)
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.Text = "🦖 PRIMEVAL MENU V13"
Title.TextColor3 = THEME.TextMain
Title.TextSize = 13
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.Position = UDim2.new(0.87, 0, 0.02, 0)
MinimizeBtn.Text = "-"
MinimizeBtn.TextSize = 18
MinimizeBtn.TextColor3 = THEME.TextMain
MinimizeBtn.BackgroundColor3 = THEME.CardBG
MinimizeBtn.Parent = MainFrame

local MinCorner = Instance.new("UICorner", MinimizeBtn)
MinCorner.CornerRadius = UDim.new(0, 4)

local OpenMenuBtn = Instance.new("TextButton")
OpenMenuBtn.Size = UDim2.new(0, 95, 0, 30)
OpenMenuBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
OpenMenuBtn.Text = "🦖 MENU [M]"
OpenMenuBtn.TextSize = 12
OpenMenuBtn.Font = Enum.Font.SourceSansBold
OpenMenuBtn.BackgroundColor3 = THEME.PrimaryBtn
OpenMenuBtn.TextColor3 = THEME.TextMain
OpenMenuBtn.Visible = not MenuVisible
OpenMenuBtn.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner", OpenMenuBtn)
OpenCorner.CornerRadius = UDim.new(0, 6)

local function SetMenuState(visible)
	MenuVisible = visible
	MainFrame.Visible = MenuVisible
	OpenMenuBtn.Visible = not MenuVisible
end

MinimizeBtn.MouseButton1Click:Connect(function() SetMenuState(false) end)
OpenMenuBtn.MouseButton1Click:Connect(function() SetMenuState(true) end)

-- ----------------------------------------------------
-- 2. CHỨC NĂNG CHẠY & BƠI NHANH (FIX TRIỆT ĐỂ BƠI NƯỚC)
-- ----------------------------------------------------
local SpeedToggleBtn = Instance.new("TextButton")
SpeedToggleBtn.Size = UDim2.new(0.9, 0, 0, 28)
SpeedToggleBtn.Position = UDim2.new(0.05, 0, 0.12, 0)
SpeedToggleBtn.Font = Enum.Font.SourceSansBold
SpeedToggleBtn.TextSize = 11
SpeedToggleBtn.Parent = MainFrame

local SpeedCorner = Instance.new("UICorner", SpeedToggleBtn)
SpeedCorner.CornerRadius = UDim.new(0, 5)

local function UpdateSpeedVisual()
	if Speed_Enabled then
		SpeedToggleBtn.Text = "⚡ CHẠY / BƠI NHANH: [ BẬT ]"
		SpeedToggleBtn.BackgroundColor3 = THEME.ActiveBtn
		SpeedToggleBtn.TextColor3 = Color3.fromRGB(15, 18, 24)
	else
		SpeedToggleBtn.Text = "⚡ CHẠY / BƠI NHANH: [ TẮT ]"
		SpeedToggleBtn.BackgroundColor3 = THEME.PrimaryBtn
		SpeedToggleBtn.TextColor3 = THEME.TextMain
	end
end

UpdateSpeedVisual()
SpeedToggleBtn.MouseButton1Click:Connect(function()
	Speed_Enabled = not Speed_Enabled
	UpdateSpeedVisual()
end)

-- Tạo BodyVelocity hỗ trợ đẩy khi bơi
local bodyVel = Instance.new("BodyVelocity")
bodyVel.MaxForce = Vector3.new(0, 0, 0)
bodyVel.Velocity = Vector3.zero

RunService.RenderStepped:Connect(function()
	pcall(function()
		local char = LocalPlayer.Character
		if not char then return end
		local hum = char:FindFirstChildOfClass("Humanoid")
		local hrp = char:FindFirstChild("HumanoidRootPart")

		if hum and hrp then
			if Speed_Enabled then
				hum.WalkSpeed = BOOST_SPEED
				pcall(function() hum.SwimSpeed = BOOST_SPEED end)

				-- Nếu nhân vật đang ở dưới nước / bơi
				if hum:GetState() == Enum.HumanoidStateType.Swimming or hrp.Velocity.Y ~= 0 then
					if hum.MoveDirection.Magnitude > 0 then
						bodyVel.Parent = hrp
						bodyVel.MaxForce = Vector3.new(1e5, 0, 1e5)
						bodyVel.Velocity = hum.MoveDirection * BOOST_SPEED
					else
						bodyVel.MaxForce = Vector3.zero
					end
				else
					bodyVel.MaxForce = Vector3.zero
				end
			else
				hum.WalkSpeed = DEFAULT_SPEED
				bodyVel.MaxForce = Vector3.zero
			end
		end
	end)
end)

-- ----------------------------------------------------
-- 3. HÀM DỊCH CHUYỂN AN TOÀN
-- ----------------------------------------------------
local function SmoothTeleport(targetCFrame)
	local char = LocalPlayer.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	local hrp = char.HumanoidRootPart

	hrp.AssemblyLinearVelocity = Vector3.zero
	hrp.AssemblyAngularVelocity = Vector3.zero

	local startCFrame = hrp.CFrame
	local distance = (targetCFrame.Position - startCFrame.Position).Magnitude
	
	if distance > 150 then
		local steps = math.clamp(math.floor(distance / 100), 2, 5)
		for i = 1, steps do
			hrp.CFrame = startCFrame:Lerp(targetCFrame, i / steps)
			task.wait(0.03)
		end
	else
		hrp.CFrame = targetCFrame
	end
end

local function SafeTeleportTo(targetPosition)
	SmoothTeleport(CFrame.new(targetPosition + Vector3.new(0, 3, 0)))
end

local function TeleportToWaterSurface(targetPosition)
	SmoothTeleport(CFrame.new(targetPosition + Vector3.new(0, 1.5, 0)))
end

-- ----------------------------------------------------
-- 4. TELEPORT LÃNH ĐỊA
-- ----------------------------------------------------
local TeleportBtn = Instance.new("TextButton")
TeleportBtn.Size = UDim2.new(0.9, 0, 0, 28)
TeleportBtn.Position = UDim2.new(0.05, 0, 0.23, 0)
TeleportBtn.Text = "🚩 TELEPORT LÃNH ĐỊA"
TeleportBtn.Font = Enum.Font.SourceSansBold
TeleportBtn.TextSize = 11
TeleportBtn.BackgroundColor3 = THEME.PrimaryBtn
TeleportBtn.TextColor3 = THEME.TextMain
TeleportBtn.Parent = MainFrame

local TeleCorner = Instance.new("UICorner", TeleportBtn)
TeleCorner.CornerRadius = UDim.new(0, 5)

local function RefreshTerritories()
	TerritoryList = {}
	for _, obj in pairs(workspace:GetDescendants()) do
		local nameLower = obj.Name:lower()
		if (nameLower:find("territory") or nameLower:find("zone") or nameLower:find("flag") or nameLower:find("claim") or nameLower:find("lanhdia")) then
			if obj:IsA("BasePart") then
				table.insert(TerritoryList, obj.Position)
			elseif obj:IsA("Model") and obj.PrimaryPart then
				table.insert(TerritoryList, obj.PrimaryPart.Position)
			end
		end
	end
end

TeleportBtn.MouseButton1Click:Connect(function()
	pcall(function()
		if #TerritoryList == 0 then RefreshTerritories() end
		if #TerritoryList > 0 then
			CurrentTerritoryIndex = CurrentTerritoryIndex + 1
			if CurrentTerritoryIndex > #TerritoryList then CurrentTerritoryIndex = 1 end
			TeleportBtn.Text = string.format("🚩 LÃNH ĐỊA (%d/%d)", CurrentTerritoryIndex, #TerritoryList)
			SafeTeleportTo(TerritoryList[CurrentTerritoryIndex])
		end
	end)
end)

-- ----------------------------------------------------
-- 5. TELEPORT ĐẾN THỊT
-- ----------------------------------------------------
local TeleMeatBtn = Instance.new("TextButton")
TeleMeatBtn.Size = UDim2.new(0.9, 0, 0, 28)
TeleMeatBtn.Position = UDim2.new(0.05, 0, 0.34, 0)
TeleMeatBtn.Text = "🥩 TELEPORT ĐẾN THỊT"
TeleMeatBtn.Font = Enum.Font.SourceSansBold
TeleMeatBtn.TextSize = 11
TeleMeatBtn.BackgroundColor3 = THEME.PrimaryBtn
TeleMeatBtn.TextColor3 = THEME.TextMain
TeleMeatBtn.Parent = MainFrame

local MeatCorner = Instance.new("UICorner", TeleMeatBtn)
MeatCorner.CornerRadius = UDim.new(0, 5)

local function RefreshMeatList()
	MeatList = {}
	for _, obj in pairs(workspace:GetDescendants()) do
		local nameLower = obj.Name:lower()
		if (nameLower:find("meat") or nameLower:find("carcass") or nameLower:find("food") or nameLower:find("thit") or nameLower:find("flesh") or nameLower:find("corpse")) then
			if obj:IsA("BasePart") then
				table.insert(MeatList, obj.Position)
			elseif obj:IsA("Model") and obj.PrimaryPart then
				table.insert(MeatList, obj.PrimaryPart.Position)
			elseif obj:IsA("Model") and obj:FindFirstChildWhichIsA("BasePart") then
				table.insert(MeatList, obj:FindFirstChildWhichIsA("BasePart").Position)
			end
		end
	end
end

TeleMeatBtn.MouseButton1Click:Connect(function()
	pcall(function()
		RefreshMeatList()
		if #MeatList > 0 then
			CurrentMeatIndex = CurrentMeatIndex + 1
			if CurrentMeatIndex > #MeatList then CurrentMeatIndex = 1 end
			TeleMeatBtn.Text = string.format("🥩 NGUỒN THỊT (%d/%d)", CurrentMeatIndex, #MeatList)
			SafeTeleportTo(MeatList[CurrentMeatIndex])
		else
			TeleMeatBtn.Text = "🥩 KHÔNG TÌM THẤY THỊT!"
			task.wait(1.5)
			TeleMeatBtn.Text = "🥩 TELEPORT ĐẾN THỊT"
		end
	end)
end)

-- ----------------------------------------------------
-- 6. TELEPORT ĐẾN MẶT NƯỚC (ĐỂ UỐNG NƯỚC)
-- ----------------------------------------------------
local TeleWaterBtn = Instance.new("TextButton")
TeleWaterBtn.Size = UDim2.new(0.9, 0, 0, 28)
TeleWaterBtn.Position = UDim2.new(0.05, 0, 0.45, 0)
TeleWaterBtn.Text = "💧 TELEPORT MẶT NƯỚC (UỐNG)"
TeleWaterBtn.Font = Enum.Font.SourceSansBold
TeleWaterBtn.TextSize = 11
TeleWaterBtn.BackgroundColor3 = THEME.PrimaryBtn
TeleWaterBtn.TextColor3 = THEME.TextMain
TeleWaterBtn.Parent = MainFrame

local WaterCorner = Instance.new("UICorner", TeleWaterBtn)
WaterCorner.CornerRadius = UDim.new(0, 5)

local function RefreshWaterList()
	WaterList = {}
	for _, obj in pairs(workspace:GetDescendants()) do
		local nameLower = obj.Name:lower()
		if (nameLower:find("water") or nameLower:find("lake") or nameLower:find("river") or nameLower:find("pond") or nameLower:find("suoi") or nameLower:find("nuoc") or nameLower:find("drink")) then
			if obj:IsA("BasePart") then
				table.insert(WaterList, obj.Position)
			elseif obj:IsA("Model") and obj.PrimaryPart then
				table.insert(WaterList, obj.PrimaryPart.Position)
			elseif obj:IsA("Model") and obj:FindFirstChildWhichIsA("BasePart") then
				table.insert(WaterList, obj:FindFirstChildWhichIsA("BasePart").Position)
			end
		end
	end
end

TeleWaterBtn.MouseButton1Click:Connect(function()
	pcall(function()
		RefreshWaterList()
		if #WaterList > 0 then
			CurrentWaterIndex = CurrentWaterIndex + 1
			if CurrentWaterIndex > #WaterList then CurrentWaterIndex = 1 end
			TeleWaterBtn.Text = string.format("💧 MẶT NƯỚC (%d/%d)", CurrentWaterIndex, #WaterList)
			TeleportToWaterSurface(WaterList[CurrentWaterIndex])
		else
			TeleWaterBtn.Text = "💧 KHÔNG TÌM THẤY NƯỚC!"
			task.wait(1.5)
			TeleWaterBtn.Text = "💧 TELEPORT MẶT NƯỚC (UỐNG)"
		end
	end)
end)

-- ----------------------------------------------------
-- 7. ESP GOM CHUNG
-- ----------------------------------------------------
local EspToggleBtn = Instance.new("TextButton")
EspToggleBtn.Size = UDim2.new(0.9, 0, 0, 28)
EspToggleBtn.Position = UDim2.new(0.05, 0, 0.56, 0)
EspToggleBtn.Font = Enum.Font.SourceSansBold
EspToggleBtn.TextSize = 11
EspToggleBtn.Parent = MainFrame

local EspCorner = Instance.new("UICorner", EspToggleBtn)
EspCorner.CornerRadius = UDim.new(0, 5)

local function UpdateEspVisual()
	if ESP_Enabled then
		EspToggleBtn.Text = "👁️ ESP KHỦNG LONG & MÁU: [ BẬT ]"
		EspToggleBtn.BackgroundColor3 = THEME.ActiveBtn
		EspToggleBtn.TextColor3 = Color3.fromRGB(15, 18, 24)
	else
		EspToggleBtn.Text = "👁️ ESP KHỦNG LONG & MÁU: [ TẮT ]"
		EspToggleBtn.BackgroundColor3 = THEME.PrimaryBtn
		EspToggleBtn.TextColor3 = THEME.TextMain
	end
end

UpdateEspVisual()
EspToggleBtn.MouseButton1Click:Connect(function()
	ESP_Enabled = not ESP_Enabled
	UpdateEspVisual()
end)

local HintLabel = Instance.new("TextLabel")
HintLabel.Size = UDim2.new(1, 0, 0, 30)
HintLabel.Position = UDim2.new(0, 0, 0.88, 0)
HintLabel.Text = "[M]: Bật / Ẩn Menu\nBản quyền Primeval Menu V13"
HintLabel.TextColor3 = Color3.fromRGB(120, 140, 150)
HintLabel.TextSize = 10
HintLabel.BackgroundTransparency = 1
HintLabel.Parent = MainFrame

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.M then
		SetMenuState(not MenuVisible)
	end
end)

-- ----------------------------------------------------
-- 8. HỆ THỐNG ESP
-- ----------------------------------------------------
local espFolder = Instance.new("Folder", ScreenGui)
espFolder.Name = "ESP_Objects"

local function GetTargetModel(obj)
	if obj:IsA("Model") and obj:FindFirstChildOfClass("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
		return obj
	end
	return nil
end

local function CreateESP(model)
	if model == LocalPlayer.Character or espFolder:FindFirstChild(model:GetDebugId()) then return end

	local hrp = model:FindFirstChild("HumanoidRootPart")
	local humanoid = model:FindFirstChildOfClass("Humanoid")
	if not hrp or not humanoid then return end

	local bbg = Instance.new("BillboardGui")
	bbg.Name = model:GetDebugId()
	bbg.Adornee = hrp
	bbg.AlwaysOnTop = true
	bbg.ResetOnSpawn = false
	bbg.Size = UDim2.new(0, 200, 0, 65)
	bbg.StudsOffset = Vector3.new(0, 3.5, 0)
	bbg.Enabled = false
	bbg.Parent = espFolder

	local boxFrame = Instance.new("Frame")
	boxFrame.Name = "BoxFrame"
	boxFrame.Size = UDim2.new(0, 100, 0, 40)
	boxFrame.Position = UDim2.new(0.5, -50, 0.2, 0)
	boxFrame.BackgroundTransparency = 1
	boxFrame.BorderSizePixel = 0
	boxFrame.Parent = bbg

	local boxStroke = Instance.new("UIStroke", boxFrame)
	boxStroke.Color = THEME.Stroke
	boxStroke.Thickness = 1.5

	local combinedLabel = Instance.new("TextLabel")
	combinedLabel.Name = "CombinedInfo"
	combinedLabel.Size = UDim2.new(1, 0, 1, 0)
	combinedLabel.BackgroundTransparency = 1
	combinedLabel.Text = ""
	combinedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	combinedLabel.TextStrokeTransparency = 0
	combinedLabel.TextSize = 12
	combinedLabel.Font = Enum.Font.SourceSansBold
	combinedLabel.TextYAlignment = Enum.TextYAlignment.Top
	combinedLabel.Parent = bbg
end

RunService.RenderStepped:Connect(function()
	pcall(function()
		for _, obj in pairs(workspace:GetChildren()) do
			local model = GetTargetModel(obj)
			if model and model ~= LocalPlayer.Character then
				CreateESP(model)
			end
		end

		for _, bbg in pairs(espFolder:GetChildren()) do
			local targetModel = nil
			for _, obj in pairs(workspace:GetChildren()) do
				if obj:GetDebugId() == bbg.Name then
					targetModel = obj
					break
				end
			end

			if targetModel and targetModel:FindFirstChild("HumanoidRootPart") then
				local hrp = targetModel.HumanoidRootPart
				local humanoid = targetModel:FindFirstChildOfClass("Humanoid")
				local dist = math.floor((hrp.Position - Camera.CFrame.Position).Magnitude)

				if ESP_Enabled and dist <= MaxDistance then
					bbg.Enabled = true

					local currentHp = humanoid and math.floor(humanoid.Health) or 0
					local maxHp = humanoid and math.floor(humanoid.MaxHealth) or 100
					local healthPct = math.clamp(currentHp / (maxHp > 0 and maxHp or 1), 0, 1)

					bbg.CombinedInfo.Text = string.format("🦖 %s [%dm]\n❤️ HP: %d/%d (%d%%)", targetModel.Name, dist, currentHp, maxHp, math.floor(healthPct * 100))

					if healthPct < 0.35 then
						bbg.CombinedInfo.TextColor3 = Color3.fromRGB(255, 60, 60)
					elseif healthPct < 0.65 then
						bbg.CombinedInfo.TextColor3 = Color3.fromRGB(255, 220, 0)
					else
						bbg.CombinedInfo.TextColor3 = THEME.Stroke
					end
				else
					bbg.Enabled = false
				end
			else
				bbg:Destroy()
			end
		end
	end)
end)
