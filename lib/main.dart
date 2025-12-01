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
        '/collection': (context) => const CollectionPage(),
        '/sale': (context) => const SaleCollectionPage(),
        '/terms': (context) => const TermsAndConditionsPage(),
        SignupPage.routeName: (context) => const SignupPage(),
      },
      onGenerateRoute: (settings) {
        // This lets us support URLs like /product/HOODIE-01
        final name = settings.name ?? '';

        // Example name: "/product/HOODIE-01"
        if (name.startsWith('/product/')) {
          // We still get the full Product object via arguments
          final product = settings.arguments as Product?;

          if (product == null) {
            // If for some reason no product was passed, send user home
            return MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            );
          }

          // OPTIONAL: you *could* verify product.id == id here.
          // For now we just trust the navigation call.

          return MaterialPageRoute(
            builder: (context) => ProductPage(product: product),
            settings: settings,
          );
        }

        // If it's not a /product/... URL, let Flutter use the normal routes map
        return null;
      },
    );
  }
}
