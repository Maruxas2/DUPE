#!/usr/bin/env python3
"""
File Backup Tool — CLI that zips a user-chosen folder and uploads
the archive to a Discord webhook.

Usage:
    python backup_tool.py

The tool is fully transparent: it tells the user exactly what will
happen, asks for consent, and lets them pick which folder to back up.
Nothing is collected silently.
"""

import io
import os
import sys
import zipfile
import json
import urllib.request
import urllib.error


BANNER = r"""
 _____ _ _        ____             _
|  ___(_) | ___  | __ )  __ _  ___| | ___   _ _ __
| |_  | | |/ _ \ |  _ \ / _` |/ __| |/ / | | | '_ \
|  _| | | |  __/ | |_) | (_| | (__|   <| |_| | |_) |
|_|   |_|_|\___| |____/ \__,_|\___|_|\_\\__,_| .__/
                                              |_|
"""

MAX_FILE_SIZE = 8 * 1024 * 1024  # Discord free-tier limit: 8 MB per upload


def get_input(prompt: str) -> str:
    """Read a line from stdin with a prompt."""
    try:
        return input(prompt).strip()
    except (EOFError, KeyboardInterrupt):
        print("\nAborted.")
        sys.exit(0)


def zip_folder(folder_path: str) -> bytes:
    """Zip the contents of *folder_path* into an in-memory archive."""
    buf = io.BytesIO()
    with zipfile.ZipFile(buf, "w", zipfile.ZIP_DEFLATED) as zf:
        for root, _dirs, files in os.walk(folder_path):
            for fname in files:
                full = os.path.join(root, fname)
                arcname = os.path.relpath(full, folder_path)
                try:
                    zf.write(full, arcname)
                except (PermissionError, OSError) as exc:
                    print(f"  [skip] {full}: {exc}")
    return buf.getvalue()


def split_bytes(data: bytes, chunk_size: int):
    """Yield successive chunks of *data*."""
    for i in range(0, len(data), chunk_size):
        yield data[i : i + chunk_size]


def upload_to_webhook(webhook_url: str, file_bytes: bytes, filename: str) -> None:
    """Upload *file_bytes* as an attachment to a Discord webhook.

    If the archive exceeds Discord's 8 MB limit it is split into
    numbered parts automatically.
    """
    parts = list(split_bytes(file_bytes, MAX_FILE_SIZE))
    total = len(parts)

    for idx, chunk in enumerate(parts, start=1):
        part_name = filename if total == 1 else f"{filename}.part{idx}"
        boundary = "----BackupToolBoundary"
        body = (
            f"--{boundary}\r\n"
            f'Content-Disposition: form-data; name="payload_json"\r\n'
            f"Content-Type: application/json\r\n\r\n"
            f'{{"content": "Backup part {idx}/{total}"}}\r\n'
            f"--{boundary}\r\n"
            f'Content-Disposition: form-data; name="file"; filename="{part_name}"\r\n'
            f"Content-Type: application/zip\r\n\r\n"
        ).encode() + chunk + f"\r\n--{boundary}--\r\n".encode()

        req = urllib.request.Request(
            webhook_url,
            data=body,
            headers={
                "Content-Type": f"multipart/form-data; boundary={boundary}",
                "User-Agent": "FileBackupTool/1.0",
            },
            method="POST",
        )
        try:
            with urllib.request.urlopen(req) as resp:
                if resp.status in (200, 204):
                    print(f"  [ok]  Uploaded {part_name} ({len(chunk):,} bytes)")
                else:
                    print(f"  [warn] Unexpected status {resp.status} for {part_name}")
        except urllib.error.HTTPError as exc:
            print(f"  [error] Failed to upload {part_name}: {exc}")
            sys.exit(1)


def main() -> None:
    print(BANNER)
    print("This tool backs up a folder you choose and uploads the zip")
    print("archive to a Discord webhook you provide.\n")

    # ── Consent ──────────────────────────────────────────────────
    print("HOW IT WORKS:")
    print("  1. You enter the path to the folder you want to back up.")
    print("  2. You enter your Discord webhook URL.")
    print("  3. The folder is zipped and sent to the webhook.")
    print("  Nothing else is accessed or sent.\n")

    consent = get_input("Do you consent and want to continue? [y/N]: ")
    if consent.lower() not in ("y", "yes"):
        print("Cancelled. Nothing was uploaded.")
        sys.exit(0)

    # ── Folder selection ─────────────────────────────────────────
    folder = get_input("Enter the full path of the folder to back up: ")
    if not os.path.isdir(folder):
        print(f"Error: '{folder}' is not a valid directory.")
        sys.exit(1)

    # ── Webhook ──────────────────────────────────────────────────
    webhook = get_input("Enter your Discord webhook URL: ")
    if not webhook.startswith("https://discord.com/api/webhooks/"):
        print("Error: That doesn't look like a valid Discord webhook URL.")
        sys.exit(1)

    # ── Archive name ─────────────────────────────────────────────
    default_name = os.path.basename(os.path.normpath(folder)) + "_backup.zip"
    custom_name = get_input(f"Archive name [{default_name}]: ")
    archive_name = custom_name if custom_name else default_name
    if not archive_name.endswith(".zip"):
        archive_name += ".zip"

    # ── Confirm ──────────────────────────────────────────────────
    print(f"\nReady to back up:")
    print(f"  Folder : {folder}")
    print(f"  Archive: {archive_name}")
    print(f"  Send to: {webhook[:60]}…\n")
    confirm = get_input("Proceed? [y/N]: ")
    if confirm.lower() not in ("y", "yes"):
        print("Cancelled.")
        sys.exit(0)

    # ── Zip & upload ─────────────────────────────────────────────
    print("\nZipping folder…")
    data = zip_folder(folder)
    print(f"  Archive size: {len(data):,} bytes")

    print("Uploading to Discord webhook…")
    upload_to_webhook(webhook, data, archive_name)

    print("\nDone! Your backup has been sent.")


if __name__ == "__main__":
    main()
