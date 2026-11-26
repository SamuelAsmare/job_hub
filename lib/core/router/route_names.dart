/// Centralized route paths, route names, and path builders for JobHub.
class RouteNames {
  RouteNames._();

  // Root / Integration Hub
  static const String home = '/';
  static const String homeName = 'home';

  // Authentication (pending)
  static const String welcome = '/welcome';
  static const String welcomeName = 'welcome';
  static const String auth = '/auth';
  static const String authName = 'auth';

  // Job Seeker
  static const String jobSeekerHome = '/seeker';
  static const String jobSeekerHomeName = 'job-seeker-home';

  static const String jobSearch = '/jobs/search';
  static const String jobSearchName = 'job-search';

  static const String nearbyJobsMap = '/jobs/nearby-map';
  static const String nearbyJobsMapName = 'nearby-jobs-map';

  static const String jobDetails = '/jobs/:jobId';
  static const String jobDetailsName = 'job-details';

  static const String applyJob = '/jobs/:jobId/apply';
  static const String applyJobName = 'apply-job';

  static const String myApplications = '/applications';
  static const String myApplicationsName = 'my-applications';

  static const String savedJobs = '/saved-jobs';
  static const String savedJobsName = 'saved-jobs';

  // Profile (pending)
  static const String jobSeekerProfile = '/profile';
  static const String jobSeekerProfileName = 'job-seeker-profile';

  static const String myCv = '/profile/cv';
  static const String myCvName = 'my-cv';

  // Employer (pending)
  static const String employerDashboard = '/employer';
  static const String employerDashboardName = 'employer-dashboard';

  static const String postVacancy = '/employer/post-vacancy';
  static const String postVacancyName = 'post-vacancy';

  static const String vacancyDetails = '/employer/vacancies/:vacancyId';
  static const String vacancyDetailsName = 'vacancy-details';

  static const String applicants = '/employer/vacancies/:vacancyId/applicants';
  static const String applicantsName = 'applicants';

  // Shared
  static const String messages = '/messages';
  static const String messagesName = 'messages';

  static const String notifications = '/notifications';
  static const String notificationsName = 'notifications';

  static const String settings = '/settings';
  static const String settingsName = 'settings';

  // Path builders
  static String jobDetailsPath(String jobId) => '/jobs/$jobId';

  static String applyJobPath(String jobId) => '/jobs/$jobId/apply';

  static String vacancyDetailsPath(String vacancyId) =>
      '/employer/vacancies/$vacancyId';

  static String applicantsPath(String vacancyId) =>
      '/employer/vacancies/$vacancyId/applicants';
}
