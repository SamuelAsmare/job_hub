import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hub/core/widgets/core_widgets.dart';

void main() {
  group('Core shared widgets', () {
    testWidgets('AppButton triggers tap and disables while loading', (tester) async {
      var tapped = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Apply Now',
              icon: Icons.send,
              onPressed: () => tapped++,
            ),
          ),
        ),
      );

      expect(find.text('Apply Now'), findsOneWidget);
      await tester.tap(find.text('Apply Now'));
      expect(tapped, 1);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Apply Now',
              isLoading: true,
              variant: AppButtonVariant.outlined,
              onPressed: () => tapped++,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.tap(find.byType(OutlinedButton));
      expect(tapped, 1);
    });

    testWidgets('AppTextField displays label, validates, and toggles password visibility', (
      tester,
    ) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: AppTextField(
                label: 'Password',
                hintText: 'Enter password',
                isPassword: true,
                validator: (value) =>
                    (value == null || value.length < 6) ? 'Too short' : null,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Enter password'), findsOneWidget);

      EditableText editableText() =>
          tester.widget<EditableText>(find.byType(EditableText));
      expect(editableText().obscureText, isTrue);

      await tester.tap(find.byTooltip('Show password'));
      await tester.pump();
      expect(editableText().obscureText, isFalse);

      expect(formKey.currentState!.validate(), isFalse);
      await tester.pump();
      expect(find.text('Too short'), findsOneWidget);
    });

    testWidgets('LoadingWidget, EmptyStateWidget, and ErrorStateWidget render properly', (
      tester,
    ) async {
      var retried = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                const LoadingWidget(message: 'Loading jobs...'),
                const EmptyStateWidget(
                  title: 'No Jobs',
                  message: 'Try adjusting your filters.',
                ),
                ErrorStateWidget(
                  title: 'Load Failed',
                  message: 'Network timeout',
                  onRetry: () => retried = true,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Loading jobs...'), findsOneWidget);
      expect(find.text('No Jobs'), findsOneWidget);
      expect(find.text('Load Failed'), findsOneWidget);

      await tester.tap(find.text('Retry'));
      expect(retried, isTrue);
    });
  });
}
