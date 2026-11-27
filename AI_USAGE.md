# AI Usage — JobHub (Milestone 1)

## 1. AI Tools Used
- **ChatGPT / Claude / Gemini (AI Coding Assistants):** Used for understanding Flutter, Riverpod, `freezed`, and `go_router` patterns, diagnosing analyzer/test errors, and reviewing code structure.
- **GitHub Copilot:** Used for code completion, boilerplate generation (e.g., `freezed` models and test scaffolding), and repetitive UI layout code.

## 2. How AI Was Used
- **Architecture & Navigation:** Assisted with designing the `go_router` configuration, role-based route guards, and `AppSessionNotifier` integration.
- **Testing & Debugging:** Helped identify missing edge-case tests, fix `flutter analyze --fatal-infos` lint warnings, and update widget tests after route/settings changes.
- **Documentation:** Assisted in organizing `MILESTONE.md` and summarizing repository status.

## 3. Verification and Member Responsibility
- All AI-suggested code was reviewed, understood, adapted to the repository's feature-first architecture (`domain`/`data`/`presentation`), and verified by running `flutter analyze --fatal-infos` and `flutter test` (119 passing tests).
- No secrets, credentials, or private user data were shared with AI tools.
- Each group member remains responsible for explaining and maintaining the code they authored and reviewed during the individual oral check.
