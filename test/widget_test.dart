import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/core/constants/app_constants.dart';
import 'package:job_hub/main.dart';

void main() {
  testWidgets('JobHubApp boots with Integration Hub and navigates to integrated screens', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: JobHubApp()));
    await tester.pumpAndSettle();

    expect(find.text(AppConstants.appName), findsOneWidget);
    expect(find.text('Session & Theme Controls'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Saved Jobs'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    await tester.tap(find.text('Notifications'));
    await tester.pumpAndSettle();

    expect(find.text('UPDATES & ALERTS'), findsOneWidget);
  });
}
