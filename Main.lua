local G2L = {};

-- IDs dos Ícones
local ID_NORMAL = "rbxassetid://134601196355279"
local ID_NOTIFICACAO = "rbxassetid://130103945046316"
local ID_SIMBOLO_CENTRAL = "rbxassetid://85337967115080"
local ID_BOTAO_FECHAR = "rbxassetid://89783450460085"

-- Prevenção de execução dupla e encerramento limpo
if getgenv().custom_chat_loaded then
    warn("Limpando execução anterior...")
    if game:GetService("CoreGui"):FindFirstChild("GlobalChat_Elite_V3") then
        game:GetService("CoreGui")["GlobalChat_Elite_V3"]:Destroy()
    end
    getgenv().custom_chat_loaded = nil
end
getgenv().custom_chat_loaded = true

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local ChatService = game:GetService("Chat") 
local Player = Players.LocalPlayer

-- UI PRINCIPAL
G2L.ScreenGui = Instance.new("ScreenGui")
G2L.ScreenGui.Name = "GlobalChat_Elite_V3"
G2L.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
G2L.ScreenGui.ResetOnSpawn = false
G2L.ScreenGui.Parent = game:GetService("CoreGui")

-- BOTAO TOGGLE
G2L.ToggleButton = Instance.new("ImageButton")
G2L.ToggleButton.Name = "ToggleChat"
G2L.ToggleButton.Size = UDim2.new(0, 55, 0, 55)
G2L.ToggleButton.Position = UDim2.new(0.02, 0, 0.45, 0)
G2L.ToggleButton.BackgroundTransparency = 1 
G2L.ToggleButton.Image = ID_NORMAL
G2L.ToggleButton.Parent = G2L.ScreenGui

-- JANELA PRINCIPAL (Design Escuro Igual à Imagem)
G2L.Main = Instance.new("Frame")
G2L.Main.Name = "MainFrame"
G2L.Main.Size = UDim2.new(0, 420, 0, 260)
G2L.Main.Position = UDim2.new(0.5, -210, 0.5, -130)
G2L.Main.BackgroundColor3 = Color3.fromRGB(13, 16, 19)
G2L.Main.BackgroundTransparency = 0.05
G2L.Main.BorderSizePixel = 0
G2L.Main.Visible = false
G2L.Main.Parent = G2L.ScreenGui

G2L.MainStroke = Instance.new("UIStroke")
G2L.MainStroke.Color = Color3.fromRGB(255, 255, 255)
G2L.MainStroke.Thickness = 1.5
G2L.MainStroke.Parent = G2L.Main

-- TOPBAR
G2L.TopBar = Instance.new("Frame")
G2L.TopBar.Size = UDim2.new(1, 0, 0, 40)
G2L.TopBar.BackgroundTransparency = 1
G2L.TopBar.ZIndex = 5
G2L.TopBar.Parent = G2L.Main

G2L.Title = Instance.new("TextLabel")
G2L.Title.Size = UDim2.new(1, 0, 1, 0)
G2L.Title.BackgroundTransparency = 1
G2L.Title.Text = "Chat Geral"
G2L.Title.Font = Enum.Font.SourceSansBold
G2L.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
G2L.Title.TextSize = 20
G2L.Title.ZIndex = 5
G2L.Title.Parent = G2L.TopBar

-- BOTÃO DE FECHAR
G2L.CloseBtn = Instance.new("ImageButton")
G2L.CloseBtn.Size = UDim2.new(0, 26, 0, 26)
G2L.CloseBtn.Position = UDim2.new(1, -35, 0.5, -13)
G2L.CloseBtn.BackgroundTransparency = 1
G2L.CloseBtn.Image = ID_BOTAO_FECHAR
G2L.CloseBtn.ZIndex = 6
G2L.CloseBtn.Parent = G2L.TopBar

-- LINHA DIVISÓRIA SUPERIOR
G2L.TopDivider = Instance.new("Frame")
G2L.TopDivider.Size = UDim2.new(1, 0, 0, 1)
G2L.TopDivider.Position = UDim2.new(0, 0, 0, 40)
G2L.TopDivider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
G2L.TopDivider.BorderSizePixel = 0
G2L.TopDivider.Parent = G2L.Main

-- SÍMBOLO CENTRAL (Marca d'água de fundo)
G2L.CenterSymbol = Instance.new("ImageLabel")
G2L.CenterSymbol.Size = UDim2.new(0, 120, 0, 120)
G2L.CenterSymbol.Position = UDim2.new(0.5, -60, 0.5, -45)
G2L.CenterSymbol.BackgroundTransparency = 1
G2L.CenterSymbol.Image = ID_SIMBOLO_CENTRAL
G2L.CenterSymbol.ImageColor3 = Color3.fromRGB(255, 255, 255)
G2L.CenterSymbol.ImageTransparency = 0.85
G2L.CenterSymbol.ZIndex = 1
G2L.CenterSymbol.Parent = G2L.Main

-- HISTÓRICO DE CHAT
G2L.ChatHistory = Instance.new("ScrollingFrame")
G2L.ChatHistory.Size = UDim2.new(1, -20, 1, -95)
G2L.ChatHistory.Position = UDim2.new(0, 10, 0, 45)
G2L.ChatHistory.BackgroundTransparency = 1
G2L.ChatHistory.ScrollBarThickness = 3
G2L.ChatHistory.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
G2L.ChatHistory.CanvasSize = UDim2.new(0, 0, 0, 0)
G2L.ChatHistory.ZIndex = 5
G2L.ChatHistory.Parent = G2L.Main

G2L.Layout = Instance.new("UIListLayout")
G2L.Layout.Padding = UDim.new(0, 4)
G2L.Layout.SortOrder = Enum.SortOrder.LayoutOrder
G2L.Layout.Parent = G2L.ChatHistory

-- ÁREA INFERIOR DE INPUT
G2L.BottomArea = Instance.new("Frame")
G2L.BottomArea.Size = UDim2.new(1, -12, 0, 36)
G2L.BottomArea.Position = UDim2.new(0, 6, 1, -42)
G2L.BottomArea.BackgroundColor3 = Color3.fromRGB(5, 7, 9)
G2L.BottomArea.BorderSizePixel = 0
G2L.BottomArea.Parent = G2L.Main

G2L.BottomStroke = Instance.new("UIStroke")
G2L.BottomStroke.Color = Color3.fromRGB(40, 50, 60)
G2L.BottomStroke.Thickness = 1
G2L.BottomStroke.Parent = G2L.BottomArea

G2L.Input = Instance.new("TextBox")
G2L.Input.Size = UDim2.new(1, -50, 1, 0)
G2L.Input.Position = UDim2.new(0, 10, 0, 0)
G2L.Input.BackgroundTransparency = 1
G2L.Input.Text = "" -- Força o campo a iniciar totalmente vazio
G2L.Input.TextColor3 = Color3.fromRGB(255, 255, 255)
G2L.Input.PlaceholderText = "Digite uma Mensagem..."
G2L.Input.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
G2L.Input.TextXAlignment = Enum.TextXAlignment.Left
G2L.Input.TextSize = 15
G2L.Input.Font = Enum.Font.SourceSansBold
G2L.Input.Parent = G2L.BottomArea

G2L.SendBtn = Instance.new("ImageButton")
G2L.SendBtn.Size = UDim2.new(0, 22, 0, 22)
G2L.SendBtn.Position = UDim2.new(1, -32, 0.5, -11)
G2L.SendBtn.BackgroundTransparency = 1
G2L.SendBtn.Image = "rbxassetid://18940312887"
G2L.SendBtn.ImageColor3 = Color3.fromRGB(255, 255, 255) -- Cor alterada de azul para Branco/Cinza Claro
G2L.SendBtn.Parent = G2L.BottomArea

-- LOGICA DE MENSAGENS E BUBBLE
local BubbleCooldown = {}
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

local function AdicionarMensagem(username, displayname, msg, isMe)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -5, 0, 18)
    label.BackgroundTransparency = 1
    label.RichText = true
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 15
    label.TextXAlignment = Enum.TextXAlignment.Left

    local nameColor = isMe and "rgb(255,100,100)" or "rgb(190,100,255)"
    label.Text = string.format("<font color='%s'>%s:</font> <font color='rgb(255,255,255)'>%s</font>", nameColor, displayname, msg)

    label.AutomaticSize = Enum.AutomaticSize.Y
    label.TextWrapped = true
    label.ZIndex = 6
    label.Parent = G2L.ChatHistory

    G2L.ChatHistory.CanvasPosition = Vector2.new(0, G2L.Layout.AbsoluteContentSize.Y)

    if not G2L.Main.Visible and not isMe then
        G2L.ToggleButton.Image = ID_NOTIFICACAO
    end

    MostrarBubbleChat(username, msg)
end

-- SISTEMA DE REDE COM RECONEXÃO AUTOMÁTICA
local socket
local wsUrl = "wss://free.blr2.piesocket.com/v3/1?api_key=nJwrvMLQ39lJLpcxH88UbwiV08uXKrqSV7zvC1Z4&notify_self=0"
local running = true
local MensagensRecebidas = {}

local function ConnectWebSocket()
    if not running then return end

    local success, res = pcall(function()
        return WebSocket.connect(wsUrl)
    end)

    if success and res then
        socket = res
        print("Chat Conectado!")

        socket.OnMessage:Connect(function(msg)
            if not running then return end
            local ok, data = pcall(function() return HttpService:JSONDecode(msg) end)
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
                AdicionarMensagem(data.username, dName, data.message, data.username == Player.Name)
            end
        end)

        socket.OnClose:Connect(function()
            if running then
                warn("Conexão perdida! Tentando reconectar em 5 segundos...")
                task.wait(5)
                ConnectWebSocket()
            end
        end)
    else
        if running then
            warn("Erro ao conectar no servidor. Tentando novamente...")
            task.wait(5)
            ConnectWebSocket()
        end
    end
end

-- Botão Enviar com verificação de conexão
local function EnviarMensagem()
    if socket and G2L.Input.Text ~= "" then
        local success, err = pcall(function()
            socket:Send(HttpService:JSONEncode({
                username = Player.Name, 
                nickname = Player.DisplayName, 
                message = G2L.Input.Text
            }))
        end)
        if not success then 
            warn("Falha no envio (Socket morto). Tentando reconectar...")
            ConnectWebSocket()
        end
        G2L.Input.Text = ""
    elseif not socket then
        warn("Chat desconectado. Aguarde a reconexão.")
    end
end

G2L.SendBtn.MouseButton1Click:Connect(EnviarMensagem)
G2L.Input.FocusLost:Connect(function(enter) if enter then EnviarMensagem() end end)

-- FUNÇÃO DE ARRASTE
local function MakeDraggable(gui)
    local dragging, dragInput, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

MakeDraggable(G2L.Main)
MakeDraggable(G2L.ToggleButton)

G2L.ToggleButton.MouseButton1Click:Connect(function() 
    G2L.Main.Visible = not G2L.Main.Visible 
    if G2L.Main.Visible then
        G2L.ToggleButton.Image = ID_NORMAL
    end
end)

-- Ação do Botão de Fechar
G2L.CloseBtn.MouseButton1Click:Connect(function()
    running = false
    getgenv().custom_chat_loaded = nil
    if socket then
        pcall(function() socket:Close() end)
    end
    G2L.ScreenGui:Destroy()
    print("Script de Chat Encerrado Definitivamente.")
end)

task.spawn(ConnectWebSocket)

G2L.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    G2L.ChatHistory.CanvasSize = UDim2.new(0, 0, 0, G2L.Layout.AbsoluteContentSize.Y + 10)
end)

return G2L.ScreenGui
