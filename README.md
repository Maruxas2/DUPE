# File Backup Tool

A simple Python CLI that zips a folder of your choice and uploads it to a Discord webhook.

## Requirements

- Python 3.6+
- No external dependencies (uses only the standard library)

## Usage

```bash
python backup_tool.py
```

The tool will walk you through each step:

1. **Consent** — explains exactly what it does and asks for permission.
2. **Folder selection** — you enter the full path to the folder you want to back up.
3. **Webhook URL** — you paste your Discord webhook URL.
4. **Archive name** — optionally customize the zip filename.
5. **Confirmation** — reviews your choices before uploading.
6. **Upload** — zips the folder and sends it to Discord. Archives larger than 8 MB are automatically split into parts.

## Features

- Zero dependencies — runs with a stock Python install.
- Fully transparent — tells you exactly what it will do before doing it.
- Consent-based — nothing happens without explicit confirmation.
- Auto-split — handles Discord's 8 MB file-size limit by splitting large archives.
- Skips unreadable files gracefully.
