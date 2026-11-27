# JobHub — Milestone 1 Report

## 1. Project Status

JobHub is a Flutter job-search and recruitment application organized using feature-first architecture. Milestone 1 delivers the navigable user interface and sample-backed workflows.

Milestone 1 was finalized on the `main` branch after PR #16, authored by `@Melk77`, was merged. The final verified commit was `5247ce0`.

### Completed and Verified

- `lib/core/` contains application constants, Riverpod providers, GoRouter configuration, themes, and shared widgets.
- `lib/features/` contains nine feature modules: authentication, jobs, applications, saved_jobs, profile, employer, messaging, notifications, and settings.
- Feature code is organized into domain, data, and presentation layers where applicable.
- Welcome, authentication, and role-aware navigation flows are implemented.
- Job seekers can browse, search, view nearby jobs, save jobs, manage applications, and access profile/CV screens.
- Employers can access dashboards, post and manage vacancies, and view applicants.
- Messaging, notifications, and settings screens are implemented.
- Riverpod, Freezed models, repository interfaces, and in-memory data sources are used.
- Guest users can browse jobs. Applying and initiating employer conversations require authentication.
- Final local verification completed successfully:
  - `flutter test`: 132 tests passed.
  - `flutter analyze --fatal-infos`: No issues found.

### Not Implemented / Remaining

- REST API integration and durable data storage.
- Firebase Authentication and cloud persistence.
- Backend-mediated AI job-description summaries.
- Production real-time messaging and notifications.
- Remote profile and CV persistence.
- Production location-backed job search.
- Multi-factor authentication and production access controls.

## 2. Implemented Features and User Stories

| User Story                                           | Priority | Milestone 1 Evidence                                             | Remaining Requirement                                    |
| ---------------------------------------------------- | -------- | ---------------------------------------------------------------- | -------------------------------------------------------- |
| US1 — Register/login and manage a role-based profile | Must     | Welcome, authentication, role selection, profile and CV screens. | Firebase authentication and persistent profile storage.  |
| US2 — Search, filter, and find nearby jobs           | Must     | Job home, search, details, nearby map, and sample job data.      | Real job listings and production location search.        |
| US3 — AI job-description summary                     | Should   | Job details screen exists.                                       | Backend-mediated AI summary integration.                 |
| US4 — Submit CV and apply                            | Must     | Application form, CV selection, and local application workflow.  | Persistent CV storage and application API.               |
| US5 — Manage vacancies                               | Must     | Employer dashboard and local vacancy workflows.                  | REST API and persistent vacancy storage.                 |
| US6 — Review applicants and update status            | Must     | Applicants screen displays applications and applicant details.   | Status-changing controls and real application data.      |
| US7 — Save jobs and track application updates        | Should   | Saved-jobs and notifications screens use local data.             | Persistent saved jobs and production notifications.      |
| US8 — Real-time communication                        | Could    | Local chat and in-memory conversation workflows.                 | Authenticated real-time delivery and persistent storage. |

Implemented screens do not by themselves establish that external services or production integrations are complete.

## 3. Implemented Feature and Route Inventory

| Area           | Implemented Screens / Routes                                                                                                                   | Current Scope                                |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------- |
| Authentication | `/welcome`, `/auth`                                                                                                                            | Local sample authentication.                 |
| Job Seeker     | `/seeker`, `/jobs/search`, `/jobs/nearby-map`, `/jobs/:jobId`, `/jobs/:jobId/apply`, `/applications`, `/saved-jobs`, `/profile`, `/profile/cv` | Sample-backed job and application workflows. |
| Employer       | `/employer`, `/employer/post-vacancy`, `/employer/vacancies/:vacancyId`, `/employer/vacancies/:vacancyId/applicants`                           | Local vacancy and applicant workflows.       |
| Messaging      | `/messages`, `/messages/:conversationId`, `/jobs/:jobId/message`                                                                               | In-memory messaging.                         |
| Notifications  | `/notifications`                                                                                                                               | Local notification data and state.           |
| Settings       | `/settings`                                                                                                                                    | Theme and settings UI.                       |

## 4. Team Contributions and GitHub Record

### Team Members

| Contributor     | GitHub Account    |
| --------------- | ----------------- |
| Melkamu Tsegaye | `@Melk77`         |
| Samuel Asmare   | `@SamuelAsmare`   |
| Natnael Tigistu | `@NatnaelTigistu` |
| Yadelew Zemene  | `@Yadelew-zemene` |

### Implementation Contributions

| Contributor                         | Contributions                                                                                                                                                                                                                             |
| ----------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Melkamu Tsegaye (`@Melk77`)         | PR #4 — feature-first restructuring; PR #9 — messaging UI and local chat; PR #10 — application workflow; PR #16 — UI improvements, including color updates and removal of unnecessary widgets; job discovery/search and integration work. |
| Samuel Asmare (`@SamuelAsmare`)     | PR #8 — core app entry, Riverpod, and routing.                                                                                                                                                                                            |
| Natnael Tigistu (`@NatnaelTigistu`) | PR #5 — settings; PR #6 — saved jobs; PR #7 — notifications; PR #15 — Milestone 1 finalization.                                                                                                                                           |
| Yadelew Zemene (`@Yadelew-zemene`)  | PR #11 — shared user model; PR #12 — authentication; PR #13 — job-seeker profile/CV; PR #14 — employer vacancy management.                                                                                                                |

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

The table records the team's supplied PR authorship, merge, and review information.

## 5. Marking Rubric and Evidence

| Criterion                                       | Maximum | Evidence                                                                     |
| ----------------------------------------------- | ------: | ---------------------------------------------------------------------------- |
| Required screens present and navigable          |       3 | Proposal screens and application navigation are implemented.                 |
| Feature-first architecture and state management |       2 | Feature modules, Riverpod, Freezed, and repository abstractions are present. |
| Tests and static analysis                       |       1 | 132 passing tests and no analyzer issues.                                    |
| Repository hygiene / collaboration              |       1 | Feature branches, commits, and merged pull requests.                         |
| Individual oral assessment                      |       3 | Pending individual assessment.                                               |

**No official or final score is claimed.** The individual oral assessment remains subject to evaluation.

## 6. Validation Record

Final verification was performed locally on 2026-11-27 against commit `5247ce0`.

```text
flutter analyze --fatal-infos

Analyzing job_hub...
No issues found! (ran in 14.7s)
```

```text
flutter test

00:40 +132: All tests passed!
```

These are local validation results, not GitHub Actions/CI results.

## 7. Recommended Next Milestone Work

1. Define the backend/API contract.
2. Integrate Firebase Authentication and real user identities.
3. Replace in-memory repositories with persistent/API-backed implementations.
4. Implement production messaging and notification delivery.
5. Complete and verify location-backed job search.
6. Implement AI summaries through the backend.
7. Add integration tests and repeat security, analyzer, and test checks.

## 8. Sources and Verification Notes

- Project source code under `lib/`.
- Test files under `test/`.
- Dependencies declared in `pubspec.yaml`.
- GitHub pull requests and team-provided contribution/review records.
- Local Flutter test and analyzer command outputs from 2026-11-27.

Where production integrations or external services are incomplete, this report identifies them as remaining work rather than claiming they are implemented.
