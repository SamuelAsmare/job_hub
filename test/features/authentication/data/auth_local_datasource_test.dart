import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/authentication/data/datasources/auth_local_datasource.dart';
import 'package:job_hub/features/authentication/domain/models/user.dart';

void main() {
  late AuthLocalDataSource dataSource;

  setUp(() {
    dataSource = AuthLocalDataSource(initialUsers: []);
  });

  group('AuthLocalDataSource', () {
    test('registers a new user successfully', () async {
      final user = await dataSource.register(
        fullName: 'Yadelew Zemene',
        email: 'yadelew@example.com',
        password: 'password123',
        role: UserRole.jobSeeker,
      );

      expect(user, isNotNull);
      expect(user!.fullName, 'Yadelew Zemene');
      expect(user.email, 'yadelew@example.com');
      expect(user.role, UserRole.jobSeeker);
    });

    test('rejects registration with an existing email', () async {
      await dataSource.register(
        fullName: 'First User',
        email: 'test@example.com',
        password: 'password123',
        role: UserRole.jobSeeker,
      );

      final duplicateUser = await dataSource.register(
        fullName: 'Second User',
        email: 'TEST@example.com',
        password: 'password456',
        role: UserRole.employer,
      );

      expect(duplicateUser, isNull);
    });

    test('logs in with valid credentials', () async {
      await dataSource.register(
        fullName: 'Test User',
        email: 'test@example.com',
        password: 'password123',
        role: UserRole.jobSeeker,
      );

      final user = await dataSource.login(
        'test@example.com',
        'password123',
      );

      expect(user, isNotNull);
      expect(user!.email, 'test@example.com');
    });

    test('rejects invalid login credentials', () async {
      final user = await dataSource.login(
        'unknown@example.com',
        'wrongpassword',
      );

      expect(user, isNull);
    });

    test('normalizes email addresses during login', () async {
      await dataSource.register(
        fullName: 'Test User',
        email: 'test@example.com',
        password: 'password123',
        role: UserRole.jobSeeker,
      );

      final user = await dataSource.login(
        ' TEST@EXAMPLE.COM ',
        'password123',
      );

      expect(user, isNotNull);
      expect(user!.email, 'test@example.com');
    });

    test('logout clears the current user', () async {
      await dataSource.register(
        fullName: 'Test User',
        email: 'test@example.com',
        password: 'password123',
        role: UserRole.employer,
      );

      await dataSource.logout();

      final currentUser = await dataSource.getCurrentUser();

      expect(currentUser, isNull);
    });

    test('rejects registration with empty required fields', () async {
      final user = await dataSource.register(
        fullName: ' ',
        email: 'test@example.com',
        password: 'password123',
        role: UserRole.jobSeeker,
      );

      expect(user, isNull);
    });
  });
}
