# Mobile Constraints

These are what make mobile different from web and backend. Check every design against this list before building.

## 1. Network is unreliable
- Assume the network is slow, flaky or gone: elevators, subways, captive portals, 2G fallback.
- Every request needs a timeout, a retry policy (idempotent calls only, with exponential backoff and jitter) and a UI state for when it fails.
- Decide per feature: **online-only**, **read offline** (cache), or **write offline** (queue + sync). Writing offline is the expensive option; make sure the feature really needs it.
- Large payloads cost End Users money on metered data. Paginate, compress, and send only what the screen needs.

## 2. Lifecycle and process death
- The OS can kill the app in the background at any time. The End User returns expecting the same screen, the same scroll position and the same half-typed form.
- Persist UI state that matters (drafts, the current step of a flow). Never hold critical state only in memory.
- Background work is limited and scheduled by the OS (iOS BGTaskScheduler, Android WorkManager). Don't promise "runs every 5 minutes".
- Rotation, split screen, foldables and dark-mode changes can recreate the screen.

## 3. Old versions live forever
- A release can't be recalled. Some End Users never update.
- A backend API must stay backward-compatible with every version still supported. Add fields; never rename or remove them without a sunset plan.
- Plan **force update** and **soft update** from v1 (see skill `versioning-force-update`).
- Ship risky features behind remote flags so you can turn them off without a release.

## 4. Store review and slow rollout
- iOS review takes hours to days. Android review can also take days. A hotfix is not instant.
- Use staged rollout: Android percentage rollout, iOS phased release.
- Store rules change. Before advising on a policy (payments, privacy, permissions), say to check the current guidelines.

## 5. Device and OS fragmentation
- Screen sizes run from small phones to tablets and foldables. Consider notches, the Dynamic Island, and cutouts.
- The OS version range comes from the min OS. Each API needs an availability check or a fallback.
- Android OEMs (Samsung, Xiaomi and others) kill background work aggressively and customize the system UI.
- Low-end devices have little RAM and slow CPUs. Test on one.

## 6. Battery, memory, performance
- Budgets: cold start under 2s, 60/120fps scrolling, no work on the main thread over about 16ms.
- Images use the most memory. Size them to the view, cache them, and downsample.
- GPS, Bluetooth, wake locks and polling drain the battery. Batch work and prefer push over polling.

## 7. Permissions and privacy
- Ask in context, after explaining why (a pre-prompt). A denial is often permanent. Design the denied path.
- Privacy manifests, data-safety forms and tracking consent (ATT) are store requirements, not optional.
- Secrets in the binary are public. Tokens go in Keychain/Keystore, never in plain storage.

## 8. Input and ergonomics
- Touch, not a mouse. Targets at least 44pt/48dp, keep thumb reach in mind, no hover.
- The keyboard covers half the screen. Forms must scroll and use the right keyboard type.
- Large-text settings and screen readers are common. The layout must survive them.
