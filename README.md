<p align="center">
  <img src="./logo.png" alt="i-have-adhd" width="140" />
</p>
<p align="center">
  <strong align="center">ADHD-friendly outputs. No ADHD diagnosis needed!</strong>
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

Open Claude Code — the rules load automatically at session start (a `SessionStart` hook injects them; no command needed). To re-apply them mid-session: `/i-have-adhd:apply`.

To disable: `claude plugin disable i-have-adhd` or use `/plugin disable i-have-adhd` from within CC. This disables the hook too.

More in [INSTALL.md](./INSTALL.md).

## What it does

A Claude Code plugin that stops burying the answer. Claude does the work itself, leads with the outcome, numbers what's left, and never says "Hope this helps!"


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

Rule 0 plus 8 rules. Full text in [SKILL.md](./skills/apply/SKILL.md).

0. Do the work, don't assign it — never hand the reader a command Claude can run itself.
1. Lead with the outcome or the reader's action; end when the answer is done.
2. Number multi-step work; keep the position on screen ("step 3 of 5 done").
3. One thread at a time — but safety findings are never tangents.
4. One concrete next step, or say there is none.
5. Estimate only the reader's hands-on time, anchored to a condition.
6. Wins and errors equally plain: what works and how to see it; cause and fix, no apologies.
7. Cap unordered lists at five; never compress a procedure or cut a findings inventory.
8. Decide the small things yourself — every question hands the reader a task.

Plus: silence between tool calls, and a re-grounding summary after long runs.

## Tune it

Edit `skills/apply/SKILL.md` in your checkout, then re-sync the installed copy: `claude plugin marketplace update i-have-adhd && claude plugin update i-have-adhd`, then restart Claude Code. The hook reads the installed copy under Claude's plugin dir, not your checkout, so `/clear` alone won't pick up edits. `/i-have-adhd:apply` re-applies the currently-loaded rules mid-session.

When a rule drifts, simplify rather than tighten: one sentence of goal plus reason ("Start with the answer — the reader acts on the first line") beats a longer blocklist. On current models, ALL-CAPS emphasis and forbidden-phrase lists reduce compliance.

## Credits

Originally created by [Ayoub G.](https://github.com/ayghri/i-have-adhd). This fork rewrites the rules for Claude's current model generation and makes them always-on via a SessionStart hook.

Loosely based on *The Adult ADHD Tool Kit* by J. Russell Ramsay and Anthony L. Rostain. Adapted for how an LLM should respond, not how a human should organize their day.

## License

MIT.

Star ⭐ if it saved you one scroll past one "Great question!"
