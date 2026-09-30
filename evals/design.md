# Evals — Design

### D1 — ui-anti-slop: plain request, no designs
Requester: Non-mobile Developer
Prompt: "Build a settings screen for our SwiftUI app: notifications toggle, language, logout."
Must:
- [ ] Uses native `Form`/`List` with sections, system colors and text styles
- [ ] Logout is visually separated as destructive and asks for confirmation
- [ ] Strings externalized; labels on every control
Must not:
- [ ] Add gradients, cards per row, emoji icons or hardcoded hex colors

### D2 — ui-anti-slop: existing design system wins
Requester: Mobile Developer
Prompt: "Add a 'Refer a friend' banner to the home screen." (project has its own `AppTheme` and `CalloutView`)
Must:
- [ ] Finds and reuses `AppTheme` tokens and the existing `CalloutView`
- [ ] Handles the dismissed and no-referral-code states
Must not:
- [ ] Introduce new colors, fonts or a new banner component

### D3 — design-from-brief: no designer
Requester: Business Owner
Prompt: "I want an app where gym members book classes. We have no designer. Design it."
Must:
- [ ] Asks for the primary job and brand assets in one batch, with defaults
- [ ] Delivers jobs, navigation model, flows with unhappy paths, and a screen inventory with states
- [ ] Asks for confirmation of flows before writing UI code
- [ ] Separates what to decide now from later, in plain language
Must not:
- [ ] Jump straight to colored mockups or code

### D4 — design-system-setup: hardcoded values everywhere
Requester: Mobile Developer
Prompt: "Our Compose screens have hex colors and dp values everywhere. Dark mode is broken. Fix it."
Must:
- [ ] Inventories existing values and collapses near-duplicates
- [ ] Defines color roles with light and dark values wired into `MaterialTheme`
- [ ] Migrates in small commits with no visual redesign mixed in
- [ ] Proposes a lint/CI guard against raw colors in feature code
Must not:
- [ ] Name primitives by feature or look (`ProfileCard`, `BlueButton`)

### D5 — design-critique: screenshot review
Requester: Business Owner
Prompt: "Here's our checkout screen [screenshot]. Is it good?"
Must:
- [ ] Names the screen's primary action and whether it's obvious
- [ ] Ranks findings blocker/major/minor with a fix each
- [ ] Leads with the top 3 conversion-affecting findings in plain words
- [ ] Lists what it can't judge from a static image
Must not:
- [ ] Give taste-only opinions without an End User impact

### D6 — motion-and-feedback: "feels slow"
Requester: Mobile Developer
Prompt: "Liking a post feels laggy, it waits for the server. Add some animation."
Must:
- [ ] Proposes an optimistic update with rollback and a message on failure
- [ ] Respects Reduce Motion
- [ ] Uses a semantic haptic at most, not one on every tap
Must not:
- [ ] Add a spinner or a long animation that blocks further taps

### D7 — store-assets: first release
Requester: Business Owner
Prompt: "We launch next week. What do we need for the store pages?"
Must:
- [ ] Lists icon, screenshots, text and Play feature graphic per store
- [ ] Says to verify current size specs in the official docs, with links
- [ ] Plans screenshots as one benefit each, first 2–3 carrying the pitch
- [ ] Warns screenshots must show the real app to avoid rejection
Must not:
- [ ] State exact pixel sizes as definitive without the verify caveat
