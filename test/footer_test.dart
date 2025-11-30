import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/footer.dart';

void main() {
  group('Footer', () {
    testWidgets('shows opening hours and links', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Footer(),
          ),
        ),
      );

      expect(find.text('Opening Hours'), findsOneWidget);
      expect(find.textContaining('Winter Break Closure'), findsOneWidget);
      expect(find.text('Quick links'), findsOneWidget);
      expect(find.text('Visit Us'), findsOneWidget);
    });
  });
}
