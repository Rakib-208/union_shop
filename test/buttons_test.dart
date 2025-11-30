import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/buttons.dart';

void main() {
  group('HeaderButtons', () {
    testWidgets('invokes callbacks when icons tapped', (tester) async {
      var searchTapped = false;
      var accountTapped = false;
      var cartTapped = false;
      var menuTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeaderButtons(
              onSearch: () => searchTapped = true,
              onAccount: () => accountTapped = true,
              onCart: () => cartTapped = true,
              onMenu: () => menuTapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.search));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.person_outline));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.shopping_bag_outlined));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pump();

      expect(searchTapped, isTrue);
      expect(accountTapped, isTrue);
      expect(cartTapped, isTrue);
      expect(menuTapped, isTrue);
    });

    testWidgets('opens search overlay when search icon tapped', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeaderButtons(
              onSearch: () {},
              onAccount: () {},
              onCart: () {},
              onMenu: () {},
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsNothing);

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Search overlay should show a TextField
      expect(find.byType(TextField), findsWidgets);
    });
  });
}
