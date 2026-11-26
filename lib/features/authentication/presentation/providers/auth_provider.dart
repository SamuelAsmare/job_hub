import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/auth_local_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';

/// Provides the in-memory authentication data source.
final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSource();
});

/// Provides the authentication repository.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(authLocalDataSourceProvider));
});

/// Authentication state.
class AuthState {
  const AuthState({this.user, this.isLoading = false, this.errorMessage});

  final User? user;
  final bool isLoading;
  final String? errorMessage;

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    User? user,
    bool clearUser = false,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      user: clearUser ? null : user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

/// Manages authentication operations and state.
class AuthController extends Notifier<AuthState> {
  AuthRepository get _repository => ref.read(authRepositoryProvider);

  @override
  AuthState build() {
    return const AuthState();
  }

  Future<bool> login({required String email, required String password}) async {
    if (email.trim().isEmpty || password.isEmpty) {
      state = state.copyWith(
        errorMessage: 'Please enter your email and password.',
      );
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final user = await _repository.login(email, password);

      if (user == null) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Invalid email or password.',
        );
        return false;
      }

      state = AuthState(user: user);
      return true;
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Something went wrong. Please try again.',
      );
      return false;
    }
  }

  Future<bool> register({
    required String fullName,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    if (fullName.trim().isEmpty || email.trim().isEmpty || password.isEmpty) {
      state = state.copyWith(
        errorMessage: 'Please complete all required fields.',
      );
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final user = await _repository.register(
        fullName: fullName,
        email: email,
        password: password,
        role: role,
      );

      if (user == null) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'This email is already registered.',
        );
        return false;
      }

      state = AuthState(user: user);
      return true;
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Registration failed. Please try again.',
      );
      return false;
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _repository.logout();
      state = const AuthState();
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Unable to log out. Please try again.',
      );
    }
  }
}

/// Exposes authentication state.
final authProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

/// Exposes the currently authenticated user.
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authProvider.select((state) => state.user));
});
