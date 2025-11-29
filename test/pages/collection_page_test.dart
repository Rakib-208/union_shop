import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/collection_page.dart';

void main() {
  group('CollectionExamplePage', () {
    testWidgets('shows filters and product cards', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: CollectionPage()));
      await tester.pump();

      expect(find.text('Course Hoodies Collection'), findsOneWidget);

      // filter labels
      expect(find.text('Sort by'), findsOneWidget);
      expect(find.text('Size'), findsOneWidget);
      expect(find.text('Colour'), findsOneWidget);

      // products
      expect(find.textContaining('Course Hoodie'), findsWidgets);
    });
  });
}
