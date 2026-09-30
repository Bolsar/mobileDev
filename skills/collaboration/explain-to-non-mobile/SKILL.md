---
name: explain-to-non-mobile
description: Explain a mobile concept, constraint or decision to a Business Owner or a Non-mobile Developer by mapping it to what they already know. Use when they ask "why does this take so long?", "why can't we just…?", "what is X?", or when a decision needs their buy-in.
---

# Explain to Non-mobile

Explain in their world, then in ours. Pitch per Requester ([AGENTS.md](../../../AGENTS.md) §1). Never talk down; they are experts in their own field.

## Steps
1. **Find the real question.** "Why can't we just hotfix?" is usually "when will End Users stop seeing this bug?". Answer that.
2. **Answer in one sentence first.**
3. **Map it** to something they know (table below). Done when the analogy holds for the part that matters, and you say where it breaks.
4. **Give the consequence** in their terms: cost, time, risk, End User experience.
5. **End with the decision or action** they need to take, if any, with your recommendation.

## Analogies
| Mobile | Business Owner | Non-mobile Developer |
|---|---|---|
| Store release | Printing and mailing a catalog: can't recall copies already sent | A deploy you can't roll back, reviewed by a third party, that users install when they feel like it |
| Old app versions | Customers still using last year's catalog | Many client versions hitting your API at once, for years |
| Force update | Refusing orders from the old catalog | A minimum client version check at the API |
| Process death | The phone throws your app out of memory to save battery, the End User expects it back as they left it | The server can kill your process at any time; state must be persisted, not in RAM |
| Offline | Working on a plane | Every request can fail; the local DB is the source of truth, the API is sync |
| Two platforms | Two shops, two landlords, two sets of rules | Two runtimes, two SDKs, two stores; cross-platform shares code, not the release process |
| Permissions | Asking a customer's consent in the right moment | Runtime-granted capabilities the user can revoke any time |
| Store review | An inspector who checks every release, 1–2 days, sometimes rejects | A mandatory external CI gate you don't control |

## Output
```
Short answer: …
Like: <analogy> — where it breaks: …
What it means for you: cost/time/risk
Decision needed: … — I recommend: …
```
Business Owner: no jargon; a technical term gets one plain sentence. Non-mobile Developer: technical terms are fine; map them.
