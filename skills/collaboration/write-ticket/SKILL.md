---
name: write-ticket
description: Write a ticket (feature, bug or tech task) that a mobile developer can build and test without a follow-up meeting. Use when asked to create or improve a ticket, story or issue, or to break a feature into tickets.
---

# Write Ticket

A good ticket is small, testable and complete on the mobile specifics everyone forgets. Match the tracker's template if the project has one. When a tracker tool (Linear, Jira, GitHub) is available and the Requester asks, create it there; otherwise output markdown.

## Steps
1. **Pick the type**: feature, bug or tech task. Each has its own must-haves below.
2. **Slice vertically** ([mindset/planning.md](../../../mindset/planning.md) §1). One ticket = one End User–visible slice through UI, state, data and API that ships alone, ideally behind a flag. Done when each ticket passes INVEST [S76]; split any that doesn't fit in a few days.
3. **Write acceptance criteria** as Given/When/Then [S77], one per behavior, including unhappy paths. Done when a tester could tick them without asking.
4. **Add the mobile must-haves** for the type. Mark unknowns as open questions with a proposed answer, not as blanks.

## Must-haves
- **Feature**: End User and goal; design link; all states (loading, empty, error, offline); platforms; min OS; API contract link or "needs contract"; analytics events; flag name; accessibility and localization notes; out of scope.
- **Bug**: steps to reproduce; expected vs actual; app version and build, device, OS version, network; frequency (always / sometimes / once); crash log or screenshot; affected users (%) from crash tool; regression since which version.
- **Tech task**: problem and its cost today; done definition; risk and how it's verified; End User–visible impact (usually "none").

## Output
```
Title: <verb> <thing> (<platform if one>)
Context: …
Acceptance criteria:
- Given … When … Then …
Mobile: states · platforms · min OS · API · flag · analytics · a11y · l10n
Out of scope: …
Open questions: question — proposed answer
```
For a Business Owner writing their first tickets: fill what you can from the conversation and ask only for the End User goal and priority.
