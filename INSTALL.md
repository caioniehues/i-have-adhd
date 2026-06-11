# Install i-have-adhd

A Claude Code plugin: one skill plus a `SessionStart` hook that keeps the rules always-on.

## TL;DR

```bash
git clone https://github.com/caioniehues/i-have-adhd ./i-have-adhd
claude plugin marketplace add ./i-have-adhd
claude plugin install i-have-adhd@i-have-adhd
```

Open Claude Code. The rules load automatically at session start — no command needed. `/i-have-adhd:apply` re-applies them mid-session.

To disable: `claude plugin disable i-have-adhd` (or `/plugin disable i-have-adhd` from within Claude Code). This disables the hook too. Re-enable later with `enable` instead of `disable`, then restart Claude Code so the SessionStart hook re-registers (hooks are read at startup).

Requirement: the hook is a POSIX shell script — works out of the box on Linux/macOS; on Windows use Git Bash or WSL.

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

The plugin ships a `SessionStart` hook (`hooks/hooks.json` → `hooks/inject-rules.sh`) that prints the rules from `skills/apply/SKILL.md` into Claude's context at startup, on resume, after `/clear`, and after compaction. The rules apply deterministically from message one — no per-message skill trigger, no extra tool round-trip.

Want the rules without the hook (e.g. hooks disabled in your environment)? Paste the body of `skills/apply/SKILL.md` (everything below the frontmatter) into `~/.claude/CLAUDE.md`. Don't reference the skill by name there — CLAUDE.md can't load skill content.

## Troubleshooting

**Rules not active in a new session.** Check `claude plugin list` shows `i-have-adhd (enabled)`. Hooks need a POSIX shell (`sh`/`awk`); on Windows run Claude Code from Git Bash. Restart Claude Code — plugins and hooks are read at startup.

**`/i-have-adhd:apply` not in autocomplete.** Restart Claude Code. The plugin index is read at startup.

**`claude plugin marketplace add` fails.** Point at the repo root, not at `.claude-plugin/`. The path must contain `.claude-plugin/marketplace.json`.

**Model still preambles.** Open a new session — old context may carry. If it still drifts, simplify rather than tighten: in `skills/apply/SKILL.md`, rewrite the drifting rule as one sentence of goal plus reason, and replace any forbidden-phrase list with that brief principle. On current models, longer blocklists and ALL-CAPS emphasis reduce compliance. Then re-sync and restart (see "Want different rules" below) so the hook picks up the edit.

**Want different rules.** Edit `skills/apply/SKILL.md` in your checkout, then re-sync and restart: `claude plugin marketplace update i-have-adhd && claude plugin update i-have-adhd`, then restart Claude Code. `/clear` re-injects whatever is in the installed copy, so the re-sync and restart must come first.
