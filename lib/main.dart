import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:union_shop/firebase_options.dart';
import 'package:union_shop/pages/home_page.dart';
import 'package:union_shop/pages/product_page.dart';
import 'package:union_shop/pages/login_page.dart';
import 'package:union_shop/pages/static/aboutus_page.dart';
import 'package:union_shop/pages/signup_page.dart';
import 'package:union_shop/pages/collections_page.dart';
import 'package:union_shop/pages/collection_page.dart';
import 'package:union_shop/pages/sale_collection_page.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/pages/static/t_c.dart';
import 'package:union_shop/pages/cart_page.dart';
import 'package:union_shop/pages/order_history_page.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/order.dart';
import 'package:union_shop/pages/print_shack_page.dart';
import 'package:union_shop/pages/static/print_shack_about_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await cartModel.loadFromPrefs();
  await orderHistoryModel.loadFromPrefs();
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
        '/cart': (context) => const CartPage(),
        '/orders': (context) => const OrderHistoryPage(),
        '/terms': (context) => const TermsAndConditionsPage(),
        '/print-shack': (context) => const PrintShackPage(),
        '/print-shack-about': (context) => const PrintShackAboutPage(),
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
          // Extract whatever comes after "/product/"
          final segment = name.substring('/product/'.length).trim();

          // If nothing after /product/, treat as invalid (go home + popup)
          if (segment.isEmpty) {
            return MaterialPageRoute(
              builder: (context) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid product URL'),
                    ),
                  );
                });
                return const HomeScreen();
              },
              settings: settings,
            );
          }

          // Try to parse the id from the URL, e.g. "/product/5" -> id = 5
          final int? productId = int.tryParse(segment);

          // If it's not a valid number, treat as invalid URL
          if (productId == null) {
            return MaterialPageRoute(
              builder: (context) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid product URL'),
                    ),
                  );
                });
                return const HomeScreen();
              },
              settings: settings,
            );
          }

          // Try to find the product in your allProducts list
          Product? matchedProduct;
          for (final p in allProducts) {
            if (p.id == productId) {
              matchedProduct = p;
              break;
            }
          }

          // If no product with that id exists, also go home + popup
          if (matchedProduct == null) {
            return MaterialPageRoute(
              builder: (context) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid product URL'),
                    ),
                  );
                });
                return const HomeScreen();
              },
              settings: settings,
            );
          }

          // If we got here, we have a real product -> go to ProductPage
          return MaterialPageRoute(
            builder: (context) => ProductPage(product: matchedProduct!),
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
