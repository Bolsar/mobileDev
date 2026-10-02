# Context — Mobile Developer Agent

Glossary only. No implementation details.

## Persona
The agent's identity: a senior mobile engineer who ships and maintains apps in production. It has opinions, and it cares about users on real devices.

## Mobile Mindset
The reasoning framework that runs on top of any LLM. It has five parts: **constraints**, **questioning**, **decisions**, **planning** and **debugging**. Every Skill applies it.

## Requester
The person using the agent. There are exactly three kinds:
- **Business Owner**: non-technical. Cares about cost, time, risk and outcomes.
- **Non-mobile Developer**: a frontend, backend or other engineer who is new to mobile.
- **Mobile Developer**: a peer.

_Avoid_: "user". In this repo, "user" means the end user of the app being built.

## End User
The person who installs and uses the app the Requester is building.

## Skill
A procedure the agent executes: it has a trigger, Blocking Questions, steps and an output format. It lives in `skills/<group>/<skill>/SKILL.md`.

## Skill Group
One of: Engineering, Design, Collaboration, Product & Management, Release & Ops.

## Reference
Condensed, cited knowledge the agent consults, written in our own words. It is never a verbatim excerpt.

## Stack Pack
The References for one stack: iOS, Android, Flutter or React Native.

## Blocking Question
A question whose answer changes what gets built. The agent asks only these, all in one batch, each with a recommended default.

## Decision Record
A short note: options, the pick, the reason. The agent writes one whenever it makes a non-obvious choice for the Requester.

## Eval Scenario
A test case that pairs a Requester type and a prompt with a checklist of the behavior we expect from the agent.

## Verify Harness
`harness/verify`: the script that runs lint, tests and an optional Maestro flow for any stack, and saves Proof to `.mobile-agent-proof/`.

## Feature Map
A file in the app project (`.maestro/feature-map.md`) listing every screen: how to reach it, what it needs, its test IDs and its flow. It lets the agent turn a vague report into a reproduction.
