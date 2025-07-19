local Players = game:GetService("Players")
local player = Players.LocalPlayer

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BlackScreenGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.IgnoreGuiInset = true -- Ignora a área de GUI do Roblox

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BackgroundTransparency = 0
    frame.Parent = screenGui
    frame.ZIndex = 999 -- Garante que a GUI fique acima de outros elementos
