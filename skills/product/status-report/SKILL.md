---
name: status-report
description: Write a short status update on mobile work (done, next, blocked, risks, release state) pitched for the Requester's audience. Use when asked for a status, weekly update, stakeholder summary or release summary.
---

# Status Report

Short, honest, and about outcomes. Bad news early and plainly; a surprise at launch costs more trust than a warning today.

## Steps
1. **Gather facts**, not memory: merged PRs and commits since the last report, ticket states, build and release state (TestFlight / internal testing / in review / % rolled out), crash-free rate and top crash, blockers.
2. **Translate work into outcomes**: "End Users can now pay with Apple Pay (in TestFlight)" beats "merged PaymentSheet refactor".
3. **Compare to plan**: on track, at risk or late, against the last promised date. At risk → say why and what would bring it back.
4. **Name blockers with an owner and a date needed**, and the ask.
5. **Keep it under ~15 lines.** Link details; don't paste them.

## Output
```
Status: on track | at risk | late — <one-line reason>
Done: …
Next: …
Blocked: item — needs <who> by <date>
Risks: …
Release: version — stage — rollout % — crash-free %
```
Business Owner: no ticket IDs or code terms; state dates and End User impact. Mobile Developer: terse, links to PRs and tickets.
