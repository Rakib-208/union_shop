import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/collections_page.dart';

void main() {
  group('CollectionsPage', () {
    testWidgets('shows list of collections', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: CollectionsPage()));
      await tester.pump();

      expect(find.text('Collections'), findsOneWidget);
      expect(find.text('Course Hoodies'), findsOneWidget);
      expect(find.text('Student Essentials'), findsOneWidget);
      expect(find.text('Gifts & Souvenirs'), findsOneWidget);
      expect(find.text('Sale & Clearance'), findsOneWidget);
    });
  });
}
