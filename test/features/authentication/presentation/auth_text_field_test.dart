import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/authentication/presentation/widgets/auth_text_field.dart';

void main() {
  group('AuthTextField', () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    tearDown(() {
      controller.dispose();
    });

    testWidgets('displays label and prefix icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthTextField(
              controller: controller,
              label: 'Email Address',
              icon: Icons.email_outlined,
            ),
          ),
        ),
      );

      expect(find.text('Email Address'), findsOneWidget);
      expect(find.byIcon(Icons.email_outlined), findsOneWidget);
    });

    testWidgets('password is obscured by default', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthTextField(
              controller: controller,
              label: 'Password',
              icon: Icons.lock_outline,
              isPassword: true,
            ),
          ),
        ),
      );

      final field = tester.widget<EditableText>(
        find.byType(EditableText),
      );

      expect(field.obscureText, isTrue);
      expect(find.byTooltip('Show password'), findsOneWidget);
    });

    testWidgets('password visibility can be toggled', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthTextField(
              controller: controller,
              label: 'Password',
              icon: Icons.lock_outline,
              isPassword: true,
            ),
          ),
        ),
      );

      await tester.tap(find.byTooltip('Show password'));
      await tester.pumpAndSettle();

      var field = tester.widget<EditableText>(
        find.byType(EditableText),
      );

      expect(field.obscureText, isFalse);
      expect(find.byTooltip('Hide password'), findsOneWidget);

      await tester.tap(find.byTooltip('Hide password'));
      await tester.pumpAndSettle();

      field = tester.widget<EditableText>(
        find.byType(EditableText),
      );

      expect(field.obscureText, isTrue);
    });

    testWidgets('updates the supplied controller', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthTextField(
              controller: controller,
              label: 'Full Name',
              icon: Icons.person_outline,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'Test User');

      expect(controller.text, 'Test User');
    });
  });
}
