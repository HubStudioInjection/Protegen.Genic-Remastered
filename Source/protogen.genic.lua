--LuaObfusocator and MoonSec best
local localsApis = {}
repeat wait(0.1) until game:IsLoaded()
if game:IsLoaded() then
if not isfolder("Protegen.Genic") then makefolder("Protegen.Genic") end
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/HubStudioInjection/ui-lib/refs/heads/main/Library.lua'))()
local ThemeManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/HubStudioInjection/themes/refs/heads/main/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/HubStudioInjection/savem/refs/heads/main/SaveManager.lua'))()
getgenv().TracerS = "L"
getgenv().Tracer = "T"
getgenv().Circle = "B"

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local tracerEnabled = false
local tracerColor = Color3.fromRGB(255, 255, 255) -- Колір ліній (білий)

local tracers = {}

-- Перемикання Tracers на клавішу "T"
UserInputService.InputBegan:Connect(function(input, isProcessed)
    if not isProcessed and input.KeyCode == Enum.KeyCode.L then
        tracerEnabled = not tracerEnabled
        for _, line in pairs(tracers) do
            line.Visible = tracerEnabled
        end
    end
end)

-- Функція для створення лінії для кожного гравця
local function createTracer(player)
    local line = Drawing.new("Line")
    line.Thickness = 2
    line.Transparency = 1
    line.Visible = false
    line.Color = tracerColor -- Встановлення кольору для всіх ліній

    tracers[player] = line
end

-- Функція для видалення лінії, якщо гравець покинув гру
local function removeTracer(player)
    if tracers[player] then
        tracers[player]:Remove()
        tracers[player] = nil
    end
end

-- Оновлення ліній
RunService.RenderStepped:Connect(function()
    if not tracerEnabled then return end

    for player, line in pairs(tracers) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = player.Character.HumanoidRootPart
            local screenPosition, onScreen = Camera:WorldToViewportPoint(rootPart.Position)

            if onScreen then
                line.Visible = true
                line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y) -- Снизу екрану
                line.To = Vector2.new(screenPosition.X, screenPosition.Y)
            else
                line.Visible = false
            end
        else
            line.Visible = false
        end
    end
end)

-- Додавання і видалення ліній при вході і виході гравців
Players.PlayerAdded:Connect(createTracer)
Players.PlayerRemoving:Connect(removeTracer)

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        createTracer(player)
    end
end

local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

local circleEnabled = false -- Початковий стан кола (вимкнено)
local followCircle

-- Створення кола
local function createFollowCircle()
    followCircle = Drawing.new("Circle")
    followCircle.Radius = 50 -- Радіус кола
    followCircle.Color = Color3.new(75, 108, 178) -- Зелений колір
    followCircle.Thickness = 2
    followCircle.Transparency = 1
    followCircle.Visible = false -- Спочатку невидиме
end

-- Функція для перемикання кола
local function toggleCircle()
    circleEnabled = not circleEnabled
    followCircle.Visible = circleEnabled
end

-- Обробник натискання клавіші для перемикання кола
userInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.B and not gameProcessed then -- Клавіша "B" для перемикання кола
        toggleCircle()
    end
end)

-- Оновлення позиції кола на кожному кадрі
runService.RenderStepped:Connect(function()
    if circleEnabled then
        followCircle.Position = Vector2.new(userInputService:GetMouseLocation().X, userInputService:GetMouseLocation().Y)
    end
end)

-- Створення кола при запуску скрипту
createFollowCircle()

script.Parent = game.StarterPlayer.StarterPlayerScripts

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local tracerEnabled = false
local defaultColor = Color3.fromRGB(255, 255, 255) -- Білий колір, якщо немає команд

local tracers = {}

-- Перемикання Tracers на клавішу "T"
UserInputService.InputBegan:Connect(function(input, isProcessed)
    if not isProcessed and input.KeyCode == Enum.KeyCode.T then
        tracerEnabled = not tracerEnabled
        for _, line in pairs(tracers) do
            line.Visible = tracerEnabled
        end
    end
end)

-- Функція для створення лінії для кожного гравця
local function createTracer(player)
    local line = Drawing.new("Line")
    line.Thickness = 2
    line.Transparency = 1
    line.Visible = false
    
    tracers[player] = line
end

-- Функція для видалення лінії, якщо гравець покинув гру
local function removeTracer(player)
    if tracers[player] then
        tracers[player]:Remove()
        tracers[player] = nil
    end
end

-- Оновлення ліній
RunService.RenderStepped:Connect(function()
    if not tracerEnabled then return end

    for player, line in pairs(tracers) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = player.Character.HumanoidRootPart
            local screenPosition, onScreen = Camera:WorldToViewportPoint(rootPart.Position)

            if onScreen then
                line.Visible = true
                line.Color = player.Team and player.TeamColor.Color or defaultColor
                line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y) -- Снизу екрану
                line.To = Vector2.new(screenPosition.X, screenPosition.Y)
            else
                line.Visible = false
            end
        else
            line.Visible = false
        end
    end
end)

-- Додавання і видалення ліній при вході і виході гравців
Players.PlayerAdded:Connect(createTracer)
Players.PlayerRemoving:Connect(removeTracer)

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        createTracer(player)
    end
end
script.Parent = game.StarterPlayer.StarterPlayerScripts

local Concent = {}
local Window = Library:CreateWindow({
	Title = 'Protegen.Genic<=|=>Universal ESP<=|=>3.0.0 Final Version',
	Center = true,
	AutoShow = true,
	Resizable = true,
	ShowCustomCursor = false,
	TabPadding = 0,
	MenuFadeTime = 0
})

local FrameTimer = tick()
local FrameCounter = 0;
local FPS = 60;

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
	FrameCounter += 1;

	if (tick() - FrameTimer) >= 1 then
		FPS = FrameCounter;
		FrameTimer = tick();
		FrameCounter = 0;
	end;

	Library:SetWatermark(('Protegen.Genic<=|=>3.0.0 Final Version<=|=>%s fps<=|=>%s ms'):format(
		math.floor(FPS),
		math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
	));
end);

local Tabs = {
	-- Creates a new tab titled Main
	Main = Window:AddTab('Main'),
	['UI Settings'] = Window:AddTab('UI Settings'),
}

Library:OnUnload(function()
	WatermarkConnection:Disconnect()

	print('Unloaded!')
	Library.Unloaded = true
end)

-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- ThemeManager (Allows you to have a menu theme system)

-- Hand the library over to our managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- Adds our MenuKeybind to the ignore list
-- (do you want each config to have a different menu key? probably not.)
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')

-- Builds our config menu on the right side of our tab
SaveManager:BuildConfigSection(Tabs['UI Settings'])

-- Builds our theme menu (with plenty of built in themes) on the left side
-- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
task.spawn(function()
	while true do
		wait(1)

		-- example for checking if a keybind is being pressed
		local state = Options.KeyPicker:GetState()
		if state then
			print('KeyPicker is being held down')
		end

		if Library.Unloaded then break end
	end
end)
local Vis = Tabs.Main:AddLeftTabbox() -- Add Tabbox on right side

-- Anything we can do in a Groupbox, we can do in a Tabbox tab (AddToggle, AddSlider, AddLabel, etc etc...)
local ESP = 	Vis:AddTab('{=>ESP<=}')

	ESP:AddToggle('ESp', {
	Text = 'ESP Without TeamChk',
	Default = false, -- Default value (true / false)
	Tooltip = 'ESP Without TeamChk', -- Information shown when you hover over the toggle

	Callback = function(Value)
getgenv().enabled = Value --Toggle on/off
getgenv().filluseteamcolor = false
getgenv().outlineuseteamcolor = false  --Toggle outline color using player team color on/off
getgenv().fillcolor = Color3.new(1, 1, 1) --Change fill color, no need to edit if using team color
getgenv().outlinecolor = Color3.new(1, 1, 1) --Change outline color, no need to edit if using team color
getgenv().Espv = Value --Change fill transparency
getgenv().Espo = Value --Change outline transparency
loadstring(game:HttpGet("https://raw.githubusercontent.com/HubStudioInjection/esp/refs/heads/main/source.lua"))()
	end
})
ESP:AddToggle('ESwp', {
	Text = 'ESP With TeamChk',
	Default = false, -- Default value (true / false)
	Tooltip = 'ESP With TeamChk', -- Information shown when you hover over the toggle

	Callback = function(Value)
getgenv().enabled = Value --Toggle on/off
getgenv().filluseteamcolor = true
getgenv().outlineuseteamcolor = true  --Toggle outline color using player team color on/off
getgenv().fillcolor = Color3.new(1, 1, 1) --Change fill color, no need to edit if using team color
getgenv().outlinecolor = Color3.new(1, 1, 1) --Change outline color, no need to edit if using team color
getgenv().Espv = Value --Change fill transparency
getgenv().Espo = Value --Change outline transparency
loadstring(game:HttpGet("https://raw.githubusercontent.com/HubStudioInjection/esp/refs/heads/main/source.lua"))()
	end
})

ESP:AddLabel('ESP KeyBind'):AddKeyPicker('KeyPicker', {
	Default = 'K',
	SyncToggleState = false,
	Mode = 'Toggle', -- Modes: Always, Toggle, Hold

	Text = 'ESP Without TeamChk KeyBind', -- Text to display in the keybind menu
	NoUI = false, -- Set to true if you want to hide from the Keybind menu,
	Callback = function(Value)
getgenv().enabled = Value --Toggle on/off
getgenv().filluseteamcolor = false
getgenv().outlineuseteamcolor = false  --Toggle outline color using player team color on/off
getgenv().fillcolor = Color3.new(1, 1, 1) --Change fill color, no need to edit if using team color
getgenv().outlinecolor = Color3.new(1, 1, 1) --Change outline color, no need to edit if using team color
getgenv().Espv = Value --Change fill transparency
getgenv().Espo = Value --Change outline transparency
loadstring(game:HttpGet("https://raw.githubusercontent.com/HubStudioInjection/esp/refs/heads/main/source.lua"))()
	end
})

	--[[ESP:AddDivider()
ESP:AddSlider('Espv', {
	Text = 'ESP Fill Transparency',
	Default = 0.8,
	Min = 0,
	Max = 1,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		getgenv().filltrans = Value
	end
})

ESP:AddSlider('Espo', {
	Text = 'ESP Outline Transparency',
	Default = 0,
	Min = 0,
	Max = 1,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		getgenv().outlinetrans = Value
	end
})]]

ESP:AddDivider()

ESP:AddToggle('Ejwhj', {
	Text = 'Tracers Without TeamChk',
	Default = false, -- Default value (true / false)
	Tooltip = 'Tracers Without TeamChk', -- Information shown when you hover over the toggle

	Callback = function(Value)
game:GetService("VirtualInputManager"):SendKeyEvent(true,getgenv().TracerS,false,game);
	end
})

ESP:AddToggle('Ejwh', {
	Text = 'Tracers With TeamChk',
	Default = false, -- Default value (true / false)
	Tooltip = 'Tracers With TeamChk', -- Information shown when you hover over the toggle

	Callback = function(Value)
game:GetService("VirtualInputManager"):SendKeyEvent(true,getgenv().Tracer,false,game);
	end
})

ESP:AddLabel('Tracers With TeamChk')
ESP:AddLabel('KeyBind: T')
ESP:AddLabel('Tracers Without TeamChk')
ESP:AddLabel('KeyBind: L')

ESP:AddDivider()

	ESP:AddToggle('Aim', {
	Text = 'Enable Circle Like Cursor',
	Default = false, -- Default value (true / false)
	Tooltip = 'Enable Aiming Circle', -- Information shown when you hover over the toggle

	Callback = function(Value)
game:GetService("VirtualInputManager"):SendKeyEvent(true,getgenv().Circle,false,game);
end
})

ESP:AddSlider('fov', {
	Text = 'Field Of View',
	Default = 70,
	Min = 70,
	Max = 120,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
	workspace.CurrentCamera.FieldOfView	 = Value
	end
})
local AA = Tabs.Main:AddRightTabbox() -- Add Tabbox on right side

-- Anything we can do in a Groupbox, we can do in a Tabbox tab (AddToggle, AddSlider, AddLabel, etc 
local ll = 	AA:AddTab('{=>More<=}')
local Ds = ll:AddButton({
	Text = 'Join Discord',
	Func = function()
		setclipboard("discord.gg//") 
	end,
	DoubleClick = false,
	Tooltip = 'Join Discord'
})

ll:AddLabel('Welcome!')
ll:AddDivider()
ll:AddLabel('Created By: Hub Studio Injection™')
ll:AddDivider()
ll:AddLabel('Game Id: '..game.PlaceId)
ll:AddLabel('Server Version: '..game.PlaceVersion)

local log = Tabs.Main:AddRightTabbox() -- Add Tabbox on right side

-- Anything we can do in a Groupbox, we can do in a Tabbox tab (AddToggle, AddSlider, AddLabel, e
local lll = 	log:AddTab('{=>Logs<=}')
lll:AddLabel('Update 2.5.9:')
lll:AddLabel('Idk')
lll:AddLabel('Idk Goofy Ahh Label')
	
local To = Tabs.Main:AddRightTabbox() -- Add Tabbox on right side

-- Anything we can do in a Groupbox, we can do in a Tabbox tab (AddToggle, AddSlider, AddLabel, etc etc...)
local js = 	To:AddTab('{=>Tools<=}')
local WW1 = js:AddButton({
	Text = 'Dex Mobile',
	Func = function()
setclipboard(" loadstring(game:HttpGet("https://raw.githubusercontent.com/HubStudioInjection/Protegen.Genic-Remastered/refs/heads/main/Source/Dex%20Mobile.lua"))()")
	end,
	DoubleClick = false,
	Tooltip = 'Dex Mobile'
})
local qqw = js:AddButton({
	Text = 'Dex Pc (Copy To ClipBoard)',
	Func = function()
setclipboard("	 loadstring(game:HttpGet("https://raw.githubusercontent.com/HubStudioInjection/Protegen.Genic-Remastered/refs/heads/main/Source/Pc%20Dex.lua"))()")
	end,
	DoubleClick = false,
	Tooltip = 'Dex Pc'
})
local QA = js:AddButton({
	Text = 'Simple Spy',
	Func = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua'))()
	end,
	DoubleClick = false,
	Tooltip = 'Simple Spy'
})
local SW2 = js:AddButton({
	Text = 'Nameless Admin',
	Func = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/refs/heads/main/Source.lua", true))()
	end,
	DoubleClick = false,
	Tooltip = 'Nameless Admin'
})
return Concent
end