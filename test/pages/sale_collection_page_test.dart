import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/sale_collection_page.dart';

void main() {
  group('SaleCollectionPage', () {
    testWidgets('shows sale messaging and discounted prices', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SaleCollectionPage()));
      await tester.pump();

      expect(find.text('Sale & Promotions'), findsOneWidget);
      expect(find.textContaining('LIMITED TIME SALE'), findsOneWidget);
      expect(find.textContaining('Up to 30% off'), findsOneWidget);

      // at least some £ prices rendered
      expect(find.textContaining('£'), findsWidgets);
    });
  });
}
