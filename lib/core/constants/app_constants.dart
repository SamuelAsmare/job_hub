/// Application-wide static constants shared across all JobHub features.
///
/// Feature modules should import these values instead of duplicating magic
/// strings, layout dimensions, validation limits, or storage keys.
class AppConstants {
  AppConstants._();

  // Application identity
  static const String appName = 'JobHub';
  static const String appTagline = 'Discover Opportunities. Hire Faster.';

  // Default sample user ID for Milestone 1 in-memory data integration
  static const String defaultSampleUserId = 'user_001';

  // Standard layout & spacing metrics
  static const double pageHorizontalPadding = 20.0;
  static const double sectionSpacing = 20.0;
  static const double itemSpacing = 12.0;
  static const double cardBorderRadius = 16.0;
  static const double buttonBorderRadius = 12.0;
  static const double inputBorderRadius = 12.0;

  // Domain & form validation constraints
  static const int minPasswordLength = 6;
  static const int maxCoverLetterLength = 1500;
  static const int maxBioLength = 500;
  static const int maxCvFileSizeMb = 5;
  static const List<String> allowedCvExtensions = ['pdf', 'doc', 'docx'];

  // Network & pagination defaults (for Milestone 2 REST API integration)
  static const int defaultPageSize = 20;
  static const int networkTimeoutSeconds = 30;

  // Local persistence keys (SharedPreferences)
  static const String keyAuthToken = 'job_hub_auth_token';
  static const String keyUserId = 'job_hub_user_id';
  static const String keyUserRole = 'job_hub_user_role';
  static const String keyThemeMode = 'job_hub_theme_mode';
  static const String keyOnboardingCompleted = 'job_hub_onboarding_completed';
  static const String keyRecentSearches = 'job_hub_recent_searches';
}
