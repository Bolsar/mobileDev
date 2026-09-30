# Release

- **Versioning**: a user-facing marketing version (for example 2.4.0) plus a monotonically increasing build number. [S27]
- **Branching**: trunk-based with release branches or tags. Automate builds: CI builds, tests, signs and uploads. [S15]
- **Staged rollout**: iOS phased release over 7 days; Android percentage rollout (1%, then 5, 20, 50, 100). Watch the crash-free rate before each step.
- **Kill switches**: remote feature flags for risky features. [S30]
- **Update policy**: remote config holds the minimum supported version and a soft-update prompt. The force-update screen blocks the app with a link to the store.
- **Store metadata**: screenshots, description, privacy labels and data safety are updated whenever features change.
- **Review guidelines**: always check the current App Store Review Guidelines and Play Policy for payments, login, user-generated content and permissions. [S9][S10]
- **Release checklist**: version bumped · changelog · crash-free rate of the previous release OK · migrations tested from old versions · analytics verified · flags configured · rollback = flag off.
