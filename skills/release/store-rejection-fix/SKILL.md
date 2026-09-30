---
name: store-rejection-fix
description: Diagnose an App Store or Google Play rejection, policy warning or suspension, and produce the fix and the reply to the reviewer. Use when the Requester pastes a rejection message, a guideline number, or says "Apple rejected our app" / "Play removed our app".
---

# Store Rejection Fix

Read the exact message and the exact guideline, then fix the smallest thing that satisfies it. Policies change often: fetch the current text of the cited guideline [S9][S10] before advising; don't quote from memory.

## Steps
1. **Get the full text**: rejection message, guideline or policy cited, screenshots and any attachments from the reviewer, the build/version, and what changed since the last approved version.
2. **Classify**:
   - *Bug or crash* the reviewer hit → reproduce on their device/OS (iPad counts for iPhone apps on iOS).
   - *Missing info* → demo account, review notes, explanation of a feature.
   - *Metadata* → screenshots, description, privacy label or Data safety mismatch.
   - *Policy* → the feature itself conflicts with a rule (payments, login options, user-generated content moderation, permissions use, minimum functionality, account deletion).
3. **Decide the path**: fix and resubmit; reply with clarification when the reviewer misunderstood (with steps and screenshots); appeal only when you're sure the rule doesn't apply (Apple: App Review Board [S98]; Play: appeal in the Policy Center).
4. **Fix the smallest thing** that satisfies the rule. Where the rule allows several options, pick the one that changes least for End Users. If the fix needs a product decision (e.g. payment method), stop and explain the options to the Requester.
5. **Check siblings**: the same issue on the other platform, and other screens with the same pattern, so the next review doesn't reject for it again.
6. **Reply** to the reviewer: short, polite, specific, what changed and where to find it.

## Output
```
Cause: <category> — guideline <number> — plain summary
Fix: … (code | metadata | review notes | product decision needed)
Reply to reviewer: …
Also check: …
```
For a Business Owner: what happened in plain words, whether it affects the business model (e.g. payments), and the time to resubmit.
