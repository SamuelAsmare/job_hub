import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/authentication/domain/models/user.dart';
import 'package:job_hub/features/authentication/presentation/widgets/auth_role_selector.dart';

void main() {
  group('AuthRoleSelector', () {
    testWidgets('displays both available roles', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthRoleSelector(
              selectedRole: UserRole.jobSeeker,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Job Seeker'), findsOneWidget);
      expect(find.text('Employer'), findsOneWidget);
      expect(find.text('Find opportunities'), findsOneWidget);
      expect(find.text('Hire talent'), findsOneWidget);
    });

    testWidgets('selecting employer calls onChanged', (tester) async {
      UserRole? selectedRole;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthRoleSelector(
              selectedRole: UserRole.jobSeeker,
              onChanged: (role) => selectedRole = role,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Employer'));
      await tester.pumpAndSettle();

      expect(selectedRole, UserRole.employer);
    });

    testWidgets('selecting job seeker calls onChanged', (tester) async {
      UserRole? selectedRole;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthRoleSelector(
              selectedRole: UserRole.employer,
              onChanged: (role) => selectedRole = role,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Job Seeker'));
      await tester.pumpAndSettle();

      expect(selectedRole, UserRole.jobSeeker);
    });
  });
}
