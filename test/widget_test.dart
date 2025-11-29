import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/pages/home_page.dart';
import 'package:union_shop/pages/product_page.dart';
import 'package:union_shop/pages/login_page.dart';
import 'package:union_shop/pages/aboutus_page.dart';
import 'package:union_shop/pages/signup_page.dart';
import 'package:union_shop/pages/collections_page.dart';
import 'package:union_shop/pages/collection_page.dart';
import 'package:union_shop/pages/sale_collection_page.dart';

void main() {
  group('UnionShopApp', () {
    testWidgets('builds MaterialApp with correct configuration',
        (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.title, 'Union Shop');
      expect(materialApp.debugShowCheckedModeBanner, isFalse);
      expect(materialApp.home, isA<HomeScreen>());
    });

    testWidgets('has all named routes configured', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      final routes = materialApp.routes;
      final context = tester.element(find.byType(MaterialApp));

      expect(routes['/product']!(context), isA<ProductPage>());
      expect(routes['/login']!(context), isA<LoginPage>());
      expect(routes['/about']!(context), isA<AboutUsPage>());
      expect(routes['/collections']!(context), isA<CollectionsPage>());
      expect(routes['/collection']!(context), isA<CollectionPage>());
      expect(routes['/sale']!(context), isA<SaleCollectionPage>());
      expect(routes[SignupPage.routeName]!(context), isA<SignupPage>());
    });

    testWidgets('can navigate from home to product page', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);

      final navigator = Navigator.of(tester.element(find.byType(HomeScreen)));
      navigator.pushNamed('/product');
      await tester.pumpAndSettle();

      expect(find.byType(ProductPage), findsOneWidget);
    });
  });
}
