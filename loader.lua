--[[
    DUPE loader — HWID-locked key gate.

    Flow:
      1. Grabs the executor HWID.
      2. Shows a small UI: your HWID (with Copy) + a key box + Redeem.
      3. Fetches keys.json (a file you control) and checks that the entered
         key exists, is bound to THIS HWID, and has not expired.
      4. Only on success does it fetch + run the protected script (script.lua).

    Hosting: point KEYS_URL / SCRIPT_URL at the raw files in your repo, e.g.
      https://raw.githubusercontent.com/<user>/<repo>/main/keys.json
    Add "?t=" .. tick() style cache-busting is handled below for keys.json so
    edits show up without waiting on the CDN cache.

    Usage in your executor:
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Maruxas2/DUPE/main/loader.lua"))()
]]

-- ===================== CONFIG (edit these) =====================
local KEYS_URL   = "https://raw.githubusercontent.com/Maruxas2/DUPE/main/keys.json"
local SCRIPT_URL = "https://raw.githubusercontent.com/Maruxas2/DUPE/main/script.lua"
local TITLE      = "DUPE • Key System"
local GET_KEY_URL = "" -- optional: a link shown on the "Get Key" button (e.g. your Discord invite)
-- ==============================================================

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- ---- HTTP helper (works across executors) ----
local function httpGet(url)
    local getter = (syn and syn.request) or (http and http.request) or request or http_request
    if getter then
        local ok, res = pcall(getter, { Url = url, Method = "GET" })
        if ok and res and res.Body and (res.StatusCode == nil or res.StatusCode == 200) then
            return res.Body
        end
    end
    -- fallback to Roblox's HttpGet
    local ok, body = pcall(function()
        return game:HttpGet(url)
    end)
    if ok then
        return body
    end
    return nil
end

-- ---- HWID (stable per-machine identifier) ----
local function getHWID()
    -- Prefer the executor-provided HWID when available.
    for _, fn in ipairs({ gethwid, get_hwid }) do
        if typeof(fn) == "function" then
            local ok, id = pcall(fn)
            if ok and id and #tostring(id) > 0 then
                return tostring(id)
            end
        end
    end
    -- Fall back to Roblox's stable client id.
    local ok, id = pcall(function()
        return game:GetService("RbxAnalyticsService"):GetClientId()
    end)
    if ok and id and #tostring(id) > 0 then
        return tostring(id)
    end
    -- Last resort: derive something stable-ish from the account.
    local plr = Players.LocalPlayer
    return plr and ("uid-" .. tostring(plr.UserId)) or "unknown-hwid"
end

local HWID = getHWID()

local function setClipboard(text)
    local fn = setclipboard or toclipboard or (syn and syn.write_clipboard) or writeclipboard
    if typeof(fn) == "function" then
        pcall(fn, text)
        return true
    end
    return false
end

-- ---- Validation ----
local function normalize(s)
    return (tostring(s or ""):gsub("%s+", "")):lower()
end

-- returns: ok(boolean), message(string)
local function validate(key)
    local raw = httpGet(KEYS_URL .. "?t=" .. tostring(os.time()))
    if not raw then
        return false, "Could not reach key server."
    end
    local ok, data = pcall(function()
        return HttpService:JSONDecode(raw)
    end)
    if not ok or type(data) ~= "table" then
        return false, "Key list is malformed."
    end
    local keys = data.keys or data
    local entry = keys[key]
    if entry == nil then
        -- also allow case-insensitive lookup
        for k, v in pairs(keys) do
            if normalize(k) == normalize(key) then
                entry = v
                break
            end
        end
    end
    if entry == nil then
        return false, "Invalid key."
    end

    -- entry may be a plain string (hwid) or a table with metadata.
    local boundHwid, expires
    if type(entry) == "string" then
        boundHwid, expires = entry, 0
    elseif type(entry) == "table" then
        boundHwid, expires = entry.hwid, entry.expires
    else
        return false, "Invalid key record."
    end

    -- expiry check (0 / nil / "never" = lifetime)
    if expires and expires ~= 0 and tostring(expires):lower() ~= "never" then
        local exp = tonumber(expires)
        if exp and os.time() > exp then
            return false, "This key has expired."
        end
    end

    -- HWID check
    if boundHwid == nil or normalize(boundHwid) == "" or normalize(boundHwid) == "any" then
        -- unbound key: allowed on any machine (use with care)
        return true, "OK"
    end
    if normalize(boundHwid) ~= normalize(HWID) then
        return false, "Key is locked to a different HWID."
    end

    return true, "OK"
end

local function runScript()
    local body = httpGet(SCRIPT_URL)
    if not body then
        return false, "Could not download the script."
    end
    local fn, err = loadstring(body)
    if not fn then
        return false, "Script compile error: " .. tostring(err)
    end
    local ok, runErr = pcall(fn)
    if not ok then
        return false, "Script runtime error: " .. tostring(runErr)
    end
    return true, "OK"
end

-- ===================== UI =====================
local function parentGui(gui)
    if typeof(gethui) == "function" then
        local ok, hui = pcall(gethui)
        if ok and hui then
            gui.Parent = hui
            return
        end
    end
    if syn and syn.protect_gui then
        pcall(syn.protect_gui, gui)
    end
    local plr = Players.LocalPlayer
    local pg = plr and plr:FindFirstChildOfClass("PlayerGui")
    gui.Parent = pg or game:GetService("CoreGui")
end

local function corner(inst, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = inst
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DUPEKeySystem"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true
parentGui(screenGui)

local main = Instance.new("Frame")
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.fromScale(0.5, 0.5)
main.Size = UDim2.fromOffset(360, 260)
main.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
corner(main, 12)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(120, 90, 230)
stroke.Thickness = 1.5
stroke.Parent = main

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 0, 0, 12)
title.Size = UDim2.new(1, 0, 0, 26)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(235, 235, 240)
title.Text = TITLE
title.Parent = main

local hwidLabel = Instance.new("TextLabel")
hwidLabel.BackgroundTransparency = 1
hwidLabel.Position = UDim2.new(0, 16, 0, 48)
hwidLabel.Size = UDim2.new(1, -32, 0, 18)
hwidLabel.Font = Enum.Font.Gotham
hwidLabel.TextSize = 12
hwidLabel.TextXAlignment = Enum.TextXAlignment.Left
hwidLabel.TextColor3 = Color3.fromRGB(170, 170, 180)
hwidLabel.Text = "Your HWID:"
hwidLabel.Parent = main

local hwidBox = Instance.new("TextBox")
hwidBox.Position = UDim2.new(0, 16, 0, 68)
hwidBox.Size = UDim2.new(1, -110, 0, 30)
hwidBox.BackgroundColor3 = Color3.fromRGB(34, 34, 42)
hwidBox.TextColor3 = Color3.fromRGB(220, 220, 230)
hwidBox.Font = Enum.Font.Code
hwidBox.TextSize = 12
hwidBox.ClearTextOnFocus = false
hwidBox.TextEditable = false
hwidBox.TextTruncate = Enum.TextTruncate.AtEnd
hwidBox.Text = HWID
hwidBox.Parent = main
corner(hwidBox, 6)

local copyBtn = Instance.new("TextButton")
copyBtn.Position = UDim2.new(1, -86, 0, 68)
copyBtn.Size = UDim2.new(0, 70, 0, 30)
copyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 72)
copyBtn.TextColor3 = Color3.fromRGB(235, 235, 240)
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 12
copyBtn.Text = "Copy"
copyBtn.Parent = main
corner(copyBtn, 6)

local keyBox = Instance.new("TextBox")
keyBox.Position = UDim2.new(0, 16, 0, 112)
keyBox.Size = UDim2.new(1, -32, 0, 34)
keyBox.BackgroundColor3 = Color3.fromRGB(34, 34, 42)
keyBox.TextColor3 = Color3.fromRGB(235, 235, 240)
keyBox.PlaceholderText = "Paste your key here…"
keyBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14
keyBox.ClearTextOnFocus = false
keyBox.Text = ""
keyBox.Parent = main
corner(keyBox, 6)

local redeemBtn = Instance.new("TextButton")
redeemBtn.Position = UDim2.new(0, 16, 0, 158)
redeemBtn.Size = UDim2.new(1, -32, 0, 36)
redeemBtn.BackgroundColor3 = Color3.fromRGB(120, 90, 230)
redeemBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
redeemBtn.Font = Enum.Font.GothamBold
redeemBtn.TextSize = 15
redeemBtn.Text = "Redeem & Run"
redeemBtn.Parent = main
corner(redeemBtn, 6)

local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Position = UDim2.new(0, 16, 0, 200)
getKeyBtn.Size = UDim2.new(0.5, -20, 0, 24)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
getKeyBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
getKeyBtn.Font = Enum.Font.Gotham
getKeyBtn.TextSize = 12
getKeyBtn.Text = "Get Key (copy link)"
getKeyBtn.Visible = GET_KEY_URL ~= ""
getKeyBtn.Parent = main
corner(getKeyBtn, 6)

local closeBtn = Instance.new("TextButton")
closeBtn.AnchorPoint = Vector2.new(1, 0)
closeBtn.Position = UDim2.new(1, -16, 0, 200)
closeBtn.Size = UDim2.new(0.5, -20, 0, 24)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
closeBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
closeBtn.Font = Enum.Font.Gotham
closeBtn.TextSize = 12
closeBtn.Text = "Close"
closeBtn.Parent = main
corner(closeBtn, 6)

local status = Instance.new("TextLabel")
status.BackgroundTransparency = 1
status.Position = UDim2.new(0, 16, 1, -30)
status.Size = UDim2.new(1, -32, 0, 22)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.TextColor3 = Color3.fromRGB(170, 170, 180)
status.Text = "Enter your key to continue."
status.Parent = main

-- ---- Behaviour ----
local function setStatus(text, color)
    status.Text = text
    status.TextColor3 = color or Color3.fromRGB(170, 170, 180)
end

copyBtn.MouseButton1Click:Connect(function()
    if setClipboard(HWID) then
        setStatus("HWID copied to clipboard.", Color3.fromRGB(120, 230, 140))
    else
        setStatus("Clipboard not supported — copy manually.", Color3.fromRGB(230, 180, 90))
    end
end)

getKeyBtn.MouseButton1Click:Connect(function()
    if GET_KEY_URL ~= "" and setClipboard(GET_KEY_URL) then
        setStatus("Key link copied to clipboard.", Color3.fromRGB(120, 230, 140))
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

local busy = false
redeemBtn.MouseButton1Click:Connect(function()
    if busy then
        return
    end
    busy = true
    redeemBtn.Text = "Checking…"
    setStatus("Validating key…")

    local key = (keyBox.Text or ""):gsub("^%s+", ""):gsub("%s+$", "")
    if key == "" then
        setStatus("Please enter a key.", Color3.fromRGB(230, 120, 120))
        redeemBtn.Text = "Redeem & Run"
        busy = false
        return
    end

    local ok, msg = validate(key)
    if not ok then
        setStatus(msg, Color3.fromRGB(230, 120, 120))
        redeemBtn.Text = "Redeem & Run"
        busy = false
        return
    end

    setStatus("Key valid — loading script…", Color3.fromRGB(120, 230, 140))
    local ranOk, runMsg = runScript()
    if not ranOk then
        setStatus(runMsg, Color3.fromRGB(230, 120, 120))
        redeemBtn.Text = "Redeem & Run"
        busy = false
        return
    end

    setStatus("Loaded!", Color3.fromRGB(120, 230, 140))
    task.wait(0.4)
    screenGui:Destroy()
end)
