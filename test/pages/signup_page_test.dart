import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/signup_page.dart';

void main() {
  group('SignupPage', () {
    testWidgets('renders signup form elements', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SignupPage()));
      await tester.pump();

      expect(find.text('Create account'), findsOneWidget);
      expect(find.text('Full name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm password'), findsOneWidget);
      expect(
        find.text('Already have an account? Log in'),
        findsOneWidget,
      );
    });
  });
}
