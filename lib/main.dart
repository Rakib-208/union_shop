import 'package:flutter/material.dart';
import 'package:union_shop/pages/home_page.dart';
import 'package:union_shop/pages/product_page.dart';
import 'package:union_shop/pages/login_page.dart';
import 'package:union_shop/pages/aboutus_page.dart';
import 'package:union_shop/pages/signup_page.dart';

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4d2963),
        ),
      ),

      // App entry point: HomeScreen from home_page.dart
      home: const HomeScreen(),

      // Named routes used elsewhere in the app
      routes: {
        '/product': (context) => const ProductPage(),
        '/login': (context) => const LoginPage(),
        '/about': (context) => const AboutUsPage(),
        SignupPage.routeName: (context) => const SignupPage(),
      },
    );
  }
}
