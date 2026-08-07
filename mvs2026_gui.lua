-- (rivals script) - Custom GUI rewrite
-- Status: Fixed Desync Bug / Improved Serverhop / Custom UI (no Rayfield) / Fixed Noclip / Infinite Jump / Reworked Invisible Panel

--=========================================================
-- SERVICES / STATE
--=========================================================
local players    = game:GetService("Players")
local rs         = game:GetService("ReplicatedStorage")
local ws         = game:GetService("Workspace")
local teleports  = game:GetService("TeleportService")
local runService = game:GetService("RunService")
local uis        = game:GetService("UserInputService")
local tweenServ  = game:GetService("TweenService")
local http       = game:GetService("HttpService")
local lp         = players.LocalPlayer

local ESP_ON       = false
local HITBOX_ON    = false
local KILL_ALL_ON  = false
local HITBOX_SIZE  = 5

local WalkSpeedValue       = 16
local NoClipEnabled        = false
local InfiniteJumpEnabled  = false

local INVIS_CONFIG = {
	INVISIBILITY_POSITION = Vector3.new(-25.95, 84, 3537.55),
}
local playerState = { isInvisible = false }

local THEME = {
	BG        = Color3.fromRGB(18, 18, 24),
	PANEL     = Color3.fromRGB(26, 26, 34),
	ELEMENT   = Color3.fromRGB(34, 34, 44),
	STROKE    = Color3.fromRGB(52, 52, 66),
	TEXT      = Color3.fromRGB(235, 235, 245),
	SUBTEXT   = Color3.fromRGB(150, 150, 170),
	ACCENT    = Color3.fromRGB(0, 170, 255),
	SUCCESS   = Color3.fromRGB(46, 204, 113),
	DANGER    = Color3.fromRGB(231, 76, 60),
	FONT      = Enum.Font.GothamMedium,
	FONT_BOLD = Enum.Font.GothamBold,
}

--=========================================================
-- PURGE / REMOTE CACHE (original logic)
--=========================================================
local function anonymousPurge()
	local targets = {"BAC", "Anti", "Check", "Detection", "Security", "Kick", "Adonnis", "Sentinel"}
	for _, v in pairs(game:GetDescendants()) do
		pcall(function()
			if v:IsA("LocalScript") or v:IsA("ModuleScript") then
				local name = v.Name:lower()
				for _, word in pairs(targets) do
					if name:find(word:lower()) or v.Parent.Name:lower():find(word:lower()) then
						v.Disabled = true
						v:Destroy()
					end
				end
			end
		end)
	end
end
pcall(anonymousPurge)

local cachedRemotes = {}
local function updateRemoteCache()
	cachedRemotes = {}
	local areas = {rs, ws, lp.Backpack}
	for _, area in pairs(areas) do
		pcall(function()
			for _, obj in ipairs(area:GetDescendants()) do
				if obj:IsA("RemoteEvent") and (obj.Name:lower():find("kill") or obj.Name:lower():find("knife")) then
					table.insert(cachedRemotes, obj)
				end
			end
		end)
	end
end

--=========================================================
-- UI LIBRARY
--=========================================================
local function corner(parent, radius)
	local c = Instance.new("UICorner", parent)
	c.CornerRadius = UDim.new(0, radius or 8)
	return c
end

local function stroke(parent, color, thickness)
	local s = Instance.new("UIStroke", parent)
	s.Color = color or THEME.STROKE
	s.Thickness = thickness or 1
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	return s
end

local function tween(obj, props, time)
	tweenServ:Create(obj, TweenInfo.new(time or 0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

local parentGui = (gethui and gethui()) or game:GetService("CoreGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MvS2026Hub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = parentGui

--------------------------------------------------- notifications
local NotifyHolder = Instance.new("Frame", ScreenGui)
NotifyHolder.AnchorPoint = Vector2.new(1, 1)
NotifyHolder.Position = UDim2.new(1, -16, 1, -16)
NotifyHolder.Size = UDim2.new(0, 260, 0, 300)
NotifyHolder.BackgroundTransparency = 1
local nlist = Instance.new("UIListLayout", NotifyHolder)
nlist.VerticalAlignment = Enum.VerticalAlignment.Bottom
nlist.HorizontalAlignment = Enum.HorizontalAlignment.Right
nlist.Padding = UDim.new(0, 8)

local function notify(text, color)
	local f = Instance.new("Frame", NotifyHolder)
	f.Size = UDim2.new(1, 0, 0, 36)
	f.BackgroundColor3 = THEME.PANEL
	f.BackgroundTransparency = 1
	corner(f, 8)
	stroke(f, color or THEME.ACCENT)
	local l = Instance.new("TextLabel", f)
	l.Size = UDim2.new(1, -16, 1, 0)
	l.Position = UDim2.new(0, 12, 0, 0)
	l.BackgroundTransparency = 1
	l.Font = THEME.FONT
	l.TextSize = 13
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.TextColor3 = THEME.TEXT
	l.Text = text
	l.TextTransparency = 1
	tween(f, {BackgroundTransparency = 0}, 0.15)
	tween(l, {TextTransparency = 0}, 0.15)
	task.delay(2.5, function()
		tween(f, {BackgroundTransparency = 1}, 0.2)
		tween(l, {TextTransparency = 1}, 0.2)
		task.wait(0.25)
		f:Destroy()
	end)
end

--------------------------------------------------- main window
local Main = Instance.new("Frame", ScreenGui)
Main.Name = "Main"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = UDim2.new(0, 560, 0, 380)
Main.BackgroundColor3 = THEME.BG
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
corner(Main, 12)
stroke(Main, THEME.STROKE)

local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 44)
TopBar.BackgroundColor3 = THEME.PANEL
TopBar.BorderSizePixel = 0
corner(TopBar, 12)
local topPatch = Instance.new("Frame", TopBar)
topPatch.Size = UDim2.new(1, 0, 0, 12)
topPatch.Position = UDim2.new(0, 0, 1, -12)
topPatch.BackgroundColor3 = THEME.PANEL
topPatch.BorderSizePixel = 0

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -110, 1, 0)
Title.Position = UDim2.new(0, 16, 0, 0)
Title.BackgroundTransparency = 1
Title.Font = THEME.FONT_BOLD
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = THEME.TEXT
Title.Text = "Murder vs Sheriff 2026"

local Subtitle = Instance.new("TextLabel", TopBar)
Subtitle.Size = UDim2.new(0, 200, 0, 14)
Subtitle.Position = UDim2.new(0, 16, 1, -16)
Subtitle.BackgroundTransparency = 1
Subtitle.Font = THEME.FONT
Subtitle.TextSize = 11
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.TextColor3 = THEME.SUBTEXT
Subtitle.Text = "RightShift to hide / show"
Subtitle.Visible = false

local function makeTopButton(text, xOffset, color)
	local b = Instance.new("TextButton", TopBar)
	b.AnchorPoint = Vector2.new(1, 0.5)
	b.Position = UDim2.new(1, xOffset, 0.5, 0)
	b.Size = UDim2.new(0, 28, 0, 28)
	b.BackgroundColor3 = THEME.ELEMENT
	b.Text = text
	b.Font = THEME.FONT_BOLD
	b.TextSize = 14
	b.TextColor3 = color or THEME.TEXT
	b.AutoButtonColor = false
	corner(b, 6)
	b.MouseEnter:Connect(function() tween(b, {BackgroundColor3 = THEME.STROKE}) end)
	b.MouseLeave:Connect(function() tween(b, {BackgroundColor3 = THEME.ELEMENT}) end)
	return b
end

local CloseBtn = makeTopButton("X", -10, THEME.DANGER)
local MinBtn   = makeTopButton("-", -46)

--------------------------------------------------- tabs
local TabBar = Instance.new("Frame", Main)
TabBar.Position = UDim2.new(0, 0, 0, 44)
TabBar.Size = UDim2.new(0, 140, 1, -44)
TabBar.BackgroundColor3 = THEME.PANEL
TabBar.BorderSizePixel = 0

local tabList = Instance.new("UIListLayout", TabBar)
tabList.Padding = UDim.new(0, 6)
local tabPad = Instance.new("UIPadding", TabBar)
tabPad.PaddingTop = UDim.new(0, 10)
tabPad.PaddingLeft = UDim.new(0, 10)
tabPad.PaddingRight = UDim.new(0, 10)

local Pages = Instance.new("Frame", Main)
Pages.Position = UDim2.new(0, 140, 0, 44)
Pages.Size = UDim2.new(1, -140, 1, -44)
Pages.BackgroundTransparency = 1

local tabs = {}
local function createTab(name)
	local btn = Instance.new("TextButton", TabBar)
	btn.Size = UDim2.new(1, 0, 0, 32)
	btn.BackgroundColor3 = THEME.ELEMENT
	btn.BackgroundTransparency = 1
	btn.Text = name
	btn.Font = THEME.FONT
	btn.TextSize = 13
	btn.TextColor3 = THEME.SUBTEXT
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.AutoButtonColor = false
	corner(btn, 6)
	local bpad = Instance.new("UIPadding", btn)
	bpad.PaddingLeft = UDim.new(0, 10)

	local page = Instance.new("ScrollingFrame", Pages)
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.ScrollBarThickness = 3
	page.ScrollBarImageColor3 = THEME.ACCENT
	page.CanvasSize = UDim2.new(0, 0, 0, 0)
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	page.Visible = false
	local plist = Instance.new("UIListLayout", page)
	plist.Padding = UDim.new(0, 8)
	local ppad = Instance.new("UIPadding", page)
	ppad.PaddingTop = UDim.new(0, 12)
	ppad.PaddingLeft = UDim.new(0, 14)
	ppad.PaddingRight = UDim.new(0, 14)
	ppad.PaddingBottom = UDim.new(0, 12)

	local tab = {Button = btn, Page = page}
	table.insert(tabs, tab)

	local function select()
		for _, t in ipairs(tabs) do
			t.Page.Visible = false
			tween(t.Button, {BackgroundTransparency = 1, TextColor3 = THEME.SUBTEXT})
		end
		page.Visible = true
		tween(btn, {BackgroundTransparency = 0, TextColor3 = THEME.TEXT})
	end
	btn.MouseButton1Click:Connect(select)
	if #tabs == 1 then select() end
	return tab
end

--------------------------------------------------- elements
local function rowBase(page, height)
	local f = Instance.new("Frame", page)
	f.Size = UDim2.new(1, 0, 0, height)
	f.BackgroundColor3 = THEME.ELEMENT
	f.BorderSizePixel = 0
	corner(f, 8)
	stroke(f, THEME.STROKE)
	return f
end

local function label(parent, text, size, color)
	local l = Instance.new("TextLabel", parent)
	l.BackgroundTransparency = 1
	l.Font = THEME.FONT
	l.TextSize = size or 13
	l.TextColor3 = color or THEME.TEXT
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.Text = text
	return l
end

local function createToggle(page, name, default, callback)
	local f = rowBase(page, 38)
	local l = label(f, name)
	l.Size = UDim2.new(1, -70, 1, 0)
	l.Position = UDim2.new(0, 12, 0, 0)

	local track = Instance.new("TextButton", f)
	track.AnchorPoint = Vector2.new(1, 0.5)
	track.Position = UDim2.new(1, -12, 0.5, 0)
	track.Size = UDim2.new(0, 42, 0, 22)
	track.BackgroundColor3 = THEME.STROKE
	track.Text = ""
	track.AutoButtonColor = false
	corner(track, 11)

	local knob = Instance.new("Frame", track)
	knob.AnchorPoint = Vector2.new(0, 0.5)
	knob.Position = UDim2.new(0, 3, 0.5, 0)
	knob.Size = UDim2.new(0, 16, 0, 16)
	knob.BackgroundColor3 = THEME.TEXT
	knob.BorderSizePixel = 0
	corner(knob, 8)

	local state = default and true or false
	local api = {}
	function api:Set(v)
		state = v and true or false
		tween(track, {BackgroundColor3 = state and THEME.ACCENT or THEME.STROKE})
		tween(knob, {Position = state and UDim2.new(1, -19, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)})
		task.spawn(callback, state)
	end
	track.MouseButton1Click:Connect(function() api:Set(not state) end)
	if state then api:Set(true) end
	return api
end

local function createSlider(page, name, min, max, default, callback)
	local f = rowBase(page, 54)
	local l = label(f, name)
	l.Size = UDim2.new(1, -70, 0, 20)
	l.Position = UDim2.new(0, 12, 0, 6)

	local valLabel = label(f, tostring(default), 13, THEME.ACCENT)
	valLabel.AnchorPoint = Vector2.new(1, 0)
	valLabel.Position = UDim2.new(1, -12, 0, 6)
	valLabel.Size = UDim2.new(0, 50, 0, 20)
	valLabel.TextXAlignment = Enum.TextXAlignment.Right

	local bar = Instance.new("TextButton", f)
	bar.Position = UDim2.new(0, 12, 0, 34)
	bar.Size = UDim2.new(1, -24, 0, 8)
	bar.BackgroundColor3 = THEME.STROKE
	bar.Text = ""
	bar.AutoButtonColor = false
	corner(bar, 4)

	local fill = Instance.new("Frame", bar)
	fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	fill.BackgroundColor3 = THEME.ACCENT
	fill.BorderSizePixel = 0
	corner(fill, 4)

	local value = default
	local api = {}
	function api:Set(v)
		v = math.clamp(math.floor(v + 0.5), min, max)
		value = v
		valLabel.Text = tostring(v)
		fill.Size = UDim2.new((v - min) / (max - min), 0, 1, 0)
		task.spawn(callback, v)
	end

	local dragging = false
	local function update(input)
		local rel = (input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X
		api:Set(min + math.clamp(rel, 0, 1) * (max - min))
	end
	bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			update(input)
		end
	end)
	uis.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			update(input)
		end
	end)
	uis.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
	return api
end

local function createButton(page, name, callback)
	local b = Instance.new("TextButton", page)
	b.Size = UDim2.new(1, 0, 0, 34)
	b.BackgroundColor3 = THEME.ELEMENT
	b.Text = name
	b.Font = THEME.FONT
	b.TextSize = 13
	b.TextColor3 = THEME.TEXT
	b.AutoButtonColor = false
	corner(b, 8)
	stroke(b, THEME.STROKE)
	b.MouseEnter:Connect(function() tween(b, {BackgroundColor3 = THEME.ACCENT}) end)
	b.MouseLeave:Connect(function() tween(b, {BackgroundColor3 = THEME.ELEMENT}) end)
	b.MouseButton1Click:Connect(function() task.spawn(callback) end)
	return b
end

local function createSection(page, text)
	local l = label(page, text:upper(), 11, THEME.SUBTEXT)
	l.Size = UDim2.new(1, 0, 0, 16)
	l.Font = THEME.FONT_BOLD
	return l
end

--=========================================================
-- INVISIBILITY (reworked panel)
--=========================================================
local function setCharacterTransparency(character, transparency)
	for _, descendant in character:GetDescendants() do
		if descendant:IsA("BasePart") or descendant:IsA("Decal") then
			descendant.Transparency = transparency
		end
	end
end

local InvisPanel = Instance.new("Frame", ScreenGui)
InvisPanel.Name = "InvisPanel"
InvisPanel.AnchorPoint = Vector2.new(1, 0.5)
InvisPanel.Position = UDim2.new(1, -20, 0.5, 0)
InvisPanel.Size = UDim2.new(0, 190, 0, 120)
InvisPanel.BackgroundColor3 = THEME.BG
InvisPanel.BorderSizePixel = 0
InvisPanel.Active = true
InvisPanel.Draggable = true
InvisPanel.Visible = false
corner(InvisPanel, 10)
stroke(InvisPanel, THEME.STROKE)

local ipTitle = label(InvisPanel, "Invisibility", 13, THEME.TEXT)
ipTitle.Font = THEME.FONT_BOLD
ipTitle.Position = UDim2.new(0, 12, 0, 10)
ipTitle.Size = UDim2.new(1, -24, 0, 18)

local ipStatus = label(InvisPanel, "Status: Visible", 12, THEME.SUBTEXT)
ipStatus.Position = UDim2.new(0, 12, 0, 30)
ipStatus.Size = UDim2.new(1, -24, 0, 16)

local ipBtn = Instance.new("TextButton", InvisPanel)
ipBtn.Position = UDim2.new(0, 12, 0, 54)
ipBtn.Size = UDim2.new(1, -24, 0, 34)
ipBtn.BackgroundColor3 = THEME.ACCENT
ipBtn.Text = "GO INVISIBLE"
ipBtn.Font = THEME.FONT_BOLD
ipBtn.TextSize = 13
ipBtn.TextColor3 = Color3.new(1, 1, 1)
ipBtn.AutoButtonColor = false
corner(ipBtn, 8)

local ipHint = label(InvisPanel, "Drag to move • Ctrl+I toggles", 10, THEME.SUBTEXT)
ipHint.Position = UDim2.new(0, 12, 1, -24)
ipHint.Size = UDim2.new(1, -24, 0, 16)

local function applyInvisibility(enable)
	if not lp.Character then
		notify("No character found", THEME.DANGER)
		return
	end
	if enable then
		local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
		if not hrp then return end
		local savedPosition = hrp.CFrame
		lp.Character:MoveTo(INVIS_CONFIG.INVISIBILITY_POSITION)
		task.wait(0.15)
		local seat = Instance.new("Seat")
		seat.Name = "invischair"
		seat.Anchored = false
		seat.CanCollide = false
		seat.Transparency = 1
		seat.Position = INVIS_CONFIG.INVISIBILITY_POSITION
		seat.Parent = workspace
		local weld = Instance.new("Weld")
		weld.Part0 = seat
		weld.Part1 = lp.Character:FindFirstChild("Torso") or lp.Character:FindFirstChild("UpperTorso")
		weld.Parent = seat
		task.wait()
		seat.CFrame = savedPosition
		setCharacterTransparency(lp.Character, 0.5)
	else
		local invisChair = workspace:FindFirstChild("invischair")
		if invisChair then invisChair:Destroy() end
		setCharacterTransparency(lp.Character, 0)
	end
	playerState.isInvisible = enable
	ipStatus.Text = enable and "Status: Invisible" or "Status: Visible"
	ipStatus.TextColor3 = enable and THEME.SUCCESS or THEME.SUBTEXT
	ipBtn.Text = enable and "GO VISIBLE" or "GO INVISIBLE"
	tween(ipBtn, {BackgroundColor3 = enable and THEME.SUCCESS or THEME.ACCENT})
	notify(enable and "Invisibility enabled" or "Invisibility disabled", enable and THEME.SUCCESS or THEME.ACCENT)
end

local function toggleInvisibility()
	applyInvisibility(not playerState.isInvisible)
end

ipBtn.MouseButton1Click:Connect(toggleInvisibility)

--=========================================================
-- TABS / CONTENT
--=========================================================
local TabKill = createTab("Kill All")
createSection(TabKill.Page, "Combat")
createToggle(TabKill.Page, "Kill All", false, function(v)
	KILL_ALL_ON = v
	if v then updateRemoteCache() else cachedRemotes = {} end
	notify(v and ("Kill All ON (" .. #cachedRemotes .. " remotes)") or "Kill All OFF", v and THEME.DANGER or THEME.ACCENT)
end)
createButton(TabKill.Page, "Refresh Remote Cache", function()
	updateRemoteCache()
	notify("Cached " .. #cachedRemotes .. " remotes")
end)

local TabVisuals = createTab("Visuals")
createSection(TabVisuals.Page, "ESP & Hitbox")
createToggle(TabVisuals.Page, "ESP Players", false, function(v) ESP_ON = v end)
createToggle(TabVisuals.Page, "Enable Hitbox", false, function(v) HITBOX_ON = v end)
createSlider(TabVisuals.Page, "Hitbox Size", 1, 20, 5, function(v) HITBOX_SIZE = v end)

local TabMove = createTab("Movement")
createSection(TabMove.Page, "Speed")
local SpeedSlider = createSlider(TabMove.Page, "WalkSpeed", 16, 200, 16, function(v) WalkSpeedValue = v end)
createButton(TabMove.Page, "Reset Speed", function() SpeedSlider:Set(16) end)
createSection(TabMove.Page, "Abilities")
createToggle(TabMove.Page, "Infinite Jump", false, function(v) InfiniteJumpEnabled = v end)
createToggle(TabMove.Page, "Noclip", false, function(v) NoClipEnabled = v end)
createToggle(TabMove.Page, "Show Invisibility Panel", false, function(v) InvisPanel.Visible = v end)
createButton(TabMove.Page, "Toggle Invisibility", toggleInvisibility)
createButton(TabMove.Page, "Give TP Tool (Click TP)", function()
	local mouse = lp:GetMouse()
	local tool = Instance.new("Tool", lp.Backpack)
	tool.RequiresHandle = false
	tool.Name = "Click TP"
	tool.Activated:Connect(function()
		if lp.Character then lp.Character:MoveTo(mouse.Hit.p + Vector3.new(0, 3, 0)) end
	end)
	notify("Click TP tool added to backpack")
end)

local TabServer = createTab("Server")
createSection(TabServer.Page, "Teleports")
createButton(TabServer.Page, "Serverhop (Almost Full)", function()
	local api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
	local success, result = pcall(function() return game:HttpGet(api) end)
	if not success then
		notify("Serverhop request failed", THEME.DANGER)
		return
	end
	local serverList = http:JSONDecode(result)
	for _, server in pairs(serverList.data) do
		if server.playing >= (server.maxPlayers - 3) and server.playing < server.maxPlayers and server.id ~= game.JobId then
			notify("Teleporting...", THEME.SUCCESS)
			teleports:TeleportToPlaceInstance(game.PlaceId, server.id, lp)
			return
		end
	end
	notify("No matching server found", THEME.DANGER)
end)
createButton(TabServer.Page, "Rejoin Server", function()
	teleports:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
end)

local TabSettings = createTab("Settings")
createSection(TabSettings.Page, "Interface")
createButton(TabSettings.Page, "Reset UI Position", function()
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	InvisPanel.Position = UDim2.new(1, -20, 0.5, 0)
	notify("UI position reset")
end)
createButton(TabSettings.Page, "Unload Script", function()
	ESP_ON, HITBOX_ON, KILL_ALL_ON, NoClipEnabled, InfiniteJumpEnabled = false, false, false, false, false
	WalkSpeedValue = 16
	if playerState.isInvisible then applyInvisibility(false) end
	ScreenGui:Destroy()
end)
createSection(TabSettings.Page, "Info")
local info = label(TabSettings.Page, "RightShift: hide/show menu\nCtrl+I: toggle invisibility", 12, THEME.SUBTEXT)
info.Size = UDim2.new(1, 0, 0, 40)

--=========================================================
-- WINDOW CONTROLS / KEYBINDS
--=========================================================
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	TabBar.Visible = not minimized
	Pages.Visible = not minimized
	Subtitle.Visible = minimized
	tween(Main, {Size = minimized and UDim2.new(0, 560, 0, 44) or UDim2.new(0, 560, 0, 380)}, 0.2)
end)

CloseBtn.MouseButton1Click:Connect(function()
	Main.Visible = false
	notify("Press RightShift to reopen")
end)

uis.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		Main.Visible = not Main.Visible
	elseif input.KeyCode == Enum.KeyCode.I and uis:IsKeyDown(Enum.KeyCode.LeftControl) then
		toggleInvisibility()
	end
end)

uis.JumpRequest:Connect(function()
	if InfiniteJumpEnabled and lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
		lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
	end
end)

--=========================================================
-- LOOPS (original logic)
--=========================================================
task.spawn(function()
	while ScreenGui.Parent do
		task.wait(0.15)
		if KILL_ALL_ON and #cachedRemotes > 0 then
			local currentPlayers = players:GetPlayers()
			for i = 1, #currentPlayers do
				local v = currentPlayers[i]
				if not KILL_ALL_ON then break end
				if v ~= lp and v.Character and v.Character:FindFirstChild("Humanoid") then
					if v.Character.Humanoid.Health > 0 then
						for r = 1, #cachedRemotes do
							local remote = cachedRemotes[r]
							pcall(function()
								if remote and remote.Parent then
									remote:FireServer(v.Character)
									remote:FireServer(v)
									remote:FireServer(v.Character.Humanoid)
									remote:FireServer()
								end
							end)
						end
						task.wait(0.01)
					end
				end
			end
		end
	end
end)

runService.Stepped:Connect(function()
	if NoClipEnabled and lp.Character then
		for _, part in pairs(lp.Character:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then
				part.CanCollide = false
			end
		end
	end
end)

runService.RenderStepped:Connect(function()
	local allP = players:GetPlayers()
	for i = 1, #allP do
		local p = allP[i]
		if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = p.Character.HumanoidRootPart
			if HITBOX_ON and (p.Team ~= lp.Team or p.Team == nil) then
				hrp.Size = Vector3.new(HITBOX_SIZE, HITBOX_SIZE, HITBOX_SIZE)
				hrp.Transparency = ESP_ON and 0.7 or 1
				hrp.Color = Color3.new(1, 0, 1)
				hrp.CanCollide = false
			else
				hrp.Size = Vector3.new(2, 2, 1)
				hrp.Transparency = 1
			end
			if ESP_ON and (p.Team ~= lp.Team or p.Team == nil) then
				if not p.Character:FindFirstChild("Highlight") then
					Instance.new("Highlight", p.Character).FillColor = Color3.new(1, 0, 0)
				end
			elseif p.Character:FindFirstChild("Highlight") then
				p.Character.Highlight:Destroy()
			end
		end
	end

	if lp.Character and lp.Character:FindFirstChild("Humanoid") then
		lp.Character.Humanoid.WalkSpeed = WalkSpeedValue
	end
end)

notify("Loaded — RightShift to hide/show", THEME.SUCCESS)
