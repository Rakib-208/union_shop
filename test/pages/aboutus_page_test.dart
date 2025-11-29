import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/aboutus_page.dart';

void main() {
  group('AboutUsPage', () {
    testWidgets('shows key about us content', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AboutUsPage()));
      await tester.pump();

      expect(find.text('About Us'), findsOneWidget);
      expect(find.text('Our Mission'), findsOneWidget);
      expect(find.text('What We Offer'), findsOneWidget);
      expect(find.text('Our Vision'), findsOneWidget);
      expect(find.text('Contact Us'), findsOneWidget);
    });
  });
}
