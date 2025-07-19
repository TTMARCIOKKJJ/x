local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function criarGuiPreta()
    if player.PlayerGui:FindFirstChild("BlackScreenGui") then return end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BlackScreenGui"
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 1000
    screenGui.Parent = player.PlayerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,0,1,0)
    frame.Position = UDim2.new(0,0,0,0)
    frame.BackgroundColor3 = Color3.new(0,0,0)
    frame.BackgroundTransparency = 0
    frame.Parent = screenGui

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            screenGui:Destroy()
        end
    end)
end

player.Chatted:Connect(function(msg)
    if msg:lower() == ";hi" then
        criarGuiPreta()
    end
end)
