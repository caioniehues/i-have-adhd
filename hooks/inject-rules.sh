#!/bin/sh
# SessionStart hook: emit the i-have-adhd rules into Claude's context.
# Prints a one-line framing header, then the SKILL.md body with only the
# leading YAML frontmatter removed (all body content is preserved, including
# any `---` horizontal rules). SessionStart stdout is added to Claude's
# context, so the rules are active from message one — no per-message skill
# invocation needed.
printf 'Standing instructions — apply to every response in this session, regardless of topic:\n\n'
awk 'p{print; next} /^---$/{c++; if(c==2) p=1}' "${CLAUDE_PLUGIN_ROOT}/skills/apply/SKILL.md"
