import '../../domain/models/user.dart';
import '../sample_data/sample_users.dart';

class AuthLocalDataSource {
  AuthLocalDataSource({List<SampleUserAccount>? initialUsers})
      : _users = List.of(initialUsers ?? sampleUsers);

  final List<SampleUserAccount> _users;

  User? _currentUser;

  Future<User?> login(String email, String password) async {
    final normalizedEmail = email.trim().toLowerCase();

    for (final account in _users) {
      if (account.user.email.toLowerCase() == normalizedEmail &&
          account.password == password) {
        _currentUser = account.user;
        return _currentUser;
      }
    }

    return null;
  }

  Future<User?> register({
    required String fullName,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    final normalizedName = fullName.trim();

    if (normalizedName.isEmpty || normalizedEmail.isEmpty || password.isEmpty) {
      return null;
    }

    final emailExists = _users.any(
      (account) => account.user.email.toLowerCase() == normalizedEmail,
    );

    if (emailExists) return null;

    final user = User(
      id: 'user_${DateTime.now().microsecondsSinceEpoch}',
      fullName: normalizedName,
      email: normalizedEmail,
      role: role,
    );

    _users.add(SampleUserAccount(user: user, password: password));

    _currentUser = user;

    return user;
  }

  Future<void> logout() async {
    _currentUser = null;
  }

  Future<User?> getCurrentUser() async {
    return _currentUser;
  }
}
