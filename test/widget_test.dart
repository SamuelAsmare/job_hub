import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/core/constants/app_constants.dart';
import 'package:job_hub/main.dart';

void main() {
  testWidgets(
    'JobHubApp boots with Integration Hub and navigates to integrated screens',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: JobHubApp()),
      );
      await tester.pumpAndSettle();

      expect(find.text(AppConstants.appName), findsOneWidget);
      expect(find.text('Session & Theme Controls'), findsOneWidget);

      final scrollable = find.byType(Scrollable).first;

      // Find Saved Jobs by scrolling down.
      await tester.scrollUntilVisible(
        find.text('Saved Jobs'),
        300,
        scrollable: scrollable,
      );
      expect(find.text('Saved Jobs'), findsOneWidget);

      // Continue scrolling to Notifications.
      await tester.scrollUntilVisible(
        find.text('Notifications'),
        300,
        scrollable: scrollable,
      );
      expect(find.text('Notifications'), findsOneWidget);

      await tester.tap(find.text('Notifications'));
      await tester.pumpAndSettle();

      expect(find.text('UPDATES & ALERTS'), findsOneWidget);
    },
  );
}
