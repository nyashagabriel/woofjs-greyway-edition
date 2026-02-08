# WoofJS Docs Offline Kit

## Why it fails offline
Your `index.html` pulls core dependencies from online CDNs (jQuery, Vue, Fuse, Bootstrap, Clipboard).
When you're offline, the browser can't fetch them, so the docs app doesn't boot.

## What this kit provides
- `index.offline.html`: same docs page, but CDN links are replaced with local `./vendor/*` paths.
- `fetch_vendor.ps1`: PowerShell script that downloads those dependencies into `./vendor/`.

## Quick run (Windows)
1) Put these files in the same folder as your docs:
   - index.offline.html
   - docs.css
   - docs.js
2) Run:
   powershell -ExecutionPolicy Bypass -File .\fetch_vendor.ps1
3) Start a local server from that folder:
   py -m http.server 8000
4) Open:
   http://localhost:8000/index.offline.html

## Notes
- Tether was removed from the offline version because Bootstrap 3 does not need it.
- If images are missing, ensure you have the `./images/` folder beside the HTML file.
