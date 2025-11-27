import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/home_page.dart'; // added
import 'package:union_shop/login_page.dart';
import 'package:union_shop/aboutus.dart';
import 'package:union_shop/signup_page.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      home: const HomeScreen(), // unchanged, now comes from home_page.dart
      initialRoute: '/',
      routes: {
        '/product': (context) => const ProductPage(),
        '/login': (context) => const LoginPage(),
        '/about': (context) => const AboutUsPage(),
        SignupPage.routeName: (context) => const SignupPage(),
// added
      },
    );
  }
}
