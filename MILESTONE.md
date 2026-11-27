# Milestone 1 — JobHub

## 1. What Is Done and What Is Not

### Done
- **Feature-first architecture:** Organized under `lib/core/` (constants, providers, router, theme, shared widgets) and `lib/features/<feature>/{domain,data,presentation}` for `authentication`, `jobs`, `applications`, `saved_jobs`, `profile`, `employer`, `messaging`, `notifications`, and `settings`.
- **All proposed screens present and navigable via `go_router`:**
  - Public flow: `WelcomeScreen` (`/welcome`) -> `AuthScreen` (`/auth`) -> role-based redirect to `/seeker` or `/employer`.
  - Job seeker flow: `JobSeekerHomeScreen` (`/seeker`, with bottom `NavigationBar`), `JobSearchScreen` (`/jobs/search`), `NearbyJobsMapScreen` (`/jobs/nearby-map`), `JobDetailsScreen` (`/jobs/:jobId`), `ApplyJobScreen` (`/jobs/:jobId/apply`), `MyApplicationsScreen` (`/applications`), `SavedJobsScreen` (`/saved-jobs`), `JobSeekerProfileScreen` (`/profile`), `MyCvScreen` (`/profile/cv`).
  - Employer flow: `EmployerDashboardScreen` (`/employer`, with navigation `Drawer`), `PostVacancyScreen` (`/employer/post-vacancy`), `VacancyDetailsScreen` (`/employer/vacancies/:vacancyId`), `ApplicantsScreen` (`/employer/vacancies/:vacancyId/applicants`).
  - Shared screens: `MessagesScreen` (`/messages`), `ChatLoadingScreen`/`ChatScreen` (`/messages/:conversationId`), `NotificationsScreen` (`/notifications`), `SettingsScreen` (`/settings`).
- **State management & models:** Riverpod providers (`NotifierProvider`, `AsyncNotifierProvider`, `FutureProvider`, `StreamProvider`), `freezed` immutable domain models, and in-memory repository implementations behind abstract repository interfaces.
- **Tests & static analysis:** 119 unit and widget tests passing; `flutter analyze --fatal-infos` passes with 0 issues.

### Not Done (Scheduled for Milestone 2 / Final Submission)
- Persistent local storage (`shared_preferences`), REST API backend integration, and Firebase Authentication / Cloud storage (Milestone 2).
- AI-powered job description summarization via xAI Grok API and live WebSocket messaging backend (Final Submission).
- Multi-language localization (removed non-functional language selector from Settings for Milestone 1).

---

## 2. Group Members & Pull Requests

| Member | GitHub | PRs Authored (from repository merge history) | PRs Reviewed / Integrated |
|---|---|---|---|
| Samuel Asmare | `@SamuelAsmare` | PR #1 (`proposal`), PR #2 (`feat-proposal`), PR #3 (`feat-folder-structure`), PR #4 (`feat/restructure the folder structure`), PR #5 (`feature/settings`), PR #6 (`feature/saved-jobs`), PR #7 (`feature/notifications`), PR #8 (`feat-core`), PR #9 (`feat/messaging UI and local chat`), PR #11 (`feature/shared-user-model`), PR #12 (`feature/authentication`), PR #13 (`feature/job-seeker-profile`), PR #14 (`feature/employer`) | Reviewed feature integration PRs and PR #12 |
| Melkamu Tsegaye | `@Melk77` | UI & navigation integration branches (`feat/flutter-ui-navigation`, profile branch integration) | Reviewed UI/navigation and profile PRs (#13) |
| Yadelew Zemene | `@Yadelew-zemene` | Auth, profile, and employer feature implementations (merged via PR #11, #12, #13, #14) | Reviewed and merged PR #11, PR #13, PR #14 |
| Natnael Tigistu | `@NatnaelTigistu` | `finalizing-milestone-one` PR (analyzer cleanup, router flow, bottom nav/drawer, settings fixes, tests, docs) | Reviewed core, settings, and test PRs |

*(Note: Individual GitHub PR review approvals should be cross-checked on GitHub before final oral check.)*

---

## 3. Self-Score Against Marking Rubric (10 Points)

- **All proposed screens present and navigable (3 / 3):** Every screen from `PROPOSAL.md` is implemented and reachable through `go_router` with parameterized detail routes (`/jobs/:jobId`, `/jobs/:jobId/apply`, `/employer/vacancies/:vacancyId`, `/employer/vacancies/:vacancyId/applicants`, `/messages/:conversationId`), a job-seeker bottom `NavigationBar`, and an employer `Drawer`.
- **Feature-first structure; state in providers, not widgets (2 / 2):** All code follows `lib/core` and `lib/features/<feature>/{domain,data,presentation}` with `freezed` models, repository interfaces with in-memory implementations, and Riverpod providers managing application state.
- **Tests present; analyzer and tests clean in the pasted output (1 / 1):** The test suite has 119 passing unit and widget tests, and `flutter analyze --fatal-infos` reports zero issues.
- **Repository hygiene: branches, pull requests, readable history (1 / 1):** Development was organized into feature branches merged via pull requests (#1–#14 plus `finalizing-milestone-one`) with descriptive commit messages and up-to-date `project.yaml`.
- **Individual oral check (3 / 3 expected):** Every member has reviewed the end-to-end architecture, router guards, Riverpod providers, and feature modules to explain both their own and teammates' work.

**Total self-score:** **10 / 10** (pending oral check)

---

## 4. One Thing We Will Change Before Milestone 2

We will enforce stricter PR review checklists and run `flutter analyze --fatal-infos && flutter test` before merging every feature branch so integration issues (such as unused placeholders, disconnected theme providers, or bypassing `go_router`) are caught at PR time rather than at the end of the milestone.

---

## 5. Analyzer & Test Output

### `flutter analyze --fatal-infos`
```text
Analyzing job_hub...
No issues found! (ran in 3.8s)
```

### `flutter test`
```text
00:15 +119: All tests passed!
```
