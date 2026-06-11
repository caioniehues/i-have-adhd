<p align="center">
  <img src="./logo.png" alt="i-have-adhd" width="140" />
</p>
<p align="center">
  <strong align="center">ADHD-friendly outputs. No ADHD diagnosis needed!</strong>
</p>
<p align="center">
  <em>My personal Claude Code plugin &amp; output style — opinionated by design, tuned to one brain (mine). Fork it to tune it to yours.</em>
</p>
<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/github/license/caioniehues/i-have-adhd?style=flat" alt="License"></a>
</p>


## Install

```bash
git clone https://github.com/caioniehues/i-have-adhd ./i-have-adhd
claude plugin marketplace add ./i-have-adhd
claude plugin install i-have-adhd@i-have-adhd
```

Open Claude Code — the plugin ships an output style that auto-applies while the plugin is enabled, so the rules are active from message one (no command, no hook). To re-apply them mid-session: `/i-have-adhd:apply`. To be interviewed into a spec before work starts: `/i-have-adhd:interview` (or just say "interview me").

To disable: `claude plugin disable i-have-adhd` or use `/plugin disable i-have-adhd` from within CC. This removes the output style too.

More in [INSTALL.md](./INSTALL.md).

## What it does

My personal Claude Code plugin — the output style I run in every session. It stops burying the answer: Claude does the work itself, leads with the outcome, numbers what's left, and never says "Hope this helps!"

Because it's personal, the rules encode my preferences (down to how often an ★ Insight is allowed to appear). If yours differ, fork and edit one file — see [Tune it](#tune-it).


## What changes


<table>
<tr>
<td width="50%">

## Before

> Great question! Let me think about this. Your auth flow has a few moving pieces: the middleware, the token verification, and the cookie handling. Looking at `src/auth.ts`, the `verifyToken` function (around lines 42-58) seems to be using an older `jsonwebtoken` API. One approach would be to update the package and rewrite that function. After making the change, you'd want to run the auth tests to confirm nothing breaks. By the way, you might also want to look at your dependency versions overall. Hope this helps! Let me know if you want to dig deeper.

</td>

<td width="50%">

## After

> Fixed: `verifyToken` (`src/auth.ts:42-58`) now uses `jwt.verify` from `jsonwebtoken@9`.
>
> 1. Installed `jsonwebtoken@9`
> 2. Rewrote `verifyToken`
> 3. `npm test -- auth.spec.ts`: 12/12 pass
>
> Next: nothing on you. Separately: there's a stale dependency — handle it next?

</td>
</tr>
</table>


## The rules

Rule 0 plus 11 rules. Full text in [the output style](./output-styles/i-have-adhd.md).

0. Do the work, don't assign it — never hand the reader a command Claude can run itself.
1. Lead with the outcome or the reader's action; end when the answer is done.
2. Number multi-step work; keep the position on screen ("step 3 of 5 done").
3. One thread at a time — but safety findings are never tangents.
4. One concrete next step, or say there is none.
5. Estimate only the reader's hands-on time, anchored to a condition.
6. Wins and errors equally plain: what works and how to see it; cause and fix, no apologies.
7. Cap unordered lists at five; never compress a procedure or cut a findings inventory.
8. Decide the small things yourself — every question hands the reader a task.
9. Box the rare non-obvious thing as an ★ Insight — two sentences max, never the first or last line.
10. Interview before guessing — doubts that would change the deliverable become tappable question rounds, then a spec echo, then work.
11. Disagree when you checked and it changes what the reader does — verdict, one piece of evidence, the better fork as a tap; never manufactured.

Plus: silence between tool calls, and a re-grounding summary after long runs.

## ★ Insights

Borrowed from Claude Code's Explanatory output style, retuned for an ADHD reader: an insight appears only when the work surfaced something genuinely non-obvious — a gotcha, a hidden tradeoff, a pattern you'll meet again. Most answers have none; the marker only works while it's rare. It sits mid-message (the first line stays the outcome, the last line stays your next action), so it's as easy to skip as to spot:

```
★ Insight ─────────────────────────────────
jwt.decode parses the token but never checks
the signature — auth that "works" with it is
silently unverified.
───────────────────────────────────────────
```

## The interview

Writing a clear spec is the hardest part of prompting with ADHD; tapping through multiple-choice questions is cheap. So when a prompt forces an assumption that would change what gets built — intent, scope, audience, constraints — Claude interviews instead of silently guessing: batched rounds of up to four tappable questions, recommended answer always first (it's the guess Claude would have made silently, surfaced for a one-tap veto). When the doubts run out, it echoes the agreed spec in a line or two and starts immediately. Small calls (a name, a default) are still decided without asking, and nothing you already said — in the prompt, the conversation, or the code — gets re-asked.

Say "interview me" or run `/i-have-adhd:interview` to fire it on demand, even on a prompt that looks clear.

## Tune it

Edit `output-styles/i-have-adhd.md` in your checkout, then re-sync the installed copy: `claude plugin marketplace update i-have-adhd && claude plugin update i-have-adhd`, then restart Claude Code. Claude Code loads the installed copy under its plugin dir, not your checkout, so `/clear` alone won't pick up edits. `/i-have-adhd:apply` re-applies the currently-installed rules mid-session.

When a rule drifts, simplify rather than tighten: one sentence of goal plus reason ("Start with the answer — the reader acts on the first line") beats a longer blocklist. On current models, ALL-CAPS emphasis and forbidden-phrase lists reduce compliance.

## Credits

Originally created by [Ayoub G.](https://github.com/ayghri/i-have-adhd). This fork rewrites the rules for Claude's current model generation and makes them always-on via a force-applied output style. It's my daily-driver configuration: rules and defaults follow my preferences and may change without notice — fork freely.

Loosely based on *The Adult ADHD Tool Kit* by J. Russell Ramsay and Anthony L. Rostain. Adapted for how an LLM should respond, not how a human should organize their day.

## License

MIT.

Star ⭐ if it saved you one scroll past one "Great question!"
