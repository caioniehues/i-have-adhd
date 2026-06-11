# Changelog

## 1.3.0 — 2026-06-11

### Added
- **Rule 11: evidence-backed disagreement** ("Disagree when you checked and it changes what the reader does"). Conjunctive gate where confident means you looked — read the line, run the check, then pick the lane; an unchecked premise is a verdict deferred, not a low-confidence one. Shape: correctness-grade verdicts lead under rule 1, lesser-but-decision-changing findings get their own line; verdict → one piece of evidence → the better fork as a tap, with destructive forks staying under break-rule 3 (alone, never "(Recommended)"). Evaluative asks ("what do you think?") get the judgment you would defend — "this holds up" is a verdict, an invented flaw is not. Two-sided frequency governor: pushing back every turn means the bar is too low (manufactured contrarianism is the validation reflex inverted); turns of real decisions with no premise ever flagged means it is too high, or the checking stopped. After the verdict, no new machinery: pushback is rule 6's, an overrule is rule 3's.

### Changed
- **Rule 6 holds verified claims under pushback.** A correct answer survives "are you sure?" — re-derived from the evidence, not the reader's displeasure. A new fact or a checkable argument updates; restated preference or pressure alone does not.
- **Rule 3 hosts the overrule lifecycle.** A confident disagreement is stated once, then settled; overruled, it is recorded on screen and re-raised only on correctness/data-loss-grade new evidence.
- **Rule 8's "equivalent" is now load-bearing.** An option costing a redone deliverable, an exposure, or a trusted-wrong signal leaves the silent-pick lane via rule 11; a merely-tidier alternative is still picked silently.
- **Rule 10 routes shaky premises by commitment.** Open fork → your read is the "(Recommended)" option, whatever your confidence; committed premise → checked first, then rule 11's verdict; checked-but-still-uncertain → back into the round with the dissent as "(Recommended)".
- **Break-rule 6 carve-out.** Casual phrasing does not lower the bar on a wrong or risky premise — at rule 1's grade (wrong, unsafe, data-losing), not any concern with stakes; evaluative asks keep rule 11's bar in the casual register.
- Frontmatter description and `/i-have-adhd:apply` skill description gain "evidence-backed disagreement"; `plugin.json` bumped to 1.3.0.

## 1.2.0 — 2026-06-11

### Added
- **Rule 10: the interview gate.** Before substantive work starts, every assumption forced by the prompt is sorted: cosmetic doubts (a name, a default) stay self-decided per Rule 8; deliverable-changing doubts (intent, scope, audience, constraints — a wrong guess means redone work) become tappable structured-question rounds, up to four questions each, recommended option first so a round clears in taps. Rounds repeat until doubts run out, then a one-to-two-line spec echo and work starts in the same message — never "shall I proceed?". Ambiguity-gated with a deliberately low bar (forming an assumption counts as a doubt), but doubts the codebase or the conversation already answer are struck, never re-asked. Degraded modes specified: missing question tool → compact numbered list; unattended runs → self-pick recommended options and name every resolved doubt in the spec echo; plan mode → the spec becomes the plan.
- **`/i-have-adhd:interview` skill.** Explicit trigger ("interview me"): fires the gate regardless of prompt clarity and promotes cosmetic doubts into the rounds. Thin loader over the output style, same as `/i-have-adhd:apply`.

### Changed
- **Rule 8 and break-rule 5 now route through the interview.** "Real ambiguity → one short clarifying question" is replaced by the doubt vocabulary and a pointer to Rule 10; destructive-action confirms explicitly stay under break-rule 3 — never batched into a round, never labeled "(Recommended)".

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
