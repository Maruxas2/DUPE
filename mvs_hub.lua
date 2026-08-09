--[[
	murder vs sheriff 2026
	rewritten hub - shield bypass + card ui
]]

local Players     = game:GetService("Players")
local Replicated  = game:GetService("ReplicatedStorage")
local Workspace   = game:GetService("Workspace")
local RunService  = game:GetService("RunService")
local Input       = game:GetService("UserInputService")
local Tweens      = game:GetService("TweenService")
local Teleport    = game:GetService("TeleportService")
local HttpJson    = game:GetService("HttpService")

local client = Players.LocalPlayer

local state = {
	esp          = false,
	espBox       = true,
	hitbox       = false,
	hitboxHidden = false,
	hitboxSize   = 6,
	speed        = 16,
	noclip       = false,
	infJump      = false,
	killDelay    = 0.12,
	killOffset   = 4,
	killing      = false,
	invisible    = false,
	shield       = true,
}

local INVIS_POS = Vector3.new(-25.95, 84, 3537.55)

--=========================================================================
-- SHIELD : property spoofing anticheat bypass
--=========================================================================
-- rather than deleting detection scripts by name, every property this script
-- changes on a foreign instance is recorded and the original value is served
-- back to any reader that is not this script. detection code therefore sees
-- untouched parts while the local physics/render still use the new values.

local shield = {
	spoof   = setmetatable({}, {__mode = "k"}), -- instance -> {prop = originalValue}
	blocked = 0,
	hooks   = {},
}

local function shieldRemember(inst, prop, original)
	local entry = shield.spoof[inst]
	if not entry then
		entry = {}
		shield.spoof[inst] = entry
	end
	if entry[prop] == nil then
		entry[prop] = original
	end
end

local function shieldForget(inst)
	shield.spoof[inst] = nil
end

-- write a property while keeping the pre-change value for readers
local function shieldSet(inst, prop, value)
	local ok, current = pcall(function() return inst[prop] end)
	if not ok then return false end
	if current == value then return true end
	shieldRemember(inst, prop, current)
	return pcall(function() inst[prop] = value end)
end

-- restore everything written through shieldSet on an instance
local function shieldRestore(inst)
	local entry = shield.spoof[inst]
	if not entry then return end
	for prop, original in pairs(entry) do
		pcall(function() inst[prop] = original end)
	end
	shield.spoof[inst] = nil
end

local function shieldRestoreAll()
	for inst in pairs(shield.spoof) do
		shieldRestore(inst)
	end
end

local function installShield()
	if not (getrawmetatable and hookmetamethod and checkcaller and getnamecallmethod) then
		return false
	end

	-- reads: hand back the original value to foreign callers
	local oldIndex
	oldIndex = hookmetamethod(game, "__index", function(self, key)
		if state.shield and not checkcaller() then
			local entry = shield.spoof[self]
			if entry ~= nil and entry[key] ~= nil then
				shield.blocked = shield.blocked + 1
				return entry[key]
			end
		end
		return oldIndex(self, key)
	end)
	shield.hooks.index = oldIndex

	-- calls: drop kicks and teleport-outs coming from game code
	local oldNamecall
	oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
		if state.shield and not checkcaller() then
			local method = getnamecallmethod()

			if method == "Kick" then
				shield.blocked = shield.blocked + 1
				return
			end

			if method == "TeleportToPlaceInstance" or method == "Teleport" then
				if self == Teleport then
					shield.blocked = shield.blocked + 1
					return
				end
			end

			-- foreign code asking for a spoofed property through GetPropertyChangedSignal
			if method == "GetPropertyChangedSignal" then
				local prop = ...
				local entry = shield.spoof[self]
				if entry ~= nil and entry[prop] ~= nil then
					shield.blocked = shield.blocked + 1
					return Instance.new("BindableEvent").Event
				end
			end
		end
		return oldNamecall(self, ...)
	end)
	shield.hooks.namecall = oldNamecall

	-- writes: refuse resets of properties we own
	if newcclosure and hookfunction then
		pcall(function()
			local meta = getrawmetatable(game)
			local oldNewIndex = meta.__newindex
			if setreadonly then setreadonly(meta, false) end
			meta.__newindex = newcclosure(function(self, key, value)
				if state.shield and not checkcaller() then
					local entry = shield.spoof[self]
					if entry ~= nil and entry[key] ~= nil then
						shield.blocked = shield.blocked + 1
						entry[key] = value -- keep the spoofed read in sync
						return
					end
				end
				return oldNewIndex(self, key, value)
			end)
			if setreadonly then setreadonly(meta, true) end
			shield.hooks.newindex = oldNewIndex
		end)
	end

	-- afk kicker
	pcall(function()
		if getconnections then
			for _, conn in ipairs(getconnections(client.Idled)) do
				conn:Disable()
			end
		end
	end)

	return true
end

local shieldActive = false
pcall(function() shieldActive = installShield() end)

--=========================================================================
-- kill remotes
--=========================================================================
local killRemotes = {}
local function scanKillRemotes()
	killRemotes = {}
	local roots = {Replicated, Workspace, client.Backpack}
	if client.Character then table.insert(roots, client.Character) end
	for _, root in ipairs(roots) do
		pcall(function()
			for _, obj in ipairs(root:GetDescendants()) do
				if obj:IsA("RemoteEvent") then
					local n = obj.Name:lower()
					if n:find("kill") or n:find("knife") or n:find("stab") or n:find("damage") or n:find("hit") then
						table.insert(killRemotes, obj)
					end
				end
			end
		end)
	end
	return #killRemotes
end

--=========================================================================
-- UI TOOLKIT
--=========================================================================
local palette = {
	shell    = Color3.fromRGB(16, 17, 22),
	shellAlt = Color3.fromRGB(23, 24, 31),
	card     = Color3.fromRGB(29, 31, 39),
	cardHov  = Color3.fromRGB(37, 39, 49),
	edge     = Color3.fromRGB(46, 49, 61),
	ink      = Color3.fromRGB(232, 234, 240),
	inkSoft  = Color3.fromRGB(138, 143, 158),
	live     = Color3.fromRGB(255, 106, 92),
	ok       = Color3.fromRGB(96, 200, 140),
}
local UI_FONT = Enum.Font.GothamMedium
local UI_FONT_BOLD = Enum.Font.GothamSemibold

local function corner(inst, r)
	local c = Instance.new("UICorner", inst)
	c.CornerRadius = UDim.new(0, r or 6)
	return c
end

local function border(inst, color)
	local s = Instance.new("UIStroke", inst)
	s.Color = color or palette.edge
	s.Thickness = 1
	return s
end

local function pad(inst, all)
	local p = Instance.new("UIPadding", inst)
	p.PaddingTop = UDim.new(0, all)
	p.PaddingBottom = UDim.new(0, all)
	p.PaddingLeft = UDim.new(0, all)
	p.PaddingRight = UDim.new(0, all)
	return p
end

local function glide(inst, props, dur)
	local t = Tweens:Create(inst, TweenInfo.new(dur or 0.14, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props)
	t:Play()
	return t
end

local function dragBy(target, grip)
	local active, origin, base = false, nil, nil
	grip.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			active, origin, base = true, i.Position, target.Position
			i.Changed:Connect(function()
				if i.UserInputState == Enum.UserInputState.End then active = false end
			end)
		end
	end)
	Input.InputChanged:Connect(function(i)
		if not active then return end
		if i.UserInputType ~= Enum.UserInputType.MouseMovement and i.UserInputType ~= Enum.UserInputType.Touch then return end
		local d = i.Position - origin
		target.Position = UDim2.new(base.X.Scale, base.X.Offset + d.X, base.Y.Scale, base.Y.Offset + d.Y)
	end)
end

local screen = Instance.new("ScreenGui")
screen.Name = "mvs_hub"
screen.ResetOnSpawn = false
screen.IgnoreGuiInset = true
screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screen.Parent = (gethui and gethui()) or game:GetService("CoreGui")

--------------------------------------------------------------- status log
local logHolder = Instance.new("Frame", screen)
logHolder.AnchorPoint = Vector2.new(0.5, 1)
logHolder.Position = UDim2.new(0.5, 0, 1, -18)
logHolder.Size = UDim2.new(0, 300, 0, 120)
logHolder.BackgroundTransparency = 1
local logLayout = Instance.new("UIListLayout", logHolder)
logLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
logLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
logLayout.Padding = UDim.new(0, 6)

local function log(text, color)
	local pill = Instance.new("Frame", logHolder)
	pill.AutomaticSize = Enum.AutomaticSize.X
	pill.Size = UDim2.new(0, 0, 0, 28)
	pill.BackgroundColor3 = palette.shellAlt
	corner(pill, 14)
	border(pill, color or palette.edge)
	local layout = Instance.new("UIListLayout", pill)
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.Padding = UDim.new(0, 8)
	local lp2 = Instance.new("UIPadding", pill)
	lp2.PaddingLeft = UDim.new(0, 12)
	lp2.PaddingRight = UDim.new(0, 14)

	local dot = Instance.new("Frame", pill)
	dot.Size = UDim2.new(0, 6, 0, 6)
	dot.BackgroundColor3 = color or palette.live
	corner(dot, 3)

	local label = Instance.new("TextLabel", pill)
	label.AutomaticSize = Enum.AutomaticSize.X
	label.Size = UDim2.new(0, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Font = UI_FONT
	label.TextSize = 12
	label.TextColor3 = palette.ink
	label.Text = text

	pill.BackgroundTransparency = 1
	label.TextTransparency = 1
	glide(pill, {BackgroundTransparency = 0}, 0.16)
	glide(label, {TextTransparency = 0}, 0.16)
	task.delay(2.6, function()
		glide(pill, {BackgroundTransparency = 1}, 0.2)
		glide(label, {TextTransparency = 1}, 0.2)
		task.wait(0.24)
		pill:Destroy()
	end)
end

--------------------------------------------------------------- shell
local shell = Instance.new("Frame", screen)
shell.AnchorPoint = Vector2.new(0.5, 0.5)
shell.Position = UDim2.new(0.5, 0, 0.5, 0)
shell.Size = UDim2.new(0, 560, 0, 400)
shell.BackgroundColor3 = palette.shell
shell.BorderSizePixel = 0
shell.ClipsDescendants = true
corner(shell, 10)
border(shell)

local head = Instance.new("Frame", shell)
head.Size = UDim2.new(1, 0, 0, 76)
head.BackgroundColor3 = palette.shellAlt
head.BorderSizePixel = 0

local brand = Instance.new("TextLabel", head)
brand.Position = UDim2.new(0, 20, 0, 14)
brand.Size = UDim2.new(0, 300, 0, 20)
brand.BackgroundTransparency = 1
brand.Font = UI_FONT_BOLD
brand.TextSize = 16
brand.TextXAlignment = Enum.TextXAlignment.Left
brand.TextColor3 = palette.ink
brand.Text = "MURDER VS SHERIFF"

local tagline = Instance.new("TextLabel", head)
tagline.Position = UDim2.new(0, 20, 0, 36)
tagline.Size = UDim2.new(0, 320, 0, 16)
tagline.BackgroundTransparency = 1
tagline.Font = UI_FONT
tagline.TextSize = 12
tagline.TextXAlignment = Enum.TextXAlignment.Left
tagline.TextColor3 = palette.inkSoft
tagline.Text = "shield loading"

local function headButton(symbol, offset)
	local b = Instance.new("TextButton", head)
	b.AnchorPoint = Vector2.new(1, 0)
	b.Position = UDim2.new(1, offset, 0, 14)
	b.Size = UDim2.new(0, 24, 0, 24)
	b.BackgroundColor3 = palette.card
	b.BorderSizePixel = 0
	b.Text = symbol
	b.Font = UI_FONT_BOLD
	b.TextSize = 12
	b.TextColor3 = palette.inkSoft
	b.AutoButtonColor = false
	corner(b, 6)
	b.MouseEnter:Connect(function() glide(b, {BackgroundColor3 = palette.cardHov, TextColor3 = palette.ink}) end)
	b.MouseLeave:Connect(function() glide(b, {BackgroundColor3 = palette.card, TextColor3 = palette.inkSoft}) end)
	return b
end

local hideBtn = headButton("—", -52)
local killBtn = headButton("✕", -20)

dragBy(shell, head)

--------------------------------------------------------------- top tab strip
local strip = Instance.new("Frame", head)
strip.AnchorPoint = Vector2.new(0, 1)
strip.Position = UDim2.new(0, 16, 1, 0)
strip.Size = UDim2.new(1, -32, 0, 30)
strip.BackgroundTransparency = 1
local stripLayout = Instance.new("UIListLayout", strip)
stripLayout.FillDirection = Enum.FillDirection.Horizontal
stripLayout.Padding = UDim.new(0, 4)

local body = Instance.new("Frame", shell)
body.Position = UDim2.new(0, 0, 0, 76)
body.Size = UDim2.new(1, 0, 1, -76)
body.BackgroundTransparency = 1
body.ClipsDescendants = true

local sections = {}
local function section(name)
	local tab = Instance.new("TextButton", strip)
	tab.AutomaticSize = Enum.AutomaticSize.X
	tab.Size = UDim2.new(0, 0, 1, 0)
	tab.BackgroundColor3 = palette.shell
	tab.BackgroundTransparency = 1
	tab.BorderSizePixel = 0
	tab.Text = name
	tab.Font = UI_FONT
	tab.TextSize = 12
	tab.TextColor3 = palette.inkSoft
	tab.AutoButtonColor = false
	corner(tab, 6)
	local tp = Instance.new("UIPadding", tab)
	tp.PaddingLeft = UDim.new(0, 14)
	tp.PaddingRight = UDim.new(0, 14)

	local underline = Instance.new("Frame", tab)
	underline.AnchorPoint = Vector2.new(0.5, 1)
	underline.Position = UDim2.new(0.5, 0, 1, 0)
	underline.Size = UDim2.new(0, 0, 0, 2)
	underline.BackgroundColor3 = palette.live
	underline.BorderSizePixel = 0

	local view = Instance.new("ScrollingFrame", body)
	view.Size = UDim2.new(1, 0, 1, 0)
	view.BackgroundTransparency = 1
	view.BorderSizePixel = 0
	view.ScrollBarThickness = 2
	view.ScrollBarImageColor3 = palette.edge
	view.CanvasSize = UDim2.new()
	view.AutomaticCanvasSize = Enum.AutomaticSize.Y
	view.Visible = false
	local grid = Instance.new("UIListLayout", view)
	grid.Padding = UDim.new(0, 10)
	pad(view, 16)

	local entry = {tab = tab, view = view, underline = underline, active = false}
	table.insert(sections, entry)

	local function show()
		for _, s in ipairs(sections) do
			s.view.Visible = false
			s.active = false
			glide(s.tab, {BackgroundTransparency = 1, TextColor3 = palette.inkSoft})
			glide(s.underline, {Size = UDim2.new(0, 0, 0, 2)})
		end
		entry.active = true
		view.Visible = true
		glide(tab, {BackgroundTransparency = 0.5, TextColor3 = palette.ink})
		glide(underline, {Size = UDim2.new(1, -18, 0, 2)})
	end
	tab.MouseButton1Click:Connect(show)
	tab.MouseEnter:Connect(function()
		if not entry.active then glide(tab, {TextColor3 = palette.ink}) end
	end)
	tab.MouseLeave:Connect(function()
		if not entry.active then glide(tab, {TextColor3 = palette.inkSoft}) end
	end)
	if #sections == 1 then task.defer(show) end
	return view
end

--------------------------------------------------------------- cards
local function card(view, titleText, subText, height)
	local frame = Instance.new("Frame", view)
	frame.Size = UDim2.new(1, 0, 0, height)
	frame.BackgroundColor3 = palette.card
	frame.BorderSizePixel = 0
	corner(frame, 8)
	border(frame)

	local title = Instance.new("TextLabel", frame)
	title.Position = UDim2.new(0, 14, 0, 10)
	title.Size = UDim2.new(1, -110, 0, 16)
	title.BackgroundTransparency = 1
	title.Font = UI_FONT
	title.TextSize = 13
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.TextColor3 = palette.ink
	title.Text = titleText

	local sub
	if subText then
		sub = Instance.new("TextLabel", frame)
		sub.Position = UDim2.new(0, 14, 0, 28)
		sub.Size = UDim2.new(1, -110, 0, 14)
		sub.BackgroundTransparency = 1
		sub.Font = UI_FONT
		sub.TextSize = 11
		sub.TextXAlignment = Enum.TextXAlignment.Left
		sub.TextColor3 = palette.inkSoft
		sub.Text = subText
	end

	return frame, title, sub
end

local function switch(view, name, desc, default, callback)
	local frame = card(view, name, desc, desc and 52 or 40)

	local pill = Instance.new("TextButton", frame)
	pill.AnchorPoint = Vector2.new(1, 0.5)
	pill.Position = UDim2.new(1, -14, 0.5, 0)
	pill.Size = UDim2.new(0, 62, 0, 24)
	pill.BackgroundColor3 = palette.shell
	pill.BorderSizePixel = 0
	pill.Text = ""
	pill.AutoButtonColor = false
	corner(pill, 6)
	local pillEdge = border(pill)

	local word = Instance.new("TextLabel", pill)
	word.Size = UDim2.new(1, 0, 1, 0)
	word.BackgroundTransparency = 1
	word.Font = UI_FONT
	word.TextSize = 11
	word.TextColor3 = palette.inkSoft
	word.Text = "OFF"

	local on = default and true or false
	local api = {}
	function api:Set(v)
		on = v and true or false
		word.Text = on and "ON" or "OFF"
		glide(word, {TextColor3 = on and palette.ink or palette.inkSoft})
		glide(pillEdge, {Color = on and palette.live or palette.edge})
		glide(pill, {BackgroundColor3 = on and palette.cardHov or palette.shell})
		task.spawn(callback, on)
	end
	pill.MouseButton1Click:Connect(function() api:Set(not on) end)
	if on then api:Set(true) end
	return api
end

local function dial(view, name, desc, min, max, default, step, callback)
	local frame = card(view, name, desc, 66)

	local readout = Instance.new("TextLabel", frame)
	readout.AnchorPoint = Vector2.new(1, 0)
	readout.Position = UDim2.new(1, -14, 0, 10)
	readout.Size = UDim2.new(0, 60, 0, 16)
	readout.BackgroundTransparency = 1
	readout.Font = UI_FONT_BOLD
	readout.TextSize = 13
	readout.TextXAlignment = Enum.TextXAlignment.Right
	readout.TextColor3 = palette.live
	readout.Text = tostring(default)

	local rail = Instance.new("TextButton", frame)
	rail.AnchorPoint = Vector2.new(0, 1)
	rail.Position = UDim2.new(0, 14, 1, -12)
	rail.Size = UDim2.new(1, -28, 0, 6)
	rail.BackgroundColor3 = palette.shell
	rail.BorderSizePixel = 0
	rail.Text = ""
	rail.AutoButtonColor = false
	corner(rail, 3)

	local done = Instance.new("Frame", rail)
	done.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	done.BackgroundColor3 = palette.live
	done.BorderSizePixel = 0
	corner(done, 3)

	local grip = Instance.new("Frame", rail)
	grip.AnchorPoint = Vector2.new(0.5, 0.5)
	grip.Position = UDim2.new((default - min) / (max - min), 0, 0.5, 0)
	grip.Size = UDim2.new(0, 12, 0, 12)
	grip.BackgroundColor3 = palette.ink
	grip.BorderSizePixel = 0
	grip.ZIndex = 2
	corner(grip, 6)

	local api = {}
	function api:Set(v)
		v = math.clamp(math.floor(v / step + 0.5) * step, min, max)
		if step < 1 then
			readout.Text = string.format("%.2f", v)
		else
			readout.Text = tostring(v)
		end
		local a = (v - min) / (max - min)
		done.Size = UDim2.new(a, 0, 1, 0)
		grip.Position = UDim2.new(a, 0, 0.5, 0)
		task.spawn(callback, v)
	end

	local holding = false
	local function seek(i)
		local a = (i.Position.X - rail.AbsolutePosition.X) / rail.AbsoluteSize.X
		api:Set(min + math.clamp(a, 0, 1) * (max - min))
	end
	rail.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			holding = true
			seek(i)
		end
	end)
	Input.InputChanged:Connect(function(i)
		if holding and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			seek(i)
		end
	end)
	Input.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			holding = false
		end
	end)
	return api
end

local function action(view, name, desc, actionText, callback)
	local frame = card(view, name, desc, desc and 52 or 40)

	local go = Instance.new("TextButton", frame)
	go.AnchorPoint = Vector2.new(1, 0.5)
	go.Position = UDim2.new(1, -14, 0.5, 0)
	go.Size = UDim2.new(0, 76, 0, 26)
	go.BackgroundColor3 = palette.shell
	go.BorderSizePixel = 0
	go.Text = actionText or "RUN"
	go.Font = UI_FONT
	go.TextSize = 11
	go.TextColor3 = palette.ink
	go.AutoButtonColor = false
	corner(go, 6)
	local goEdge = border(go)
	go.MouseEnter:Connect(function()
		glide(go, {BackgroundColor3 = palette.cardHov})
		glide(goEdge, {Color = palette.live})
	end)
	go.MouseLeave:Connect(function()
		glide(go, {BackgroundColor3 = palette.shell})
		glide(goEdge, {Color = palette.edge})
	end)
	go.MouseButton1Click:Connect(function() task.spawn(callback) end)
	return go
end

local function readoutCard(view, titleText)
	local frame, _, sub = card(view, titleText, " ", 62)
	return sub
end

--------------------------------------------------------------- launcher pill
local launcher = Instance.new("TextButton", screen)
launcher.AnchorPoint = Vector2.new(0, 0)
launcher.Position = UDim2.new(0, 20, 0, 20)
launcher.Size = UDim2.new(0, 96, 0, 30)
launcher.BackgroundColor3 = palette.shellAlt
launcher.BorderSizePixel = 0
launcher.Text = "open hub"
launcher.Font = UI_FONT
launcher.TextSize = 12
launcher.TextColor3 = palette.ink
launcher.AutoButtonColor = false
launcher.Visible = false
corner(launcher, 15)
border(launcher, palette.live)
dragBy(launcher, launcher)
launcher.MouseButton1Click:Connect(function()
	shell.Visible = true
	launcher.Visible = false
end)

--=========================================================================
-- HITBOX
--=========================================================================
local function foe(p)
	if p == client then return false end
	if p.Team == nil or client.Team == nil then return true end
	return p.Team ~= client.Team
end

local function hitboxPart(char)
	return char and char:FindFirstChild("HumanoidRootPart")
end

local function pushHitbox(part)
	local size = state.hitboxSize
	shieldSet(part, "Size", Vector3.new(size, size, size))
	shieldSet(part, "CanCollide", false)
	shieldSet(part, "Massless", true)
	if state.hitboxHidden then
		shieldSet(part, "Transparency", 1)
	else
		shieldSet(part, "Transparency", 0.6)
		shieldSet(part, "Material", Enum.Material.ForceField)
		shieldSet(part, "Color", palette.live)
	end
end

--=========================================================================
-- KILL ALL : teleport + knife swing
--=========================================================================
local function heldTool()
	local char = client.Character
	if not char then return nil end
	local equipped = char:FindFirstChildOfClass("Tool")
	if equipped then return equipped end
	local hum = char:FindFirstChildOfClass("Humanoid")
	for _, t in ipairs(client.Backpack:GetChildren()) do
		if t:IsA("Tool") then
			if hum then pcall(function() hum:EquipTool(t) end) end
			return char:FindFirstChildOfClass("Tool")
		end
	end
	return nil
end

local function swing(target)
	local tool = heldTool()
	if tool then
		pcall(function() tool:Activate() end)
		task.wait(0.05)
		pcall(function() tool:Activate() end)
	end
	for _, remote in ipairs(killRemotes) do
		pcall(function()
			if remote.Parent then
				remote:FireServer(target.Character)
				remote:FireServer(target)
				remote:FireServer(target.Character:FindFirstChildOfClass("Humanoid"))
				remote:FireServer()
			end
		end)
	end
end

local function killAll()
	if state.killing then
		log("already running")
		return
	end
	local char = client.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if not root then
		log("no character", palette.live)
		return
	end

	state.killing = true
	scanKillRemotes()
	local home = root.CFrame
	local count = 0

	for _, p in ipairs(Players:GetPlayers()) do
		if not state.killing then break end
		if foe(p) and p.Character then
			local hum = p.Character:FindFirstChildOfClass("Humanoid")
			local theirRoot = p.Character:FindFirstChild("HumanoidRootPart")
			if hum and theirRoot and hum.Health > 0 then
				root.CFrame = theirRoot.CFrame * CFrame.new(0, 0, state.killOffset) * CFrame.Angles(0, math.pi, 0)
				task.wait(state.killDelay)
				swing(p)
				count = count + 1
				task.wait(state.killDelay)
			end
		end
	end

	local back = client.Character and client.Character:FindFirstChild("HumanoidRootPart")
	if back then back.CFrame = home end
	state.killing = false
	log("hit " .. count .. " target(s)", palette.ok)
end

--=========================================================================
-- INVISIBILITY
--=========================================================================
local function bodyTransparency(char, t)
	for _, d in ipairs(char:GetDescendants()) do
		if d:IsA("BasePart") or d:IsA("Decal") then
			d.Transparency = t
		end
	end
end

local invisStatusLabel
local function setInvisible(on)
	local char = client.Character
	if not char then
		log("no character", palette.live)
		return
	end
	if on then
		local root = char:FindFirstChild("HumanoidRootPart")
		if not root then return end
		local home = root.CFrame
		char:MoveTo(INVIS_POS)
		task.wait(0.15)
		local seat = Instance.new("Seat")
		seat.Name = "invischair"
		seat.Anchored = false
		seat.CanCollide = false
		seat.Transparency = 1
		seat.Position = INVIS_POS
		seat.Parent = Workspace
		local weld = Instance.new("Weld")
		weld.Part0 = seat
		weld.Part1 = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
		weld.Parent = seat
		task.wait()
		seat.CFrame = home
		bodyTransparency(char, 0.5)
	else
		local chair = Workspace:FindFirstChild("invischair")
		if chair then chair:Destroy() end
		bodyTransparency(char, 0)
	end
	state.invisible = on
	if invisStatusLabel then
		invisStatusLabel.Text = on and "currently invisible to other players" or "currently visible"
		invisStatusLabel.TextColor3 = on and palette.ok or palette.inkSoft
	end
	log(on and "invisible" or "visible", on and palette.ok or palette.live)
end

--=========================================================================
-- SECTIONS
--=========================================================================
local combatView = section("combat")
action(combatView, "kill all", "teleports behind every enemy and swings your knife", "EXECUTE", killAll)
action(combatView, "abort", "stops the current kill all run", "STOP", function()
	state.killing = false
	log("aborted")
end)
dial(combatView, "swing delay", "pause between each target", 0.05, 1, 0.12, 0.01, function(v) state.killDelay = v end)
dial(combatView, "stand off", "studs behind the target when teleporting", 1, 10, 4, 1, function(v) state.killOffset = v end)
action(combatView, "rescan remotes", "refresh the damage remote list", "SCAN", function()
	log("found " .. scanKillRemotes() .. " remotes", palette.ok)
end)

local hitboxView = section("hitbox")
switch(hitboxView, "expand hitboxes", "grows enemy root parts, reads stay spoofed", false, function(v)
	state.hitbox = v
	if not v then shieldRestoreAll() end
end)
switch(hitboxView, "hide hitboxes", "keeps them fully transparent while active", false, function(v)
	state.hitboxHidden = v
	shieldRestoreAll()
end)
dial(hitboxView, "hitbox size", "studs per axis", 1, 30, 6, 1, function(v)
	state.hitboxSize = v
	shieldRestoreAll()
end)

local visualView = section("visuals")
switch(visualView, "player esp", "highlights every enemy through walls", false, function(v)
	state.esp = v
	if not v then
		for _, p in ipairs(Players:GetPlayers()) do
			if p.Character then
				local h = p.Character:FindFirstChildOfClass("Highlight")
				if h then h:Destroy() end
			end
		end
	end
end)

local moveView = section("movement")
local speedDial = dial(moveView, "walk speed", nil, 16, 250, 16, 1, function(v) state.speed = v end)
action(moveView, "reset speed", nil, "16", function() speedDial:Set(16) end)
switch(moveView, "infinite jump", nil, false, function(v) state.infJump = v end)
switch(moveView, "noclip", "disables collision on your character", false, function(v) state.noclip = v end)
action(moveView, "click teleport tool", "adds a tool that teleports you to your cursor", "GIVE", function()
	local mouse = client:GetMouse()
	local tool = Instance.new("Tool", client.Backpack)
	tool.RequiresHandle = false
	tool.Name = "Click TP"
	tool.Activated:Connect(function()
		if client.Character then client.Character:MoveTo(mouse.Hit.p + Vector3.new(0, 3, 0)) end
	end)
	log("tool added", palette.ok)
end)

local invisView = section("invisible")
invisStatusLabel = readoutCard(invisView, "state")
invisStatusLabel.Text = "currently visible"
action(invisView, "toggle invisibility", "seat trick, ctrl+i also works", "TOGGLE", function()
	setInvisible(not state.invisible)
end)

local serverView = section("server")
action(serverView, "serverhop", "jumps to a nearly full public server", "HOP", function()
	local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
	local ok, res = pcall(function() return game:HttpGet(url) end)
	if not ok then
		log("request failed", palette.live)
		return
	end
	for _, s in pairs(HttpJson:JSONDecode(res).data) do
		if s.playing >= (s.maxPlayers - 3) and s.playing < s.maxPlayers and s.id ~= game.JobId then
			log("teleporting", palette.ok)
			state.shield = false -- let our own teleport through
			Teleport:TeleportToPlaceInstance(game.PlaceId, s.id, client)
			return
		end
	end
	log("nothing available", palette.live)
end)
action(serverView, "rejoin", nil, "REJOIN", function()
	state.shield = false
	Teleport:TeleportToPlaceInstance(game.PlaceId, game.JobId, client)
end)

local shieldView = section("shield")
local shieldReadout = readoutCard(shieldView, "shield status")
switch(shieldView, "property shield", "serves original values to detection code", true, function(v)
	state.shield = v
end)
action(shieldView, "unload hub", "restores everything and removes the ui", "UNLOAD", function()
	state.esp, state.hitbox, state.noclip, state.infJump, state.killing = false, false, false, false, false
	state.speed = 16
	shieldRestoreAll()
	if state.invisible then setInvisible(false) end
	state.shield = false
	screen:Destroy()
end)

--=========================================================================
-- HEAD CONTROLS / KEYS
--=========================================================================
local collapsed = false
hideBtn.MouseButton1Click:Connect(function()
	collapsed = not collapsed
	body.Visible = not collapsed
	glide(shell, {Size = collapsed and UDim2.new(0, 560, 0, 76) or UDim2.new(0, 560, 0, 400)}, 0.18)
end)

killBtn.MouseButton1Click:Connect(function()
	shell.Visible = false
	launcher.Visible = true
end)

Input.InputBegan:Connect(function(i, typing)
	if typing then return end
	if i.KeyCode == Enum.KeyCode.RightShift then
		shell.Visible = not shell.Visible
		launcher.Visible = not shell.Visible
	elseif i.KeyCode == Enum.KeyCode.I and Input:IsKeyDown(Enum.KeyCode.LeftControl) then
		setInvisible(not state.invisible)
	end
end)

Input.JumpRequest:Connect(function()
	if not state.infJump then return end
	local char = client.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

--=========================================================================
-- LOOPS
--=========================================================================
RunService.Stepped:Connect(function()
	if not state.noclip then return end
	local char = client.Character
	if not char then return end
	for _, part in ipairs(char:GetDescendants()) do
		if part:IsA("BasePart") and part.CanCollide then
			part.CanCollide = false
		end
	end
end)

RunService.Heartbeat:Connect(function()
	for _, p in ipairs(Players:GetPlayers()) do
		local char = p.Character
		if char then
			local part = hitboxPart(char)
			if part then
				if state.hitbox and foe(p) then
					pcall(pushHitbox, part)
				elseif shield.spoof[part] then
					shieldRestore(part)
				end
			end

			if state.esp and foe(p) then
				if not char:FindFirstChildOfClass("Highlight") then
					local hl = Instance.new("Highlight")
					hl.FillColor = palette.live
					hl.OutlineColor = palette.ink
					hl.FillTransparency = 0.55
					hl.Parent = char
				end
			else
				local hl = char:FindFirstChildOfClass("Highlight")
				if hl then hl:Destroy() end
			end
		end
	end

	local char = client.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum and hum.WalkSpeed ~= state.speed then
		hum.WalkSpeed = state.speed
	end
end)

client.CharacterAdded:Connect(function()
	task.wait(1)
	scanKillRemotes()
	if state.shield then
		pcall(function()
			if getconnections then
				for _, conn in ipairs(getconnections(client.Idled)) do
					conn:Disable()
				end
			end
		end)
	end
end)

Players.PlayerRemoving:Connect(function(p)
	if p.Character then
		local part = hitboxPart(p.Character)
		if part then shieldForget(part) end
	end
end)

task.spawn(function()
	while screen.Parent do
		local line = (state.shield and "shield on" or "shield off")
			.. " | " .. (shieldActive and "hooks installed" or "hooks unsupported")
			.. " | reads spoofed: " .. shield.blocked
		tagline.Text = line
		if shieldReadout then shieldReadout.Text = line end
		task.wait(1)
	end
end)

scanKillRemotes()
log(shieldActive and "hub loaded, shield armed" or "hub loaded, executor lacks hooks", shieldActive and palette.ok or palette.live)
