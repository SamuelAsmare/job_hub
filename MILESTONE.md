# JobHub — Milestone 1 Report

## 1. Project Status

JobHub is a Flutter job-search and recruitment app organized by feature. Milestone 1 delivered the navigable UI and sample-backed workflows.

At inspection time, GitHub `main` pointed to `996f2d178815edcef04ee91a09a60bd63778a59d`. The local working tree also contained uncommitted changes. Feature descriptions and validation results below refer to the current working tree unless explicitly identified as GitHub PR history.

The current implementation uses in-memory repositories. Backend services, Firebase integration, and durable storage are not integrated.

### Completed and Verified in the Current Repository

- `lib/core/` contains app constants, Riverpod providers, GoRouter configuration, themes, and shared widgets.
- `lib/features/` contains nine feature modules: `authentication`, `jobs`, `applications`, `saved_jobs`, `profile`, `employer`, `messaging`, `notifications`, and `settings`.
- Feature code is arranged into domain, data, and presentation layers where applicable.
- Public entry flow: `/welcome` → `/auth`, with role-aware routing.
- Job seeker capabilities: job home/search/details, nearby map, saved jobs, applications, profile/CV screens, and application submission UI.
- Employer capabilities: dashboard, vacancy posting/editing, vacancy details, and applicant management.
- Shared capabilities: messaging screens, notifications, and settings/theme selection.
- Data and state management: Riverpod providers, Freezed models, repository interfaces, and local in-memory data-source implementations.
- Guest users can browse job search and details. Applying or initiating an employer conversation requires authentication; the app retains the requested destination through authentication.
- Tests and static analysis were run against the current working tree on **2026-11-27**:
  - `flutter test`: **132 tests passed**.
  - `flutter analyze --fatal-infos`: **No issues found**.

These are local validation results, not a CI run. They describe the current working tree, which included uncommitted changes. They should not be attributed to the latest GitHub commit unless those changes are committed and re-tested.

### Not Implemented / Remaining

- Durable local storage and REST API integration for jobs, applications, and vacancies.
- Firebase Authentication and cloud persistence.
- AI job-description summaries through the backend and xAI Grok API.
- Production real-time messaging and notifications.
- The current conversation and message repository is in-memory and does not provide cross-device delivery or persistence after app restart.
- Profile and CV persistence are not backed by a remote service.
- Location-based screens exist, but real job data and location-backed search have not been verified against a service.
- Multi-factor security controls and production access control are not implemented or independently verified.

---

## 2. Implemented Features and User Stories

The following table summarizes the implementation evidence and remaining work for the project's user stories.

| User Story                                           | Priority | Milestone 1 Evidence                                                                              | Remaining Requirement                                                                                                                    |
| ---------------------------------------------------- | -------- | ------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| US1 — Register/login and manage a role-based profile | Must     | Welcome, local sign-in/registration, role selection, profile and CV screens exist.                | Firebase identity and durable profile/CV storage.                                                                                        |
| US2 — Search, filter, and find nearby jobs           | Must     | Job home, search/details and nearby-map screens; local sample job data.                           | Real listings and verified production GPS/location search.                                                                               |
| US3 — AI job-description summary                     | Should   | Job details screen exists.                                                                        | Backend-mediated xAI Grok summary is not implemented.                                                                                    |
| US4 — Submit CV and apply                            | Must     | Application form/workflow and CV selection are present, backed by local data.                     | Persistent CV storage and real application API.                                                                                          |
| US5 — Manage vacancies                               | Must     | Employer dashboard and local vacancy create/edit/delete workflows are represented in PR #14.      | REST API and persistent vacancy storage.                                                                                                 |
| US6 — Review applicants and update status            | Must     | Applicants screen lists applications, displays their current status, and opens applicant details. | A status-changing control is not present in the inspected screen; status updates and real applicant/application data remain outstanding. |
| US7 — Save jobs and track application updates        | Should   | Saved-jobs and notifications screens/providers use local data.                                    | Durable saved jobs and production-triggered application/push notifications.                                                              |
| US8 — Real-time communication                        | Could    | Local chat screen and in-memory conversation/message workflows exist.                             | Authenticated real-time server delivery and persistent conversation storage.                                                             |

Implemented screens do not, by themselves, satisfy the user stories' real-service and persistence requirements.

---

## 3. Implemented Feature and Route Inventory

| Area           | Implemented Screens / Routes                                                                                                                                                                                           | Current Scope and Limitation                                                                                                 |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| Authentication | Welcome `/welcome`; sign-in/registration `/auth`                                                                                                                                                                       | Local sample authentication; Firebase is not wired.                                                                          |
| Job Seeker     | Home `/seeker`; search `/jobs/search`; nearby map `/jobs/nearby-map`; details `/jobs/:jobId`; apply `/jobs/:jobId/apply`; applications `/applications`; saved jobs `/saved-jobs`; profile `/profile`; CV `/profile/cv` | Job data and workflows are local/sample-backed; verify GPS behavior on a device before claiming it works on target hardware. |
| Employer       | Dashboard `/employer`; post/edit `/employer/post-vacancy`; vacancy details `/employer/vacancies/:vacancyId`; applicants `/employer/vacancies/:vacancyId/applicants`                                                    | Local sample-backed workflows; no REST API integration.                                                                      |
| Messaging      | List `/messages`; chat `/messages/:conversationId`; job contact `/jobs/:jobId/message`                                                                                                                                 | Can create/reuse a local conversation and send messages in memory; no live messaging server.                                 |
| Notifications  | `/notifications`                                                                                                                                                                                                       | Local notification data/state; no remote push service.                                                                       |
| Settings       | `/settings`                                                                                                                                                                                                            | Theme/settings UI; persistence is not integrated.                                                                            |

Routes and source files were inspected in the current working tree. This inventory confirms registered screens, not end-to-end availability of every external service or device feature.

---

## 4. Team Contributions and GitHub Record

The following PR author and merge records were retrieved from the GitHub repository `SamuelAsmare/job_hub` on **2026-11-27**.

PR authorship and commit authorship are verifiable records; they do not prove the amount of work performed outside the repository. Reviewers are listed according to the team's review record.

### Team Members

| Contributor     | GitHub Account    |
| --------------- | ----------------- |
| Melkamu Tsegaye | `@Melk77`         |
| Samuel Asmare   | `@SamuelAsmare`   |
| Natnael Tigistu | `@NatnaelTigistu` |
| Yadelew Zemene  | `@Yadelew-zemene` |

### Implementation Contributions

| Contributor                         | Verifiable Work                                                                                                                                                                                                                                                                                                                                                           |
| ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Melkamu Tsegaye (`@Melk77`)         | Authored [PR #4](https://github.com/SamuelAsmare/job_hub/pull/4) (feature-first restructuring), [PR #9](https://github.com/SamuelAsmare/job_hub/pull/9) (messaging UI/local chat), and [PR #10](https://github.com/SamuelAsmare/job_hub/pull/10) (application workflow). Git commit history also attributes job-discovery/search work and integration commits to Melkamu. |
| Samuel Asmare (`@SamuelAsmare`)     | Authored [PR #8](https://github.com/SamuelAsmare/job_hub/pull/8) (core app entry, Riverpod, and routing).                                                                                                                                                                                                                                                                 |
| Natnael Tigistu (`@NatnaelTigistu`) | Authored [PR #5](https://github.com/SamuelAsmare/job_hub/pull/5) (settings), [PR #6](https://github.com/SamuelAsmare/job_hub/pull/6) (saved jobs), [PR #7](https://github.com/SamuelAsmare/job_hub/pull/7) (notifications), and [PR #15](https://github.com/SamuelAsmare/job_hub/pull/15) (Milestone 1 finalization, navigation, analyzer, tests, and documentation).     |
| Yadelew Zemene (`@Yadelew-zemene`)  | Authored [PR #11](https://github.com/SamuelAsmare/job_hub/pull/11) (shared user model/auth contract), [PR #12](https://github.com/SamuelAsmare/job_hub/pull/12) (authentication), [PR #13](https://github.com/SamuelAsmare/job_hub/pull/13) (job-seeker profile/CV), and [PR #14](https://github.com/SamuelAsmare/job_hub/pull/14) (employer vacancy management).         |

### Merged PR Inventory and Review Record

|                                                     PR | Title                                                                | Author            | Merged By         | Reviewed By       |
| -----------------------------------------------------: | -------------------------------------------------------------------- | ----------------- | ----------------- | ----------------- |
|   [#4](https://github.com/SamuelAsmare/job_hub/pull/4) | Refactor: organize project into feature-first architecture           | `@Melk77`         | `@Melk77`         | `@Melk77`         |
|   [#5](https://github.com/SamuelAsmare/job_hub/pull/5) | Feature/settings                                                     | `@NatnaelTigistu` | `@SamuelAsmare`   | `@NatnaelTigistu` |
|   [#6](https://github.com/SamuelAsmare/job_hub/pull/6) | Feature/saved jobs                                                   | `@NatnaelTigistu` | `@SamuelAsmare`   | `@NatnaelTigistu` |
|   [#7](https://github.com/SamuelAsmare/job_hub/pull/7) | Feature/notifications                                                | `@NatnaelTigistu` | `@SamuelAsmare`   | `@NatnaelTigistu` |
|   [#8](https://github.com/SamuelAsmare/job_hub/pull/8) | Configure app entry point, shared core layer, Riverpod, and GoRouter | `@SamuelAsmare`   | `@SamuelAsmare`   | `@SamuelAsmare`   |
|   [#9](https://github.com/SamuelAsmare/job_hub/pull/9) | Implement messaging UI and local chat                                | `@Melk77`         | `@Melk77`         | `@Melk77`         |
| [#10](https://github.com/SamuelAsmare/job_hub/pull/10) | Implement job application workflow                                   | `@Melk77`         | `@Melk77`         | `@Melk77`         |
| [#11](https://github.com/SamuelAsmare/job_hub/pull/11) | Define shared user model and repository contract                     | `@Yadelew-zemene` | `@Yadelew-zemene` | `@Yadelew-zemene` |
| [#12](https://github.com/SamuelAsmare/job_hub/pull/12) | Implement authentication feature                                     | `@Yadelew-zemene` | `@SamuelAsmare`   | `@Yadelew-zemene` |
| [#13](https://github.com/SamuelAsmare/job_hub/pull/13) | Implement job seeker profile and CV screens                          | `@Yadelew-zemene` | `@Yadelew-zemene` | `@Melk77`         |
| [#14](https://github.com/SamuelAsmare/job_hub/pull/14) | Implement employer vacancy management                                | `@Yadelew-zemene` | `@Yadelew-zemene` | `@Yadelew-zemene` |
| [#15](https://github.com/SamuelAsmare/job_hub/pull/15) | Finalizing milestone one                                             | `@NatnaelTigistu` | `@Melk77`         | `@Melk77`         |
| [#16](https://github.com/SamuelAsmare/job_hub/pull/16) | Milestone 1 additional implementation                                | `@Melk77`         | `@Melk77`         | `@NatnaelTigistu` |

The GitHub branch listing showed `main` and the feature branches `feat/flutter-ui-navigation`, `feat-core`, `feat-folder-structure`, `feature/authentication`, `feature/employer`, `feature/job-seeker-profile`, `feature/shared-user-model`, and `finalizing-milestone-one`, among others.

The commit history progresses from architecture and feature implementation through profile/employer work and Milestone 1 finalization. PR titles, authors, changed files, commit lists, merge actors, and available review records provide the contribution evidence.

### Contribution and Review Notes

- GitHub PR author, merge actor, and selected commit authors can be verified; task division, uncommitted work, and each member's exact individual share cannot be determined from those records alone.
- The proposal's planned team roles are not proof that backend or Firebase integrations were completed.
- Review information in the table reflects the team's recorded review contributions.

---

## 5. Marking Rubric and Evidence

The following 10-point rubric is used as a project self-assessment framework. It has not been independently confirmed as the instructor's official rubric or an awarded score.

| Criterion                                       | Maximum | Evidence and Status                                                                                                                   |
| ----------------------------------------------- | ------: | ------------------------------------------------------------------------------------------------------------------------------------- |
| Required screens present and navigable          |       3 | Proposal screens and routes are implemented. External-backed behavior is incomplete; confirm the instructor's exact screen checklist. |
| Feature-first architecture and state management |       2 | `lib/core/`, `lib/features/`, Riverpod providers, models, and repository abstractions are present.                                    |
| Tests and static analysis                       |       1 | Local `flutter test` passed 132 tests and `flutter analyze --fatal-infos` found no issues on 2026-11-27.                              |
| Repository hygiene / collaboration              |       1 | GitHub shows merged PRs and feature branches.                                                                                         |
| Individual oral check                           |       3 | Not verifiable from repository or GitHub data; instructor/team assessment required.                                                   |

**No official or final score is claimed.** The oral evaluation is still pending.

---

## 6. Validation Record

Executed locally on **2026-11-27** from the current working tree:

```text
flutter test
00:... +132: All tests passed!

flutter analyze --fatal-infos
No issues found!
```

These are local command results, not GitHub Actions/CI results. The checkout had uncommitted modifications during inspection. Re-run both commands on the final submitted commit and update this section if the output differs.

---

## 7. Recommended Next Milestone Work

1. Select and document the backend/API contract and data ownership.
2. Integrate Firebase Authentication and real role/user identities.
3. Replace in-memory job, application, vacancy, profile, saved-job, notification, and messaging sources with appropriate persistent/API-backed implementations.
4. Configure and test the messaging server before describing chat as real-time; add authenticated delivery, conversation persistence, reconnect/error handling, and authorization.
5. Complete and verify location permissions and nearby-job behavior on supported devices.
6. Implement AI summaries through the backend, keeping secrets out of the Flutter client.
7. Re-run tests, static analysis, and security checks on the final submitted commit; record the exact outputs and CI links if available.

---

## 8. Sources and Verification Notes

- Current `lib/`, `test/`, and `pubspec.yaml`: implementation structure, declared dependencies, and test files.
- GitHub PR, branch, review, and commit metadata for `SamuelAsmare/job_hub`, inspected 2026-11-27.
- Local Flutter test and analyzer commands, executed 2026-11-27.
- Team-provided update for PR #16 authorship and review.

Where GitHub review events, instructor requirements, CI results, device behavior, or external service configuration were not available, this report labels them **not verified** rather than inferring them.
