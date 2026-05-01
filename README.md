# Obsidian Vault Template

A starter Obsidian vault wired up for personal knowledge management. It combines:

- **Categories + Bases** — dynamic, query-driven views over your notes
- **Templater** — scripted templates for daily notes, meetings, journals, and creating new categories on the fly
- **Optional Claude Code integration** — slash commands for vault maintenance

Everything ships configured. Open the folder as an Obsidian vault and start writing.

---

## What's inside

```
.
├── Categories/         # Hub pages for each topic area (Knowledge, Projects, Career)
├── Templates/          # Note templates + Bases/ (the .base view definitions)
├── Notes/              # Where new notes land (Ctrl+N)
├── Daily/              # Daily journal entries
├── Resources/          # Long-form clipped articles, references
├── Clippings/          # Inbox for the Obsidian Web Clipper
├── Attachments/        # Images and binaries
├── .obsidian/          # Plugin and theme bundles, hotkeys, app config
├── .claude/            # Optional Claude Code slash commands for vault maintenance
└── new-category.sh     # Shell script: create a new category in one command
```

## First-time setup

1. **Clone or download** this repo.
2. **Open the folder as a vault** in Obsidian (`Open folder as vault…`).
3. **Trust the author** when prompted — required to run the bundled community plugins.
4. **Enable plugins**: Settings → Community plugins → toggle on:
   - **Templater** (required — drives the dynamic templates)
   - **Excalidraw** (optional — drawings)
   - **Obsidian Git** (optional — git sync from inside Obsidian)
5. **Optional theme**: Settings → Appearance → Theme → **Minimal** (already bundled).
6. **Verify Bases is enabled**: Settings → Core plugins → **Bases** should be on. (Required for the `.base` view files to render.)

## Core concepts

### Categories + Bases

Every note can be tagged with one or more categories via frontmatter:

```yaml
---
categories:
  - "[[Knowledge]]"
tags:
  - books
---
```

Each category has a hub page (`Categories/Knowledge.md`) that embeds a `.base` view (`Templates/Bases/Knowledge.base`). The `.base` file is a YAML query that filters all notes with that category and renders them as a sortable, filterable table inside Obsidian.

Open `Categories/Knowledge.md` to see the All view of every Knowledge note.

### Templater flows

Three keyboard-driven entry points:

- **`Ctrl+N`** — create a new ZK-prefixed note in `Notes/` (timestamped filename)
- **`Ctrl+T`** — open the Templater picker; choose any template under `Templates/`
- **`Ctrl+[` / `Ctrl+]`** — previous / next tab

Available templates:
- `Daily Note Template` — for `Daily/` entries (also auto-triggered by the daily-notes core plugin)
- `General Template` — minimal frontmatter for a new note
- `Journal Template` — dated journal entry
- `Meeting Template` — meeting notes with org and tags fields
- `New Category` — interactive wizard: prompts for a category name and creates both `Categories/X.md` and `Templates/Bases/X.base`

### Notes / Resources / Daily / Clippings — what goes where

| Folder | Purpose |
|---|---|
| `Notes/` | Original writing — your thoughts, summaries, drafts |
| `Resources/` | External material you're keeping for reference (articles, papers) |
| `Daily/` | Daily journal entries, one per day |
| `Clippings/` | Inbox for the Obsidian Web Clipper. Process via `/process-clippings` |
| `Attachments/` | Images, PDFs, binaries — referenced from notes |

## Adding a new category

Two equivalent ways:

```bash
./new-category.sh Books
```

Or inside Obsidian: `Ctrl+T` → choose `New Category` → type the name when prompted.

Both create `Categories/Books.md` + `Templates/Bases/Books.base` with sensible defaults. Edit the `.base` file to add filtered sub-views, customize columns, etc.

## Claude Code integration (optional)

If you use [Claude Code](https://claude.com/claude-code), six vault-maintenance slash commands ship in `.claude/commands/`:

| Command | What it does |
|---|---|
| `/new-category` | Create a category page + base file (alternative to the shell script) |
| `/new-template` | Scaffold a new note template with optional `.base` and dashboard |
| `/add-subview` | Add a filtered sub-view tab to an existing category's `.base` file |
| `/move-resources` | Move all resources matching a tag from one category to another |
| `/split-tag` | Analyze a tag, propose subcategories, and re-tag resources |
| `/process-clippings` | Categorize and tag everything in `Clippings/`, then move into `Resources/` |

The bundled `.claude/settings.json` is intentionally minimal — add your own permissions as you go.

## Keyboard shortcuts

| Shortcut | Action |
|---|---|
| `Ctrl+N` | New ZK-prefixed note in `Notes/` |
| `Ctrl+T` | Templater: create new note from template |
| `Ctrl+[` | Previous tab |
| `Ctrl+]` | Next tab |

Customize in Settings → Hotkeys.

## Customizing the starter categories

The vault ships with three placeholder categories: **Knowledge**, **Projects**, **Career**. To rename one (e.g. `Knowledge` → `Reading`):

1. Rename `Categories/Knowledge.md` → `Categories/Reading.md`
2. Rename `Templates/Bases/Knowledge.base` → `Templates/Bases/Reading.base`
3. Inside `Reading.base`, update the filter `categories.contains(link("Knowledge"))` → `link("Reading")`
4. Inside `Reading.md`, update the embed `![[Knowledge.base#All]]` → `![[Reading.base#All]]`

Or just delete a starter category you don't want and create new ones via `new-category.sh`.

## What's NOT included (you bring your own)

- **Obsidian Sync** — paid, account-bound. If you want device sync, set up your own subscription or use Git (the bundled obsidian-git plugin works well).
- **Claude Code global memory** — lives in `~/.claude/projects/...`, per-user. Not portable.
- **MCP servers** (e.g. local search like QMD) — install separately if you want LLM-assisted vault search.

## License

MIT — see [LICENSE](LICENSE). Originally derived from Steph Ango's Obsidian sample vault.
