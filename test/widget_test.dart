import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/main.dart';

void main() {
  testWidgets('JobHubApp renders welcome text smoke test',
      (WidgetTester tester) async {
    await tester.pumpWidget(const JobHubApp());

    expect(find.text('Welcome to JobHub!'), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
  });
}
