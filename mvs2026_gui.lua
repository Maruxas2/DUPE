-- murder vs sheriff 2026
-- combat / visuals / movement / server

local players    = game:GetService("Players")
local rs         = game:GetService("ReplicatedStorage")
local ws         = game:GetService("Workspace")
local teleports  = game:GetService("TeleportService")
local runService = game:GetService("RunService")
local uis        = game:GetService("UserInputService")
local tweenServ  = game:GetService("TweenService")
local http       = game:GetService("HttpService")
local lp         = players.LocalPlayer

local esp          = false
local hitboxOn     = false
local hitboxInvis  = false
local hitboxSafe   = true
local hitboxSize   = 5
local walkSpeed    = 16
local noclip       = false
local infJump      = false
local killDelay    = 0.12
local killRange    = 4
local isKilling    = false
local isInvisible  = false

local INVIS_POS = Vector3.new(-25.95, 84, 3537.55)

local col = {
	bg      = Color3.fromRGB(20, 20, 20),
	bar     = Color3.fromRGB(28, 28, 28),
	item    = Color3.fromRGB(35, 35, 35),
	itemHov = Color3.fromRGB(45, 45, 45),
	line    = Color3.fromRGB(55, 55, 55),
	text    = Color3.fromRGB(225, 225, 225),
	dim     = Color3.fromRGB(135, 135, 135),
	accent  = Color3.fromRGB(200, 55, 55),
	good    = Color3.fromRGB(70, 175, 95),
}
local FONT = Enum.Font.Gotham
local FONT_B = Enum.Font.GothamBold

--=========================================================
-- anticheat bypass
--=========================================================
local AC_WORDS = {
	"bac", "anti", "check", "detect", "security", "kick", "adonis", "adonnis",
	"sentinel", "ban", "report", "flag", "exploit", "cheat", "validate", "verify",
	"hitbox", "sizecheck", "integrity", "guard", "watchdog",
}

local bypassOn = true
local blockedCount = 0

local function matchesAC(name)
	name = tostring(name):lower()
	for _, w in ipairs(AC_WORDS) do
		if name:find(w, 1, true) then return true end
	end
	return false
end

-- disable / destroy detection scripts
local function purgeScripts()
	local removed = 0
	for _, v in ipairs(game:GetDescendants()) do
		pcall(function()
			if v:IsA("LocalScript") or v:IsA("ModuleScript") then
				if matchesAC(v.Name) or matchesAC(v.Parent and v.Parent.Name or "") then
					v.Disabled = true
					v:Destroy()
					removed = removed + 1
				end
			end
		end)
	end
	return removed
end
pcall(purgeScripts)

-- keep purging newly streamed-in detection scripts
game.DescendantAdded:Connect(function(v)
	if not bypassOn then return end
	if v:IsA("LocalScript") or v:IsA("ModuleScript") then
		task.defer(function()
			pcall(function()
				if matchesAC(v.Name) or matchesAC(v.Parent and v.Parent.Name or "") then
					v.Disabled = true
					v:Destroy()
					blockedCount = blockedCount + 1
				end
			end)
		end)
	end
end)

-- block client-side Kick() and anticheat remote traffic
local namecallHooked = false
pcall(function()
	if not (hookmetamethod and getnamecallmethod and checkcaller) then return end
	local oldNamecall
	oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
		if bypassOn and not checkcaller() then
			local method = getnamecallmethod()

			if method == "Kick" then
				blockedCount = blockedCount + 1
				return nil
			end

			if method == "FireServer" or method == "InvokeServer" then
				if matchesAC(self.Name) or matchesAC(self.Parent and self.Parent.Name or "") then
					blockedCount = blockedCount + 1
					return nil
				end
			end
		end
		return oldNamecall(self, ...)
	end)
	namecallHooked = true
end)

-- kill anticheat listeners already connected on the client
local function severACConnections()
	if not getconnections then return 0 end
	local n = 0
	for _, obj in ipairs(game:GetDescendants()) do
		pcall(function()
			if (obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction")) and matchesAC(obj.Name) then
				for _, conn in ipairs(getconnections(obj.OnClientEvent)) do
					pcall(function()
						conn:Disable()
						n = n + 1
					end)
				end
			end
		end)
	end
	pcall(function()
		for _, conn in ipairs(getconnections(lp.Idled)) do
			conn:Disable()
		end
	end)
	return n
end
pcall(severACConnections)

local cachedRemotes = {}
local function updateRemoteCache()
	cachedRemotes = {}
	for _, area in pairs({rs, ws, lp.Backpack}) do
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
-- ui helpers
--=========================================================
local function round(inst, r)
	local c = Instance.new("UICorner", inst)
	c.CornerRadius = UDim.new(0, r or 4)
	return c
end

local function outline(inst, c)
	local s = Instance.new("UIStroke", inst)
	s.Color = c or col.line
	s.Thickness = 1
	return s
end

local function tw(inst, props, t)
	tweenServ:Create(inst, TweenInfo.new(t or 0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

local function makeDraggable(frame, handle)
	handle = handle or frame
	local dragging, startPos, startInput = false, nil, nil
	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			startInput = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	uis.InputChanged:Connect(function(input)
		if not dragging then return end
		if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
		local d = input.Position - startInput
		frame.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + d.X,
			startPos.Y.Scale, startPos.Y.Offset + d.Y
		)
	end)
end

local gui = Instance.new("ScreenGui")
gui.Name = "mvs"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = (gethui and gethui()) or game:GetService("CoreGui")

--------------------------------------------------- toasts
local toasts = Instance.new("Frame", gui)
toasts.AnchorPoint = Vector2.new(1, 1)
toasts.Position = UDim2.new(1, -14, 1, -14)
toasts.Size = UDim2.new(0, 230, 0, 260)
toasts.BackgroundTransparency = 1
local tl = Instance.new("UIListLayout", toasts)
tl.VerticalAlignment = Enum.VerticalAlignment.Bottom
tl.HorizontalAlignment = Enum.HorizontalAlignment.Right
tl.Padding = UDim.new(0, 6)

local function notify(text, c)
	local f = Instance.new("Frame", toasts)
	f.Size = UDim2.new(1, 0, 0, 30)
	f.BackgroundColor3 = col.bar
	round(f, 4)
	outline(f)
	local dot = Instance.new("Frame", f)
	dot.Position = UDim2.new(0, 0, 0, 0)
	dot.Size = UDim2.new(0, 2, 1, 0)
	dot.BorderSizePixel = 0
	dot.BackgroundColor3 = c or col.accent
	local t = Instance.new("TextLabel", f)
	t.Position = UDim2.new(0, 10, 0, 0)
	t.Size = UDim2.new(1, -16, 1, 0)
	t.BackgroundTransparency = 1
	t.Font = FONT
	t.TextSize = 12
	t.TextXAlignment = Enum.TextXAlignment.Left
	t.TextColor3 = col.text
	t.Text = text
	task.delay(2.5, function()
		tw(f, {BackgroundTransparency = 1}, 0.2)
		tw(t, {TextTransparency = 1}, 0.2)
		task.wait(0.22)
		f:Destroy()
	end)
end

--------------------------------------------------- window
local win = Instance.new("Frame", gui)
win.AnchorPoint = Vector2.new(0.5, 0.5)
win.Position = UDim2.new(0.5, 0, 0.5, 0)
win.Size = UDim2.new(0, 520, 0, 360)
win.BackgroundColor3 = col.bg
win.BorderSizePixel = 0
win.ClipsDescendants = true
round(win, 6)
outline(win)

local bar = Instance.new("Frame", win)
bar.Size = UDim2.new(1, 0, 0, 34)
bar.BackgroundColor3 = col.bar
bar.BorderSizePixel = 0

local barLine = Instance.new("Frame", bar)
barLine.AnchorPoint = Vector2.new(0, 1)
barLine.Position = UDim2.new(0, 0, 1, 0)
barLine.Size = UDim2.new(1, 0, 0, 1)
barLine.BackgroundColor3 = col.line
barLine.BorderSizePixel = 0

local title = Instance.new("TextLabel", bar)
title.Position = UDim2.new(0, 12, 0, 0)
title.Size = UDim2.new(1, -90, 1, 0)
title.BackgroundTransparency = 1
title.Font = FONT_B
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = col.text
title.Text = "murder vs sheriff 2026"

makeDraggable(win, bar)

local function barButton(text, x)
	local b = Instance.new("TextButton", bar)
	b.AnchorPoint = Vector2.new(1, 0.5)
	b.Position = UDim2.new(1, x, 0.5, 0)
	b.Size = UDim2.new(0, 22, 0, 22)
	b.BackgroundTransparency = 1
	b.Text = text
	b.Font = FONT_B
	b.TextSize = 13
	b.TextColor3 = col.dim
	b.AutoButtonColor = false
	b.MouseEnter:Connect(function() tw(b, {TextColor3 = col.text}) end)
	b.MouseLeave:Connect(function() tw(b, {TextColor3 = col.dim}) end)
	return b
end

local closeBtn = barButton("x", -10)
local minBtn   = barButton("-", -34)

--------------------------------------------------- tabs
local side = Instance.new("Frame", win)
side.Position = UDim2.new(0, 0, 0, 34)
side.Size = UDim2.new(0, 120, 1, -34)
side.BackgroundColor3 = col.bar
side.BorderSizePixel = 0

local sideLine = Instance.new("Frame", win)
sideLine.Position = UDim2.new(0, 120, 0, 34)
sideLine.Size = UDim2.new(0, 1, 1, -34)
sideLine.BackgroundColor3 = col.line
sideLine.BorderSizePixel = 0

local sl = Instance.new("UIListLayout", side)
sl.Padding = UDim.new(0, 2)
local sp = Instance.new("UIPadding", side)
sp.PaddingTop = UDim.new(0, 8)

local pages = Instance.new("Frame", win)
pages.Position = UDim2.new(0, 121, 0, 34)
pages.Size = UDim2.new(1, -121, 1, -34)
pages.BackgroundTransparency = 1

local tabs = {}
local function newTab(name)
	local btn = Instance.new("TextButton", side)
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.BackgroundColor3 = col.item
	btn.BackgroundTransparency = 1
	btn.BorderSizePixel = 0
	btn.Text = name
	btn.Font = FONT
	btn.TextSize = 12
	btn.TextColor3 = col.dim
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.AutoButtonColor = false
	local pad = Instance.new("UIPadding", btn)
	pad.PaddingLeft = UDim.new(0, 14)

	local mark = Instance.new("Frame", btn)
	mark.Position = UDim2.new(0, -14, 0, 0)
	mark.Size = UDim2.new(0, 2, 1, 0)
	mark.BackgroundColor3 = col.accent
	mark.BorderSizePixel = 0
	mark.Visible = false

	local page = Instance.new("ScrollingFrame", pages)
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.ScrollBarThickness = 2
	page.ScrollBarImageColor3 = col.line
	page.CanvasSize = UDim2.new()
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	page.Visible = false
	local list = Instance.new("UIListLayout", page)
	list.Padding = UDim.new(0, 6)
	local pd = Instance.new("UIPadding", page)
	pd.PaddingTop = UDim.new(0, 10)
	pd.PaddingLeft = UDim.new(0, 12)
	pd.PaddingRight = UDim.new(0, 12)
	pd.PaddingBottom = UDim.new(0, 10)

	local tab = {btn = btn, page = page, mark = mark, on = false}
	table.insert(tabs, tab)

	btn.MouseButton1Click:Connect(function()
		for _, t in ipairs(tabs) do
			t.page.Visible = false
			t.mark.Visible = false
			t.on = false
			tw(t.btn, {BackgroundTransparency = 1, TextColor3 = col.dim})
		end
		tab.on = true
		page.Visible = true
		mark.Visible = true
		tw(btn, {BackgroundTransparency = 0, TextColor3 = col.text})
	end)
	btn.MouseEnter:Connect(function()
		if not tab.on then tw(btn, {TextColor3 = col.text}) end
	end)
	btn.MouseLeave:Connect(function()
		if not tab.on then tw(btn, {TextColor3 = col.dim}) end
	end)
	if #tabs == 1 then
		tab.on = true
		page.Visible = true
		mark.Visible = true
		btn.BackgroundTransparency = 0
		btn.TextColor3 = col.text
	end
	return page
end

--------------------------------------------------- elements
local function row(page, h)
	local f = Instance.new("Frame", page)
	f.Size = UDim2.new(1, 0, 0, h)
	f.BackgroundColor3 = col.item
	f.BorderSizePixel = 0
	round(f, 4)
	return f
end

local function txt(parent, text, size, c)
	local l = Instance.new("TextLabel", parent)
	l.BackgroundTransparency = 1
	l.Font = FONT
	l.TextSize = size or 12
	l.TextColor3 = c or col.text
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.Text = text
	return l
end

local function header(page, text)
	local l = txt(page, text, 11, col.dim)
	l.Size = UDim2.new(1, 0, 0, 14)
	return l
end

local function toggle(page, name, default, cb)
	local f = row(page, 32)
	local l = txt(f, name)
	l.Position = UDim2.new(0, 10, 0, 0)
	l.Size = UDim2.new(1, -60, 1, 0)

	local box = Instance.new("TextButton", f)
	box.AnchorPoint = Vector2.new(1, 0.5)
	box.Position = UDim2.new(1, -10, 0.5, 0)
	box.Size = UDim2.new(0, 16, 0, 16)
	box.BackgroundColor3 = col.bg
	box.Text = ""
	box.AutoButtonColor = false
	round(box, 3)
	local bs = outline(box)

	local dot = Instance.new("Frame", box)
	dot.AnchorPoint = Vector2.new(0.5, 0.5)
	dot.Position = UDim2.new(0.5, 0, 0.5, 0)
	dot.Size = UDim2.new(0, 0, 0, 0)
	dot.BackgroundColor3 = col.accent
	dot.BorderSizePixel = 0
	round(dot, 2)

	local state = default and true or false
	local api = {}
	function api:Set(v)
		state = v and true or false
		tw(dot, {Size = state and UDim2.new(0, 8, 0, 8) or UDim2.new(0, 0, 0, 0)})
		tw(bs, {Color = state and col.accent or col.line})
		task.spawn(cb, state)
	end
	box.MouseButton1Click:Connect(function() api:Set(not state) end)
	if state then api:Set(true) end
	return api
end

local function slider(page, name, min, max, default, step, cb)
	step = step or 1
	local f = row(page, 46)
	local l = txt(f, name)
	l.Position = UDim2.new(0, 10, 0, 5)
	l.Size = UDim2.new(1, -70, 0, 16)

	local val = txt(f, tostring(default), 12, col.dim)
	val.AnchorPoint = Vector2.new(1, 0)
	val.Position = UDim2.new(1, -10, 0, 5)
	val.Size = UDim2.new(0, 50, 0, 16)
	val.TextXAlignment = Enum.TextXAlignment.Right

	local track = Instance.new("TextButton", f)
	track.Position = UDim2.new(0, 10, 0, 28)
	track.Size = UDim2.new(1, -20, 0, 6)
	track.BackgroundColor3 = col.bg
	track.Text = ""
	track.AutoButtonColor = false
	round(track, 3)

	local fill = Instance.new("Frame", track)
	fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	fill.BackgroundColor3 = col.accent
	fill.BorderSizePixel = 0
	round(fill, 3)

	local api = {}
	function api:Set(v)
		v = math.clamp(math.floor(v / step + 0.5) * step, min, max)
		val.Text = tostring(v)
		fill.Size = UDim2.new((v - min) / (max - min), 0, 1, 0)
		task.spawn(cb, v)
	end

	local held = false
	local function move(input)
		local a = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
		api:Set(min + math.clamp(a, 0, 1) * (max - min))
	end
	track.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			held = true
			move(i)
		end
	end)
	uis.InputChanged:Connect(function(i)
		if held and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			move(i)
		end
	end)
	uis.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			held = false
		end
	end)
	return api
end

local function button(page, name, cb)
	local b = Instance.new("TextButton", page)
	b.Size = UDim2.new(1, 0, 0, 30)
	b.BackgroundColor3 = col.item
	b.BorderSizePixel = 0
	b.Text = name
	b.Font = FONT
	b.TextSize = 12
	b.TextColor3 = col.text
	b.AutoButtonColor = false
	round(b, 4)
	b.MouseEnter:Connect(function() tw(b, {BackgroundColor3 = col.itemHov}) end)
	b.MouseLeave:Connect(function() tw(b, {BackgroundColor3 = col.item}) end)
	b.MouseButton1Click:Connect(function() task.spawn(cb) end)
	return b
end

--=========================================================
-- hitbox
--=========================================================
local originalSizes = {}

local function targetPart(char)
	return char:FindFirstChild("HumanoidRootPart")
end

local function isEnemy(p)
	return p ~= lp and (p.Team == nil or lp.Team == nil or p.Team ~= lp.Team)
end

local function restoreHitbox(hrp)
	local saved = originalSizes[hrp]
	if saved then
		pcall(function()
			hrp.Size = saved.size
			hrp.Transparency = saved.transparency
			hrp.Massless = saved.massless
			hrp.CanCollide = saved.canCollide
			hrp.Color = saved.color
			hrp.Material = saved.material
		end)
		originalSizes[hrp] = nil
	end
end

local function applyHitbox(hrp)
	if not originalSizes[hrp] then
		originalSizes[hrp] = {
			size = hrp.Size,
			transparency = hrp.Transparency,
			massless = hrp.Massless,
			canCollide = hrp.CanCollide,
			color = hrp.Color,
			material = hrp.Material,
		}
	end
	local size = hitboxSafe and math.min(hitboxSize, 10) or hitboxSize
	local s = Vector3.new(size, size, size)
	if hrp.Size ~= s then hrp.Size = s end
	if not hitboxSafe then
		hrp.Massless = true
		hrp.CanCollide = false
	end
	if hitboxInvis then
		hrp.Transparency = 1
	else
		hrp.Transparency = 0.65
		hrp.Material = Enum.Material.Neon
		hrp.Color = Color3.fromRGB(255, 60, 60)
	end
end

--=========================================================
-- kill all (teleport + knife)
--=========================================================
local function getKnife()
	local char = lp.Character
	if char then
		local held = char:FindFirstChildOfClass("Tool")
		if held then return held end
	end
	for _, t in ipairs(lp.Backpack:GetChildren()) do
		if t:IsA("Tool") then return t end
	end
	return nil
end

local function equipKnife()
	local char = lp.Character
	if not char then return nil end
	local hum = char:FindFirstChildOfClass("Humanoid")
	local tool = getKnife()
	if tool and hum and tool.Parent ~= char then
		pcall(function() hum:EquipTool(tool) end)
	end
	return char:FindFirstChildOfClass("Tool")
end

local function fireRemotes(target)
	for _, remote in ipairs(cachedRemotes) do
		pcall(function()
			if remote and remote.Parent then
				remote:FireServer(target.Character)
				remote:FireServer(target)
				remote:FireServer(target.Character:FindFirstChildOfClass("Humanoid"))
				remote:FireServer()
			end
		end)
	end
end

local function killAll()
	if isKilling then
		notify("already running")
		return
	end
	local char = lp.Character
	local myHrp = char and char:FindFirstChild("HumanoidRootPart")
	if not myHrp then
		notify("no character", col.accent)
		return
	end

	isKilling = true
	updateRemoteCache()
	local tool = equipKnife()
	if not tool then notify("no knife found, using remotes only") end

	local startCFrame = myHrp.CFrame
	local hit = 0

	for _, p in ipairs(players:GetPlayers()) do
		if not isKilling then break end
		if isEnemy(p) and p.Character then
			local hum = p.Character:FindFirstChildOfClass("Humanoid")
			local hrp = p.Character:FindFirstChild("HumanoidRootPart")
			if hum and hrp and hum.Health > 0 then
				myHrp.CFrame = hrp.CFrame * CFrame.new(0, 0, killRange) * CFrame.Angles(0, math.pi, 0)
				task.wait(killDelay)
				tool = equipKnife()
				if tool then
					pcall(function() tool:Activate() end)
					task.wait(0.05)
					pcall(function() tool:Activate() end)
				end
				fireRemotes(p)
				hit = hit + 1
				task.wait(killDelay)
			end
		end
	end

	local backHrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
	if backHrp then backHrp.CFrame = startCFrame end
	isKilling = false
	notify("attacked " .. hit .. " player(s)", col.good)
end

--=========================================================
-- invisibility
--=========================================================
local function setTransparency(char, t)
	for _, d in ipairs(char:GetDescendants()) do
		if d:IsA("BasePart") or d:IsA("Decal") then d.Transparency = t end
	end
end

local invisPanel = Instance.new("Frame", gui)
invisPanel.AnchorPoint = Vector2.new(1, 0.5)
invisPanel.Position = UDim2.new(1, -20, 0.5, 0)
invisPanel.Size = UDim2.new(0, 180, 0, 104)
invisPanel.BackgroundColor3 = col.bg
invisPanel.BorderSizePixel = 0
invisPanel.Visible = false
round(invisPanel, 6)
outline(invisPanel)

local ipBar = Instance.new("Frame", invisPanel)
ipBar.Size = UDim2.new(1, 0, 0, 26)
ipBar.BackgroundColor3 = col.bar
ipBar.BorderSizePixel = 0
round(ipBar, 6)
local ipPatch = Instance.new("Frame", ipBar)
ipPatch.Position = UDim2.new(0, 0, 1, -6)
ipPatch.Size = UDim2.new(1, 0, 0, 6)
ipPatch.BackgroundColor3 = col.bar
ipPatch.BorderSizePixel = 0

local ipTitle = txt(ipBar, "invisibility", 12, col.text)
ipTitle.Font = FONT_B
ipTitle.Position = UDim2.new(0, 10, 0, 0)
ipTitle.Size = UDim2.new(1, -20, 1, 0)
makeDraggable(invisPanel, ipBar)

local ipStatus = txt(invisPanel, "state: visible", 12, col.dim)
ipStatus.Position = UDim2.new(0, 10, 0, 32)
ipStatus.Size = UDim2.new(1, -20, 0, 16)

local ipBtn = Instance.new("TextButton", invisPanel)
ipBtn.Position = UDim2.new(0, 10, 0, 54)
ipBtn.Size = UDim2.new(1, -20, 0, 30)
ipBtn.BackgroundColor3 = col.item
ipBtn.BorderSizePixel = 0
ipBtn.Text = "go invisible"
ipBtn.Font = FONT
ipBtn.TextSize = 12
ipBtn.TextColor3 = col.text
ipBtn.AutoButtonColor = false
round(ipBtn, 4)
local ipStroke = outline(ipBtn)

local function setInvisible(on)
	local char = lp.Character
	if not char then
		notify("no character", col.accent)
		return
	end
	if on then
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if not hrp then return end
		local saved = hrp.CFrame
		char:MoveTo(INVIS_POS)
		task.wait(0.15)
		local seat = Instance.new("Seat")
		seat.Name = "invischair"
		seat.Anchored = false
		seat.CanCollide = false
		seat.Transparency = 1
		seat.Position = INVIS_POS
		seat.Parent = workspace
		local weld = Instance.new("Weld")
		weld.Part0 = seat
		weld.Part1 = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
		weld.Parent = seat
		task.wait()
		seat.CFrame = saved
		setTransparency(char, 0.5)
	else
		local chair = workspace:FindFirstChild("invischair")
		if chair then chair:Destroy() end
		setTransparency(char, 0)
	end
	isInvisible = on
	ipStatus.Text = on and "state: invisible" or "state: visible"
	ipStatus.TextColor3 = on and col.good or col.dim
	ipBtn.Text = on and "go visible" or "go invisible"
	tw(ipStroke, {Color = on and col.good or col.line})
end

local function toggleInvisible() setInvisible(not isInvisible) end
ipBtn.MouseButton1Click:Connect(toggleInvisible)
ipBtn.MouseEnter:Connect(function() tw(ipBtn, {BackgroundColor3 = col.itemHov}) end)
ipBtn.MouseLeave:Connect(function() tw(ipBtn, {BackgroundColor3 = col.item}) end)

--=========================================================
-- pages
--=========================================================
local combat = newTab("combat")
header(combat, "kill")
button(combat, "kill all", killAll)
button(combat, "stop kill all", function()
	isKilling = false
	notify("stopped")
end)
slider(combat, "delay per player", 0.05, 1, 0.12, 0.01, function(v) killDelay = v end)
slider(combat, "attack distance", 1, 10, 4, 1, function(v) killRange = v end)
header(combat, "hitbox")
toggle(combat, "enable hitbox", false, function(v)
	hitboxOn = v
	if not v then
		for hrp in pairs(originalSizes) do restoreHitbox(hrp) end
	end
end)
toggle(combat, "hitbox see-thru", false, function(v) hitboxInvis = v end)
toggle(combat, "safe mode (anti-kick)", true, function(v)
	hitboxSafe = v
	for hrp in pairs(originalSizes) do restoreHitbox(hrp) end
end)
slider(combat, "hitbox size", 1, 30, 5, 1, function(v) hitboxSize = v end)

header(combat, "anticheat")
local acStatus = txt(combat, "", 12, col.dim)
acStatus.Size = UDim2.new(1, 0, 0, 32)
local function refreshAcStatus()
	acStatus.Text = (bypassOn and "bypass: on" or "bypass: off")
		.. (namecallHooked and " | kick hook active" or " | kick hook unsupported")
		.. "\nblocked: " .. blockedCount
end
refreshAcStatus()
toggle(combat, "anticheat bypass", true, function(v)
	bypassOn = v
	refreshAcStatus()
	notify(v and "bypass on" or "bypass off", v and col.good or col.accent)
end)
button(combat, "rescan / purge detections", function()
	local ok, removed = pcall(purgeScripts)
	removed = (ok and removed) or 0
	local okConn, severed = pcall(severACConnections)
	severed = (okConn and severed) or 0
	blockedCount = blockedCount + removed + severed
	refreshAcStatus()
	notify("purged " .. removed .. " scripts, " .. severed .. " listeners", col.good)
end)
task.spawn(function()
	while gui.Parent do
		task.wait(1)
		refreshAcStatus()
	end
end)

local visuals = newTab("visuals")
header(visuals, "esp")
toggle(visuals, "player esp", false, function(v)
	esp = v
	if not v then
		for _, p in ipairs(players:GetPlayers()) do
			if p.Character then
				local h = p.Character:FindFirstChildOfClass("Highlight")
				if h then h:Destroy() end
			end
		end
	end
end)

local movement = newTab("movement")
header(movement, "speed")
local speedSlider = slider(movement, "walkspeed", 16, 200, 16, 1, function(v) walkSpeed = v end)
button(movement, "reset speed", function() speedSlider:Set(16) end)
header(movement, "abilities")
toggle(movement, "infinite jump", false, function(v) infJump = v end)
toggle(movement, "noclip", false, function(v) noclip = v end)
toggle(movement, "invisibility panel", false, function(v) invisPanel.Visible = v end)
button(movement, "toggle invisibility", toggleInvisible)
button(movement, "give click tp tool", function()
	local mouse = lp:GetMouse()
	local tool = Instance.new("Tool", lp.Backpack)
	tool.RequiresHandle = false
	tool.Name = "Click TP"
	tool.Activated:Connect(function()
		if lp.Character then lp.Character:MoveTo(mouse.Hit.p + Vector3.new(0, 3, 0)) end
	end)
	notify("added to backpack")
end)

local server = newTab("server")
header(server, "teleport")
button(server, "serverhop (almost full)", function()
	local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
	local ok, res = pcall(function() return game:HttpGet(url) end)
	if not ok then
		notify("request failed", col.accent)
		return
	end
	for _, s in pairs(http:JSONDecode(res).data) do
		if s.playing >= (s.maxPlayers - 3) and s.playing < s.maxPlayers and s.id ~= game.JobId then
			notify("teleporting", col.good)
			teleports:TeleportToPlaceInstance(game.PlaceId, s.id, lp)
			return
		end
	end
	notify("no server found", col.accent)
end)
button(server, "rejoin", function()
	teleports:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
end)

local settings = newTab("settings")
header(settings, "interface")
button(settings, "reset positions", function()
	win.Position = UDim2.new(0.5, 0, 0.5, 0)
	invisPanel.Position = UDim2.new(1, -20, 0.5, 0)
end)
button(settings, "unload", function()
	esp, hitboxOn, hitboxInvis, noclip, infJump, isKilling = false, false, false, false, false, false
	walkSpeed = 16
	for hrp in pairs(originalSizes) do restoreHitbox(hrp) end
	if isInvisible then setInvisible(false) end
	bypassOn = false
	gui:Destroy()
end)
local info = txt(settings, "rightshift - hide menu\nctrl+i - invisibility", 12, col.dim)
info.Size = UDim2.new(1, 0, 0, 36)

--=========================================================
-- window controls
--=========================================================
local minimized = false
minBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	side.Visible = not minimized
	sideLine.Visible = not minimized
	pages.Visible = not minimized
	tw(win, {Size = minimized and UDim2.new(0, 520, 0, 34) or UDim2.new(0, 520, 0, 360)}, 0.15)
end)

closeBtn.MouseButton1Click:Connect(function()
	win.Visible = false
	notify("rightshift to reopen")
end)

uis.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		win.Visible = not win.Visible
	elseif input.KeyCode == Enum.KeyCode.I and uis:IsKeyDown(Enum.KeyCode.LeftControl) then
		toggleInvisible()
	end
end)

uis.JumpRequest:Connect(function()
	if infJump and lp.Character then
		local hum = lp.Character:FindFirstChildOfClass("Humanoid")
		if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
	end
end)

--=========================================================
-- loops
--=========================================================
runService.Stepped:Connect(function()
	if noclip and lp.Character then
		for _, part in ipairs(lp.Character:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
		end
	end
end)

runService.Heartbeat:Connect(function()
	for _, p in ipairs(players:GetPlayers()) do
		local char = p.Character
		if char then
			local hrp = targetPart(char)
			if hrp then
				if hitboxOn and isEnemy(p) then
					pcall(applyHitbox, hrp)
				elseif originalSizes[hrp] then
					restoreHitbox(hrp)
				end

				if esp and isEnemy(p) then
					if not char:FindFirstChildOfClass("Highlight") then
						local h = Instance.new("Highlight")
						h.FillColor = col.accent
						h.OutlineColor = Color3.new(1, 1, 1)
						h.FillTransparency = 0.6
						h.Parent = char
					end
				else
					local h = char:FindFirstChildOfClass("Highlight")
					if h then h:Destroy() end
				end
			end
		end
	end

	if lp.Character then
		local hum = lp.Character:FindFirstChildOfClass("Humanoid")
		if hum and hum.WalkSpeed ~= walkSpeed then hum.WalkSpeed = walkSpeed end
	end
end)

players.PlayerRemoving:Connect(function(p)
	if p.Character then
		local hrp = p.Character:FindFirstChild("HumanoidRootPart")
		if hrp then originalSizes[hrp] = nil end
	end
end)

notify("loaded - rightshift to hide")
