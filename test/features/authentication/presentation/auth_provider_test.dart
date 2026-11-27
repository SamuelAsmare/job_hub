import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/authentication/domain/models/user.dart';
import 'package:job_hub/features/authentication/presentation/providers/auth_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  group('AuthController', () {
    test('initial state is unauthenticated', () {
      final state = container.read(authProvider);

      expect(state.user, isNull);
      expect(state.isAuthenticated, isFalse);
      expect(state.isLoading, isFalse);
    });

    test('logs in with valid sample credentials', () async {
      final success = await container
          .read(authProvider.notifier)
          .login(email: 'abebe@example.com', password: 'password123');

      final state = container.read(authProvider);

      expect(success, isTrue);
      expect(state.isAuthenticated, isTrue);
      expect(state.user!.fullName, 'Abebe Kebede');
      expect(state.user!.role, UserRole.jobSeeker);
    });

    test('rejects invalid login credentials', () async {
      final success = await container
          .read(authProvider.notifier)
          .login(email: 'unknown@example.com', password: 'wrongpassword');

      final state = container.read(authProvider);

      expect(success, isFalse);
      expect(state.isAuthenticated, isFalse);
      expect(state.errorMessage, 'Invalid email or password.');
    });

    test('registers a new employer successfully', () async {
      final success = await container
          .read(authProvider.notifier)
          .register(
            fullName: 'New Employer',
            email: 'employer@example.com',
            password: 'password123',
            role: UserRole.employer,
          );

      final state = container.read(authProvider);

      expect(success, isTrue);
      expect(state.isAuthenticated, isTrue);
      expect(state.user!.fullName, 'New Employer');
      expect(state.user!.role, UserRole.employer);
    });

    test('rejects registration with an existing email', () async {
      final success = await container
          .read(authProvider.notifier)
          .register(
            fullName: 'Another Abebe',
            email: 'abebe@example.com',
            password: 'password123',
            role: UserRole.jobSeeker,
          );

      final state = container.read(authProvider);

      expect(success, isFalse);
      expect(state.isAuthenticated, isFalse);
      expect(state.errorMessage, 'This email is already registered.');
    });

    test('logout clears authentication state', () async {
      await container
          .read(authProvider.notifier)
          .login(email: 'abebe@example.com', password: 'password123');

      await container.read(authProvider.notifier).logout();

      final state = container.read(authProvider);

      expect(state.user, isNull);
      expect(state.isAuthenticated, isFalse);
    });
  });
}
