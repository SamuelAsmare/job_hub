import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_constants.dart';

/// Supported user roles in JobHub.
enum UserRole {
  guest,
  jobSeeker,
  employer,
}

/// Immutable application-level authentication and role session state.
class AppSessionState {
  final String? userId;
  final UserRole role;
  final bool isAuthenticated;

  const AppSessionState({
    this.userId,
    this.role = UserRole.guest,
    this.isAuthenticated = false,
  });

  /// Default Milestone 1 sample session for quick local integration testing.
  const AppSessionState.sampleJobSeeker()
      : userId = AppConstants.defaultSampleUserId,
        role = UserRole.jobSeeker,
        isAuthenticated = true;

  AppSessionState copyWith({
    String? userId,
    UserRole? role,
    bool? isAuthenticated,
  }) {
    return AppSessionState(
      userId: userId ?? this.userId,
      role: role ?? this.role,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppSessionState &&
        other.userId == userId &&
        other.role == role &&
        other.isAuthenticated == isAuthenticated;
  }

  @override
  int get hashCode => Object.hash(userId, role, isAuthenticated);
}

/// Manages global authentication and active role state across the app.
///
/// In Milestone 1 this uses sample session state; in Milestone 2 the auth
/// repository / Firebase listener can update this notifier directly.
class AppSessionNotifier extends Notifier<AppSessionState> {
  @override
  AppSessionState build() => const AppSessionState.sampleJobSeeker();

  /// Signs in a user with the given [userId] and [role].
  void signIn({
    required String userId,
    required UserRole role,
  }) {
    state = AppSessionState(
      userId: userId,
      role: role,
      isAuthenticated: role != UserRole.guest,
    );
  }

  /// Convenience helper for testing role-based navigation during development.
  void switchRole(UserRole role) {
    if (role == UserRole.guest) {
      signOut();
      return;
    }
    state = AppSessionState(
      userId: state.userId ?? AppConstants.defaultSampleUserId,
      role: role,
      isAuthenticated: true,
    );
  }

  /// Clears the active session and resets to [UserRole.guest].
  void signOut() {
    state = const AppSessionState();
  }
}

/// Global session state provider.
final appSessionProvider =
    NotifierProvider<AppSessionNotifier, AppSessionState>(
  AppSessionNotifier.new,
);

/// Canonical active user ID provider shared across features.
///
/// Falls back to [AppConstants.defaultSampleUserId] when unauthenticated if a
/// feature queries sample data, or `null` can be checked via [appSessionProvider].
final currentUserIdProvider = Provider<String?>((ref) {
  return ref.watch(appSessionProvider.select((session) => session.userId));
});

/// Canonical active [UserRole] provider for role-aware UI and route guards.
final currentUserRoleProvider = Provider<UserRole>((ref) {
  return ref.watch(appSessionProvider.select((session) => session.role));
});

/// Controls the global [ThemeMode] for [MaterialApp.router].
class AppThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.light;

  void setThemeMode(ThemeMode mode) {
    state = mode;
  }

  /// Maps persisted string values (`'light'`, `'dark'`, `'system'`) to [ThemeMode].
  void setThemeModeFromString(String value) {
    state = switch (value.toLowerCase()) {
      'dark' => ThemeMode.dark,
      'system' => ThemeMode.system,
      _ => ThemeMode.light,
    };
  }
}

/// Global theme mode provider consumed by [JobHubApp].
final appThemeModeProvider =
    NotifierProvider<AppThemeModeNotifier, ThemeMode>(
  AppThemeModeNotifier.new,
);
