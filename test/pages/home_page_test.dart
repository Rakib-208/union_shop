import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/pages/collections_page.dart';

void main() {
  group('HomeScreen', () {
    testWidgets('renders hero, products section and footer', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Hero text
      expect(find.text('Placeholder Hero Title'), findsOneWidget);
      expect(
        find.text('This is placeholder text for the hero section.'),
        findsOneWidget,
      );

      // Sale banner (partial match)
      expect(find.textContaining('BIG SALE!'), findsOneWidget);

      // Products section heading
      expect(find.text('PRODUCTS SECTION'), findsOneWidget);

      // Product cards and prices
      expect(find.text('Placeholder Product 1'), findsOneWidget);
      expect(find.text('Placeholder Product 2'), findsOneWidget);
      expect(find.text('Placeholder Product 3'), findsOneWidget);
      expect(find.text('Placeholder Product 4'), findsOneWidget);
      expect(find.text('£10.00'), findsOneWidget);
      expect(find.text('£15.00'), findsOneWidget);
      expect(find.text('£20.00'), findsOneWidget);
      expect(find.text('£25.00'), findsOneWidget);

      // Footer from shared Footer widget
      expect(find.text('Opening Hours'), findsOneWidget);
      expect(find.textContaining('Winter Break Closure'), findsOneWidget);
    });

    testWidgets('header icons are visible', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('browse products button navigates to collections page',
        (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      expect(find.text('BROWSE PRODUCTS'), findsOneWidget);
      await tester.tap(find.text('BROWSE PRODUCTS'));
      await tester.pumpAndSettle();

      expect(find.byType(CollectionsPage), findsOneWidget);
    });
  });
}
