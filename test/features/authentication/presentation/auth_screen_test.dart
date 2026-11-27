import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/authentication/domain/models/user.dart';
import 'package:job_hub/features/authentication/presentation/screens/auth_screen.dart';

void useLargeViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(1000, 1600);
  tester.view.devicePixelRatio = 1;

  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<void> submitForm(WidgetTester tester) async {
  final submitButton = find.byType(FilledButton);

  expect(submitButton, findsOneWidget);

  await tester.ensureVisible(submitButton);
  await tester.tap(submitButton);
  await tester.pumpAndSettle();
}

void main() {
  group('AuthScreen', () {
    testWidgets('displays login form', (tester) async {
      useLargeViewport(tester);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: AuthScreen(
              isRegistration: false,
              onAuthenticated: (_) {},
              onBack: () {},
            ),
          ),
        ),
      );

      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Sign In'), findsWidgets);
      expect(find.byType(Image), findsNothing);
    });

    testWidgets('login form remains scrollable on a compact screen',
        (tester) async {
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: AuthScreen(
              isRegistration: false,
              onAuthenticated: (_) {},
              onBack: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Welcome Back'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('registration form remains scrollable on a compact screen',
        (tester) async {
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: AuthScreen(
              isRegistration: true,
              onAuthenticated: (_) {},
              onBack: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final submitButton = find.byType(FilledButton);
      await tester.ensureVisible(submitButton);

      expect(find.text('Join JobHub'), findsOneWidget);
      expect(submitButton, findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('displays registration form', (tester) async {
      useLargeViewport(tester);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: AuthScreen(
              isRegistration: true,
              onAuthenticated: (_) {},
              onBack: () {},
            ),
          ),
        ),
      );

      expect(find.text('Join JobHub'), findsOneWidget);
      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);
      expect(find.text('Job Seeker'), findsOneWidget);
      expect(find.text('Employer'), findsOneWidget);
      expect(find.byType(Image), findsNothing);
    });

    testWidgets('calls onBack when back button is pressed', (tester) async {
      useLargeViewport(tester);

      var backCalled = false;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: AuthScreen(
              isRegistration: false,
              onAuthenticated: (_) {},
              onBack: () => backCalled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.arrow_back));

      expect(backCalled, isTrue);
    });

    testWidgets('calls onSwitchMode when switch button is pressed',
        (tester) async {
      useLargeViewport(tester);

      var switchCalled = false;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: AuthScreen(
              isRegistration: false,
              onAuthenticated: (_) {},
              onBack: () {},
              onSwitchMode: () => switchCalled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('New to JobHub? Create Account'));

      expect(switchCalled, isTrue);
    });

    testWidgets('shows validation errors for empty login fields',
        (tester) async {
      useLargeViewport(tester);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: AuthScreen(
              isRegistration: false,
              onAuthenticated: (_) {},
              onBack: () {},
            ),
          ),
        ),
      );

      await submitForm(tester);

      expect(find.text('Email is required.'), findsOneWidget);
      expect(find.text('Password is required.'), findsOneWidget);
    });

    testWidgets('shows validation error for invalid email', (tester) async {
      useLargeViewport(tester);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: AuthScreen(
              isRegistration: false,
              onAuthenticated: (_) {},
              onBack: () {},
            ),
          ),
        ),
      );

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'invalid-email',
      );

      await tester.enterText(
        find.byType(TextFormField).at(1),
        'password123',
      );

      await submitForm(tester);

      expect(find.text('Enter a valid email address.'), findsOneWidget);
    });

    testWidgets('shows error when registration passwords do not match',
        (tester) async {
      useLargeViewport(tester);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: AuthScreen(
              isRegistration: true,
              onAuthenticated: (_) {},
              onBack: () {},
            ),
          ),
        ),
      );

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'Test User',
      );

      await tester.enterText(
        find.byType(TextFormField).at(1),
        'test@example.com',
      );

      await tester.enterText(
        find.byType(TextFormField).at(2),
        'password123',
      );

      await tester.enterText(
        find.byType(TextFormField).at(3),
        'different123',
      );

      await submitForm(tester);

      expect(find.text('Passwords do not match.'), findsOneWidget);
    });

    testWidgets('successful login calls onAuthenticated', (tester) async {
      useLargeViewport(tester);

      User? authenticatedUser;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: AuthScreen(
              isRegistration: false,
              onAuthenticated: (user) => authenticatedUser = user,
              onBack: () {},
            ),
          ),
        ),
      );

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'abebe@example.com',
      );

      await tester.enterText(
        find.byType(TextFormField).at(1),
        'password123',
      );

      await submitForm(tester);

      expect(authenticatedUser, isNotNull);
      expect(authenticatedUser!.email, 'abebe@example.com');
      expect(authenticatedUser!.role, UserRole.jobSeeker);
    });

    testWidgets('successful registration calls onAuthenticated',
        (tester) async {
      useLargeViewport(tester);

      User? authenticatedUser;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: AuthScreen(
              isRegistration: true,
              onAuthenticated: (user) => authenticatedUser = user,
              onBack: () {},
            ),
          ),
        ),
      );

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'Test User',
      );

      await tester.enterText(
        find.byType(TextFormField).at(1),
        'newuser@example.com',
      );

      await tester.enterText(
        find.byType(TextFormField).at(2),
        'password123',
      );

      await tester.enterText(
        find.byType(TextFormField).at(3),
        'password123',
      );

      await submitForm(tester);

      expect(authenticatedUser, isNotNull);
      expect(authenticatedUser!.fullName, 'Test User');
      expect(authenticatedUser!.email, 'newuser@example.com');
      expect(authenticatedUser!.role, UserRole.jobSeeker);
    });
  });
}
