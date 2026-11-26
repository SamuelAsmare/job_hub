import '../../domain/models/user.dart';

class SampleUserAccount {
  const SampleUserAccount({required this.user, required this.password});

  final User user;
  final String password;
}

const sampleUsers = [
  SampleUserAccount(
    user: User(
      id: 'user_001',
      fullName: 'Abebe Kebede',
      email: 'abebe@example.com',
      role: UserRole.jobSeeker,
      profileImage: null,
    ),
    password: 'password123',
  ),
  SampleUserAccount(
    user: User(
      id: 'user_002',
      fullName: 'Sara Alemu',
      email: 'sara@example.com',
      role: UserRole.employer,
      profileImage: null,
    ),
    password: 'password123',
  ),
];
