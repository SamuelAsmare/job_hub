import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._localDataSource);

  final AuthLocalDataSource _localDataSource;

  @override
  Future<User?> login(String email, String password) {
    return _localDataSource.login(email, password);
  }

  @override
  Future<User?> register({
    required String fullName,
    required String email,
    required String password,
    required UserRole role,
  }) {
    return _localDataSource.register(
      fullName: fullName,
      email: email,
      password: password,
      role: role,
    );
  }

  @override
  Future<void> logout() {
    return _localDataSource.logout();
  }

  @override
  Future<User?> getCurrentUser() {
    return _localDataSource.getCurrentUser();
  }
}
