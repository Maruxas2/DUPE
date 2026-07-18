# DUPE — HWID-locked key loader

A small key system for your Roblox script. Users run `loader.lua`; it grabs their
HWID, checks the key they enter against `keys.json` (which you control), and only
runs the real script (`script.lua`) if the key is valid **and** bound to that HWID.

## Files

| File         | What it is                                                            |
|--------------|-----------------------------------------------------------------------|
| `loader.lua` | The public loader users execute. Shows the key UI + validates.        |
| `keys.json`  | Your key list. Each key is bound to a HWID and an optional expiry.     |
| `script.lua` | The protected script that only runs after a valid key.                 |

## How users run it

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Maruxas2/DUPE/main/loader.lua"))()
```

They get a window with:
- their **HWID** and a **Copy** button (they send you this to get a key),
- a **key** box + **Redeem & Run**.

## Giving someone a key (HWID-locked)

1. The user runs the loader, clicks **Copy**, and sends you their HWID.
2. Add an entry to `keys.json`:

```json
{
  "keys": {
    "THEIR-KEY-HERE": {
      "hwid": "the-hwid-they-sent",
      "expires": 0,
      "note": "buyer name / discord"
    }
  }
}
```

3. Commit/push `keys.json`. The loader always fetches the latest copy (with
   cache-busting), so it works right away.

### Key fields

- `hwid` — the HWID this key is locked to. Use `"any"` (or leave blank) for an
  **unbound** key that works on any machine (not recommended for paid keys).
- `expires` — `0` or `"never"` for lifetime, otherwise a **Unix timestamp**
  (seconds). After that time the key stops working.
  - Get a timestamp: `os.time()` in Lua, or `date -d "+30 days" +%s` in a shell.
- `note` — free text for your own tracking (ignored by the loader).

Shorthand: a key can also be just the HWID string, e.g. `"KEY123": "the-hwid"`.

## Configuring the loader

Edit the top of `loader.lua`:

- `KEYS_URL` / `SCRIPT_URL` — raw URLs of `keys.json` and `script.lua`.
- `GET_KEY_URL` — optional link (e.g. your Discord) shown on a "Get Key" button.
- `TITLE` — window title.

## Notes / limitations

- HWID comes from the executor (`gethwid`) when available, otherwise Roblox's
  stable `RbxAnalyticsService:GetClientId()`.
- With a **public** GitHub repo, anyone who finds the raw `script.lua` URL can
  fetch it directly, bypassing the key check. For real protection, host
  `script.lua` behind a private/gated endpoint (a small server that only returns
  the script after validating the key + HWID). The loader is structured so you
  can swap `runScript()` to hit such an endpoint later.
- To revoke access, delete the key from `keys.json` (or set `expires` in the past).
