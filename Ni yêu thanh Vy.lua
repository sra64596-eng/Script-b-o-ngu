-- Monster / Entity ESP for Aisles Of The Locust [Chapter 2]
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local function createESP(targetPart)
    if not targetPart:FindFirstChild("MonsterESP") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "MonsterESP"
        -- Bright red color to spot dangerous monsters
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.4
        highlight.OutlineTransparency = 0
        highlight.Adornee = targetPart
        highlight.Parent = targetPart
    end
end

-- Continuously scan the Workspace for new monsters
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            for _, v in pairs(Workspace:GetDescendants()) do
                -- Filter objects that could be monsters (based on Humanoid or model type)
                if v:IsA("Model") and v ~= LocalPlayer.Character then
                    local humanoid = v:FindFirstChildOfClass("Humanoid")
                    -- If it's not another player, it is likely a monster/NPC
                    if humanoid and not Players:GetPlayerFromCharacter(v) then
                        createESP(v)
                    end
                end
            end
        end)
    end
end)

print("Monster ESP successfully activated!")
