# WoofJS — Greyway Edition

An offline-first fork of [WoofJS](https://github.com/stevekrouse/WoofJS). All dependencies are bundled locally so the editor, documentation, and showcase projects run without an internet connection.

---

## Credits

- **WoofJS** was created by [Steve Krouse](https://github.com/stevekrouse) and [The Coding Space](http://thecodingspace.com). The engine, documentation, and curriculum design are entirely their work.
- **This fork** bundles it for offline use, applies a dark theme, and adjusts the layout. The WoofJS engine (`woof.js`) itself is untouched.

---

## Why This Fork Exists

WoofJS loads its editor, libraries, and documentation from CDNs. When the internet is unavailable, the editor does not load. Students who depend on WoofJS as their bridge from Scratch to JavaScript lose access to that tool the moment the connection drops.

This fork bundles every dependency locally so the editor runs identically regardless of connectivity. It also applies a dark theme and minor layout changes.

The WoofJS engine was not modified. Code written in this version behaves the same way on the original woofjs.com.

---

## What Changed

### 1. Offline operation

All external CDN references have been replaced with local files stored in `vendor/`. A Service Worker (`sw.js`) caches all project files after the first load. A Web App Manifest (`manifest.json`) enables installation as a standalone app.

The result: copy the folder to a USB drive and it runs in any browser.

### 2. Visual theme

A dark theme is applied via `ui/vivid-theme.css` and `docs/vivid-docs.css`. It covers the editor, documentation, and all supporting pages. The "Greyway" colour variant sits on top of this base theme.

Changes are purely cosmetic:
- Dark backgrounds with subtle colour gradients
- Rounded panels with spacing between them
- Restyled navbar and buttons
- Documentation panel styled to match the editor

No editor behaviour was altered.

### 3. Layout

The original editor uses absolute positioning for the navbar and panels that can overflow on smaller screens. This fork uses flexbox:

- Navbar and panels stack without position hacks
- Panels have padding, border-radius, and gaps between them
- Minimised sidebars are wider and easier to click
- Layout holds together better across screen sizes

### 4. Offline documentation

The original docs iframe loads scripts from CDNs. An offline version (`docs/index.offline.html`) loads everything locally. A matching dark stylesheet (`docs/vivid-docs.css`) keeps the docs visually consistent with the editor.

### 5. Tracking removed

Google Analytics was removed from `index.html` and `create.html`. SumoMe was removed from `teach.html`. No third-party tracking scripts remain. Student activity in a learning environment should not be sent to external services.

### 6. Branding

This fork is clearly distinguished from the official WoofJS:
- Title: "WoofJS Offline Studio"
- Navbar badge: "Greyway Edition"
- Footer: "Offline Build — Local-first, no network required"

---

## UI Changes — Removed, Added, and Modified

Full breakdown of every UI element that was removed, added, or changed, and the reason for each.

### Elements Removed

| Element | Location | Reason |
|---|---|---|
| **Tutorials panel** (`#projects` / `#projectbar`) | `create.html` — fourth collapsible panel | Loaded tutorials from `//coding.space/woof/index.html` via iframe. External URL; does not load offline. A local conversion was attempted but broke during the process, so the panel was removed entirely rather than shipped in a broken state. |
| **Login / Sign Up buttons** | `create.html` navbar | Opened a Firebase authentication modal. No server or database exists in this offline build, so user accounts do not apply. |
| **Logged-in user dropdown** | `create.html` navbar | Displayed username, "New Project", "My Projects", "Logout", and recent projects from Firebase. All require a backend. |
| **Firebase login modal** (`#loginModal`) | `create.html` | Multi-screen modal for login, signup, password reset, and username migration. Depended on Firebase Auth. |
| **Username migration modal** (`#migrateModal`) | `create.html` | Prompted existing users to migrate usernames. Firebase-specific. |
| **Google Analytics script** | `index.html`, `create.html` | Third-party tracking. Removed for student privacy. |
| **SumoMe tracking script** | `teach.html` | Marketing/analytics widget. Same reason. |
| **Twitter/OG meta tags** | `create.html` | Social media preview tags pointing to `woofjs.com`. Not relevant to a local tool. |
| **"New Team Project" link** | User dropdown menu | Part of Firebase collaboration system. Cannot function offline. |
| **Firebase config block** | `create.html` JS | The `firebase.initializeApp(config)` block with API keys, auth listeners, and database calls. Replaced with `localStorage` saving. |
| **CDN `<script>` / `<link>` tags** | Every page | All external CDN links replaced with local paths from `vendor/external/`. |

### Elements Added

| Element | Location | Purpose |
|---|---|---|
| **"Greyway Edition" badge** | `create.html` navbar, `index.html` header | Distinguishes this fork from the official WoofJS. Uses `.edition-badge` class from `vivid-theme.css`. |
| **"Studio" / "Docs" nav pills** | `create.html` navbar | Replace the removed login buttons. One toggles the preview panel, the other toggles the docs panel. |
| **Offline status pill** | `index.html` header | "Live Preview" indicator with a green dot. Confirms the preview is running. |
| **"Start Coding" button** | `index.html` header and hero panel | Direct link to the editor. The original had three landing-page buttons; this retains the concept with restyled layout. |
| **Import button** | `create.html` navbar | Loads a `.woofjs`, `.js`, or `.txt` file from the local filesystem into the editor. Replaces cloud-based project loading. |
| **Assets modal** | `create.html` (navbar button + `#assetsModal`) | Upload images or audio, receive a data URL for use in code. Files stored in `localStorage` as base64. Supports drag-and-drop. 2 MB limit per file. The original had no local asset support. |
| **Local project saving** | `create.html` JS | Projects save to `localStorage`. Each save also triggers a `.woofjs` file download as a physical backup. |
| **Service Worker registration** | `create.html`, `index.html` | Registers `sw.js` on load. Caches all files for offline use after first visit. |
| **Web App Manifest** (`manifest.json`) | `<head>` of `create.html` and `index.html` | Enables installation as a standalone app on phones, tablets, and Chromebooks. |
| **Dark theme CSS variables** | `create.html` `<style>` block | Colour system: `--bg-0`, `--bg-1`, `--panel`, `--border`, `--text`, `--muted`, `--accent`, etc. Single point of control for theme colours. |
| **Dot-grid background pattern** | `create.html` `#page`, `index.html` `.hero-panel` | CSS `background-image` using radial-gradient dots. Decorative only. |
| **Panel border-radius and gaps** | `create.html` `#output`, `#docs`, `#code` | 16px border-radius and 14px gaps between panels. The original used flat-edge panels with no spacing. |
| **Glassmorphism navbar** | `create.html` `#navbar`, `index.html` `header` | Semi-transparent background with `backdrop-filter: blur(16px)`. The original was a solid `#6DC0F2` bar. |
| **Footer bar** | `index.html` | "Offline Build" on the left, "Local-first • No network required" on the right. The original had no footer. |
| **Hero panel with canvas preview** | `index.html` main section | Landing page right side shows a live iframe preview with "Preview Canvas" card. The original was an auto-typing CodeMirror editor over a background iframe. |
| **Two-panel landing layout** | `index.html` `main` | CSS Grid: `grid-template-columns: minmax(320px, 40%) 1fr`. The original was a single centred div over a fullscreen iframe. |
| **Script-blocked detection** | `create.html` JS `detectScriptSupport()` | Tests whether the browser allows inline scripts. Displays an error message instead of silently failing. |
| **Babel retry loop** | `create.html` JS `createRunCode()` | Retries up to 50 times at 100ms intervals if Babel has not finished loading from the local file. |
| **Startup error display** | `create.html` JS `startupFail()` | If Vue, CodeMirror, or js-beautify fail to load, displays a styled error message in the code panel instead of a blank screen. |
| **Theme persistence** | `create.html` JS | Selected CodeMirror theme saves to `localStorage` and restores on reload. The original stored this preference in Firebase. |

### Elements Modified

| Element | Original | This fork |
|---|---|---|
| **Navbar** | Solid `#6DC0F2`, 55px, absolute positioned, white text | `rgba(12,20,40,0.85)`, 68px, flex positioned, `backdrop-filter: blur`, border-bottom glow |
| **Panel headers** (`#PreviewNav`, `#DocsNav`, `#CodeNav`) | 25px, solid colour per panel, plain text | 38px, dark gradient, uppercase 11px tracking, muted text |
| **Panel minimised bars** | 25px wide, solid colour | 32px wide, dark translucent, 12px border-radius |
| **Error block** | Red Bootstrap alert, white background (`#f2dede`) | `rgba(255, 107, 107, 0.12)` background, `#ffdede` text |
| **Error highlight line** | `background-color: #f2dede` | Same class retained; appearance differs under dark CodeMirror theme |
| **Buttons (Run, Save, Tools)** | Standard Bootstrap `.btn-primary` / `.btn-warning` / `.btn-success` | Same classes with `vivid-theme.css` overrides: darker tones, pill shapes, gradient backgrounds |
| **Landing page buttons** | Three coloured rounded buttons | One primary "Start Coding" pill + subtle nav links |
| **Modals (Share, Save)** | Default Bootstrap white | `var(--panel)` background, `var(--border)` borders, `var(--text)` text |
| **Container layout** | `margin-top: 55px` below absolute navbar, flat panels | `flex-direction: column`, no position hacks, padding/border-radius/gaps |
| **Docs iframe src** | `./docs/index.html` | `./docs/index.html?v=greyway3` (cache-busted) |

---

## What Was Not Changed

- **`woof.js`** — the engine is untouched. Every sprite, loop, and game mechanic works identically.
- **Documentation content** — same blocks, examples, and explanations.
- **Showcase projects** — all present and functional.
- **Core editor features** — CodeMirror with the same hints, linting, themes, and keyboard shortcuts.

Code written in this version runs the same way on the original woofjs.com.

---

## How to Use It

1. Download or clone this repository.
2. Open `index.html` in any browser, or go directly to `create.html` to start coding.
3. No install, no server, no internet required.

For the Service Worker to function (enabling full offline caching after first load), serve the folder with any HTTP server — `python -m http.server` is sufficient.

---

## File Overview

| File / Folder | Purpose |
|---|---|
| `index.html` | Landing page with live code preview |
| `create.html` | Main coding editor |
| `full.html` | Full-screen project viewer |
| `woof.js` | WoofJS engine (unchanged) |
| `run-code.js` | Runs student code in the preview iframe |
| `sw.js` | Service Worker for offline caching |
| `manifest.json` | Web App Manifest for device installation |
| `ui/vivid-theme.css` | Dark theme stylesheet |
| `docs/` | Documentation pages and assets |
| `docs/vivid-docs.css` | Dark theme for the docs |
| `docs/index.offline.html` | Offline version of the docs |
| `vendor/` | All third-party libraries, stored locally |
| `showcase/` | Example projects |
| `teach.html` | Information page for educators |

---

## The `throwaways/` Folder

Contains files from the original WoofJS repo that are not used in this offline build. They were moved here rather than deleted so the removal is visible and reversible.

| File | Reason for removal |
|---|---|
| `CNAME` | Contains `woofjs.com`. Tells GitHub Pages to serve this repo as that domain. Not applicable to this fork. |
| `.env.local` | Placeholder API key from a separate prototype. Not related to WoofJS. Environment files should not be committed. |
| `metadata.json` | Named the project "VividJS Studio". Leftover from the same prototype. Not referenced by anything. |
| `package.json` | Lists React, Vite, and TypeScript as dependencies. None are part of this project. Would mislead anyone running `npm install`. |
| `tmp.txt` | Empty file. |
| `sw-files.txt` | Plain text file list, likely a scratchpad for building the Service Worker. Not read by any code. |
| `jquery-1.12.4.js` | Duplicate jQuery. No page loads it; `create.html` uses the minified copy in `vendor/external/jquery/`. |
| `firebase-migrations.js` | Contains one comment line: "firebase migrations removed." Not referenced by any page. |
| `lib/beautify.js` | Code beautifier (2,389 lines). Duplicate; `create.html` loads its copy from `vendor/external/js-beautify/`. |
| `themes/base/jquery-ui.css` | jQuery UI stylesheet (1,311 lines). Duplicate; the editor loads the minified version from `vendor/external/jquery-ui/`. |
| `1.12.1/jquery-ui.js` | Unminified jQuery UI. Duplicate; the minified version is in `vendor/external/jquery-ui/`. |
| `analytics.html` | Analytics dashboard. Requires Firebase and Google Analytics. Does not function offline. |
| `team-full.html` | Team collaboration page. Requires Firebase and Firepad. Online-only. |
| `team.html` | Team collaboration. Same dependency. Online-only. |
| `workflow.html` | Task management page tied to Firebase. Online-only. |
| `user.html` | User profile page. Loads projects from Firebase. Online-only. |
| `guide.html` | Teacher guide. Was already a redirect stub. |
| `create2.html` | Redirect to `create.html`. Redundant. |

---

## Thank You, Uncommon

Shoutout to [Uncommon](https://uncommon.org) for the internet and the learning opportunities.

---

## License

MIT License — same as the original. See [LICENSE.md](LICENSE.md) for details.
