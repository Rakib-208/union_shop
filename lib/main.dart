import 'package:flutter/material.dart';
import 'package:union_shop/pages/home_page.dart';
import 'package:union_shop/pages/product_page.dart';
import 'package:union_shop/pages/login_page.dart';
import 'package:union_shop/pages/aboutus_page.dart';
import 'package:union_shop/pages/signup_page.dart';
import 'package:union_shop/pages/collections_page.dart';
import 'package:union_shop/pages/collection_page.dart';
import 'package:union_shop/pages/sale_collection_page.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/pages/t_c.dart'; // FIX: for typed product route

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4d2963),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF4d2963),
          secondary: const Color(0xFF4d2963),
        ),
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),

      // Named routes used elsewhere in the app
      routes: {
        '/login': (context) => const LoginPage(),
        '/about': (context) => const AboutUsPage(),
        '/collections': (context) => const CollectionsPage(),
        '/collection': (context) => const CollectionPage(
              title: 'Clothing collection',
              typeFilter: ProductType.clothing,
            ),
        '/sale': (context) => const SaleCollectionPage(),
        '/terms': (context) => const TermsAndConditionsPage(),
        SignupPage.routeName: (context) => const SignupPage(),
      },
      onGenerateRoute: (settings) {
        final name = settings.name ?? '';

        // 1) Handle collection URLs like:
        //    /collections/collection/clothing
        //    /collections/collection/accessories
        //    /collections/collection/all
        if (name == '/collections/collection' ||
            name == '/collections/collection/') {
          // Incomplete URL -> treat as "All products"
          return MaterialPageRoute(
            builder: (context) => const CollectionPage(
              title: 'All products',
              // no typeFilter -> show all product types
            ),
            settings: settings,
          );
        }

        if (name.startsWith('/collections/collection/')) {
          // Extract the last part after "/collections/collection/"
          final segment = name.substring('/collections/collection/'.length);

          if (segment == 'clothing') {
            return MaterialPageRoute(
              builder: (context) => const CollectionPage(
                title: 'Clothing collection',
                typeFilter: ProductType.clothing,
              ),
              settings: settings,
            );
          } else if (segment == 'accessories') {
            return MaterialPageRoute(
              builder: (context) => const CollectionPage(
                title: 'Accessories collection',
                typeFilter: ProductType.accessories,
              ),
              settings: settings,
            );
          } else {
            // Anything else (including "all" or random text)
            // falls back to "All products"
            return MaterialPageRoute(
              builder: (context) => const CollectionPage(
                title: 'All products',
                // no typeFilter -> show all product types
              ),
              settings: settings,
            );
          }
        }

        // 2) Existing dynamic product URLs like /product/<id>
        if (name.startsWith('/product/')) {
          final product = settings.arguments as Product?;
          if (product == null) {
            // If something goes wrong, go back home
            return MaterialPageRoute(
              builder: (context) => const HomeScreen(),
              settings: settings,
            );
          }

          return MaterialPageRoute(
            builder: (context) => ProductPage(product: product),
            settings: settings,
          );
        }

        // 3) If we don't handle it here, let Flutter
        //    fall back to the normal 'routes:' map.
        return null;
      },
    );
  }
}
