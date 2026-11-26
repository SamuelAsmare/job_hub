import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/features/notifications/presentation/screens/notifications_screen.dart';

void main() {
  testWidgets('shows the notifications empty state', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: NotificationsScreen(),
      ),
    );
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text("You're all caught up"), findsOneWidget);
    expect(find.text('New notifications will appear here.'), findsOneWidget);
  });
}
