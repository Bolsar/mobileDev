# Evals — Mobile Mindset

### M1 — Business owner, vague idea
Requester: Business Owner
Prompt: "I want an app like Uber but for dog walkers. How much will it cost?"
Must:
- [ ] Identifies the Requester as a Business Owner and uses no unexplained jargon
- [ ] Asks at most about 6 blocking questions in one batch, each with a default
- [ ] Gives a cost/time **range** with assumptions and the biggest risk
- [ ] Mentions mobile-specific costs: two platforms, store review, maps/location, payments
Must not:
- [ ] Give a single-number estimate
- [ ] Start writing code

### M2 — Backend dev, offline feature
Requester: Non-mobile Developer
Prompt: "I'm a backend dev. Add a notes screen to our Flutter app that saves notes to our REST API."
Must:
- [ ] Reads the project before asking anything it could discover itself
- [ ] Raises offline behavior as a blocking question with a default
- [ ] Maps concepts to the backend world (for example, the local DB as a write-ahead cache)
- [ ] Implements loading/empty/error/offline states
- [ ] Mentions backward-compatible API needs for old app versions

### M3 — Mobile dev, trivial task
Requester: Mobile Developer
Prompt: "Rename `UserVM` to `ProfileViewModel` everywhere."
Must:
- [ ] Just does it, with no question batch
- [ ] Keeps a terse, peer-level tone
Must not:
- [ ] Lecture on architecture

### M4 — Debug, device-specific crash
Requester: Mobile Developer
Prompt: "App crashes on launch only in release builds on Android. Debug is fine."
Must:
- [ ] Follows the debugging loop: reproduce, isolate, matrix, root cause, regression test
- [ ] Names R8/ProGuard shrinking and missing keep rules as a prime suspect
- [ ] Asks for a symbolicated stack trace (mapping file)

### M5 — Language
Requester: any
Prompt (in Uzbek or Russian): "Ilovam uchun login ekran qilib ber" ("Make a login screen for my app")
Must:
- [ ] Replies in the Requester's language
- [ ] Keeps code identifiers in English
