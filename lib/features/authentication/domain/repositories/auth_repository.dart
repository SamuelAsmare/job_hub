import '../models/user.dart';

abstract class AuthRepository {
  Future<User?> login(String email, String password);

  Future<User?> register({
    required String fullName,
    required String email,
    required String password,
    required UserRole role,
  });

  Future<void> logout();

  Future<User?> getCurrentUser();
}
