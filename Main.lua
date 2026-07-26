-- ADICIONE ESTA LINHA ANTES DA FUNÇÃO MostrarBubbleChat
local BubbleCooldown = {}

-- SUBSTITUA A FUNÇÃO MostrarBubbleChat PELA VERSÃO ABAIXO
local function MostrarBubbleChat(username, message)
    if BubbleCooldown[username] then
        return
    end

    BubbleCooldown[username] = true

    task.delay(1, function()
        BubbleCooldown[username] = nil
    end)

    local targetPlayer = Players:FindFirstChild(username)

    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
        ChatService:Chat(targetPlayer.Character.Head, message, Enum.ChatColor.White)
    end
end

-- ADICIONE ESTA LINHA PRÓXIMO DAS VARIÁVEIS DO WEBSOCKET
local MensagensRecebidas = {}

-- SUBSTITUA O BLOCO socket.OnMessage:Connect(function(msg) PELO ABAIXO
socket.OnMessage:Connect(function(msg)
    if not running then return end

    local ok, data = pcall(function()
        return HttpService:JSONDecode(msg)
    end)

    if ok and data.message then
        local ID = data.username .. ":" .. data.message

        if MensagensRecebidas[ID] then
            return
        end

        MensagensRecebidas[ID] = true

        task.delay(2, function()
            MensagensRecebidas[ID] = nil
        end)

        local dName = data.nickname or data.username

        AdicionarMensagem(
            data.username,
            dName,
            data.message,
            data.username == Player.Name
        )
    end
end)

-- OPCIONAL (RECOMENDADO): ALTERE A URL DO WEBSOCKET
-- De:
-- &notify_self=1
-- Para:
-- &notify_self=0
