# Install i-have-adhd

Caio's personal Claude Code plugin: an output style that auto-applies while the plugin is enabled, plus a skill to re-apply the rules mid-session. The rules are tuned to his preferences — fork the repo and edit `output-styles/i-have-adhd.md` to tune them to yours.

## TL;DR

```bash
git clone https://github.com/caioniehues/i-have-adhd ./i-have-adhd
claude plugin marketplace add ./i-have-adhd
claude plugin install i-have-adhd@i-have-adhd
```

Open Claude Code. The rules apply from message one via the plugin's output style — no command needed. `/i-have-adhd:apply` re-applies them mid-session.

To disable: `claude plugin disable i-have-adhd` (or `/plugin disable i-have-adhd` from within Claude Code). This removes the output style too. Re-enable later with `enable` instead of `disable`, then restart Claude Code so the style re-registers.

No hooks, no shell scripts — works the same on Linux, macOS, and Windows.

## Verify

```bash
claude plugin list
```

Look for `i-have-adhd  (enabled)`. Then start a new session and ask anything — the answer should lead with the outcome or an action, no "Great question!".

## Update

```bash
cd ./i-have-adhd && git pull
claude plugin marketplace update i-have-adhd
claude plugin update i-have-adhd
```

Restart Claude Code to apply — `claude plugin update` re-snapshots the new commit and the restart reloads it. `git pull` alone does nothing: the installed plugin is a copy under Claude's plugin store, not your checkout. See [CHANGELOG.md](./CHANGELOG.md) for what changed.

## Uninstall

```bash
claude plugin uninstall i-have-adhd
claude plugin marketplace remove i-have-adhd
```

## Always-on: how it works

The plugin ships an output style (`output-styles/i-have-adhd.md`) with two frontmatter flags:

- `force-for-plugin: true` — Claude Code applies the style automatically whenever the plugin is enabled; no selection needed.
- `keep-coding-instructions: true` — the style is appended to the system prompt alongside Claude Code's built-in engineering guidance instead of replacing it.

Because the rules live in the system prompt, they survive `/clear`, resume, and compaction inherently — nothing is re-injected per session, and there is no shell-script dependency.

One sharp edge to know: while the plugin is enabled, its forced style takes precedence over an `outputStyle` you picked yourself in settings or `/config`. If several enabled plugins each force a style, the first-loaded one wins.

Want the rules without the plugin (or with your own output style)? Paste the body of `output-styles/i-have-adhd.md` (everything below the frontmatter) into `~/.claude/CLAUDE.md`.

## Troubleshooting

**Rules not active in a new session.** Check `claude plugin list` shows `i-have-adhd (enabled)`. Restart Claude Code — plugins are read at startup (`/reload-plugins` then `/clear` also works for plugin changes mid-flight).

**`/i-have-adhd:apply` not in autocomplete.** Restart Claude Code. The plugin index is read at startup.

**`claude plugin marketplace add` fails.** Point at the repo root, not at `.claude-plugin/`. The path must contain `.claude-plugin/marketplace.json`.

**Your own output style stopped applying.** That's the `force-for-plugin` flag — while this plugin is enabled, its style overrides your `outputStyle` setting. Disable the plugin to get your style back, or merge the rules into your style manually (see "Always-on: how it works").

**Model still preambles.** Open a new session — old context may carry. If it still drifts, simplify rather than tighten: in `output-styles/i-have-adhd.md`, rewrite the drifting rule as one sentence of goal plus reason, and replace any forbidden-phrase list with that brief principle. On current models, longer blocklists and ALL-CAPS emphasis reduce compliance. Then re-sync and restart (see "Want different rules" below).

**Want different rules.** Edit `output-styles/i-have-adhd.md` in your checkout, then re-sync and restart: `claude plugin marketplace update i-have-adhd && claude plugin update i-have-adhd`, then restart Claude Code. The installed plugin is a snapshot, so the re-sync and restart must come first.
