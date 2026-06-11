# Changelog

## 1.1.0 — 2026-06-11

### Changed
- **Always-on mechanism: SessionStart hook → output style.** The plugin now ships `output-styles/i-have-adhd.md` with `force-for-plugin: true` (auto-applies whenever the plugin is enabled) and `keep-coding-instructions: true` (appends to Claude Code's built-in engineering guidance instead of replacing it). System-prompt placement is higher-authority and prompt-cached, survives `/clear`/resume/compaction without re-injection, and drops the POSIX-shell requirement — Windows now works without Git Bash. `hooks/` is removed. Sharp edge: while the plugin is enabled, its style overrides a user-selected `outputStyle`.
- **`/i-have-adhd:apply` is now a thin loader.** The skill reads the output style file instead of duplicating the rules — one source of truth, no drift.
- **Docs reframed as a personal plugin.** This fork is Caio's daily-driver output style; the rules encode his preferences. Fork and edit `output-styles/i-have-adhd.md` to tune it.

### Added
- **Rule 9: rare ★ Insight boxes.** Borrowed from Claude Code's Explanatory output style, retuned for an ADHD reader: only when the work surfaces something genuinely non-obvious, placed mid-message (never the first or last line — those belong to the outcome and the next action), max two sentences, one idea per box.

## 1.0.0 — 2026-06-11

First versioned release of this fork (of [ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd)).

### Changed
- **Rules rewritten for the current Claude model generation** (Fable 5 era). Forbidden-phrase blocklists and the mechanical pre-send checklist are gone — current models follow brief goal-plus-reason principles better than enumerated bans. The 10 rules are now Rule 0 + 8 rules.
- **New Rule 0: "do the work, don't assign it."** The old rules coached Claude to hand the user commands the agent should run itself. All examples are now agent-voice.
- **Always-on by default.** A `SessionStart` hook (`hooks/inject-rules.sh`) injects the rules into context at startup, on resume, after `/clear`, and after compaction — deterministic, no per-message skill trigger. The manual `~/.claude/CLAUDE.md` setup is no longer needed.
- **Skill directory moved**: `skills/i-have-adhd/` → `skills/apply/`. The command name now derives from the folder (frontmatter no longer sets `name:`), so invoke with `/i-have-adhd:apply` (was `/i-have-adhd:i-have-adhd`; docs previously claimed `/i-have-adhd`, which never worked). The skill is now for mid-session re-application; the hook handles the always-on case.
- New guidance: silence between tool calls, re-grounding summaries after long autonomous runs, autonomy on minor choices, condition-anchored time estimates for the reader's work only, findings inventories never truncated, plan-mode and casual-conversation exceptions.
- `plugin.json`: added `version`, `author`, `homepage`.
