local Players = game:GetService("Players")

local function killAll()
	for _, player in ipairs(Players:GetPlayers()) do
		local character = player.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid.Health = 0
		end
	end
end

-- Gọi khi cần:
killAll()
