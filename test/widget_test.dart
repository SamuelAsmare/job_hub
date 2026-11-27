import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/main.dart';

void main() {
  testWidgets(
    'JobHubApp boots to WelcomeScreen and navigates to AuthScreen on Login',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: JobHubApp()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Find Your Next Opportunity'), findsOneWidget);
      expect(find.text('Create Account'), findsOneWidget);

      await tester.ensureVisible(find.text('Sign In'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();

      expect(find.text('Welcome Back'), findsOneWidget);
    },
  );
}
