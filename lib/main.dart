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
        // FIX: read Product argument and pass into ProductPage
        '/product': (context) {
          final product = ModalRoute.of(context)!.settings.arguments as Product;
          return ProductPage(
              product: product); // FIX: pass selected product into page
        },
        '/login': (context) => const LoginPage(),
        '/about': (context) => const AboutUsPage(),
        '/collections': (context) => const CollectionsPage(),
        '/collection': (context) => const CollectionPage(),
        '/sale': (context) => const SaleCollectionPage(),
        '/terms': (context) => const TermsAndConditionsPage(),
        SignupPage.routeName: (context) => const SignupPage(),
      },
    );
  }
}
