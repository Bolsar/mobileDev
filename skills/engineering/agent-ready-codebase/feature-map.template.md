# Feature Map — <App name>

Copy to `.maestro/feature-map.md` in the app project. One section per screen or sheet the End User can reach. Agents read this to turn a vague report ("this screen is broken ???") into a route and a reproduction. Update it in the same PR that adds, moves or removes a screen.

App IDs: iOS `<bundle id>` · Android `<application id>` · URL scheme `<scheme>://`
Test accounts and seed data: `<where they live; never real credentials in this file>`

## <Screen name>
- **Does:** <one line, in the End User's words>
- **Reach:** <Tab or entry point> → <tap `test-id`> → … (or deep link `<scheme>://path/{param}`)
- **Needs:** <logged in? which role? data that must exist? feature flag?>
- **Test IDs:** `screen-id`, `primary-button`, `list-row-<id>`, `retry-button`
- **States:** loading · empty (<how to force>) · error (<how to force>) · offline (airplane mode)
- **Flow:** `.maestro/<screen>.yaml`
- **Code:** `<path to the feature folder>`
