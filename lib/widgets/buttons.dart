import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:union_shop/pages/account_page.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/pages/search_results_page.dart';

class HeaderButtons extends StatefulWidget {
  final VoidCallback onSearch;
  final VoidCallback onAccount;
  final VoidCallback onCart;
  final VoidCallback onMenu;

  const HeaderButtons({
    super.key,
    required this.onSearch,
    required this.onAccount,
    required this.onCart,
    required this.onMenu,
  });

  @override
  State<HeaderButtons> createState() => _HeaderButtonsState();
}

class _HeaderButtonsState extends State<HeaderButtons> {
  final TextEditingController _searchController = TextEditingController();
  void _showSearchOverlay() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Search products'),
          content: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Try "mens hoodie" or "tshirt"...',
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              _runSearch(dialogContext);
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _runSearch(dialogContext);
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }

  void _runSearch(BuildContext dialogContext) {
    final query = _searchController.text.trim();

    if (query.isEmpty) {
      // Nothing typed → just close the popup.
      Navigator.of(dialogContext).pop();
      return;
    }

    // Close the dialog first.
    Navigator.of(dialogContext).pop();

    // Navigate to the SearchResultsPage, passing the query.
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SearchResultsPage(query: query),
      ),
    );

    // Call the callback in case header wants to react to search.
    widget.onSearch();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // EDIT: Changed Row → Wrap to avoid RenderFlex overflow on very small widths.
    // Wrap allows the icon buttons to flow onto a second "line" instead of
    // overflowing horizontally when there is not enough space.
    return Wrap(
      alignment: WrapAlignment.end,
      spacing: 0,
      runSpacing: 0,
      children: [
        IconButton(
          icon: const Icon(Icons.search, size: 18, color: Colors.grey),
          tooltip: 'Search',
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          onPressed: () {
            _showSearchOverlay();
            widget.onSearch();
          },
        ),
        IconButton(
          icon: const Icon(Icons.person_outline, size: 18, color: Colors.grey),
          tooltip: 'Account',
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          onPressed: () {
            final user = FirebaseAuth.instance.currentUser;

            if (user != null) {
              // If the user is logged in → go to My Account page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountPage(),
                ),
              );
            } else {
              // If NOT logged in → fall back to whatever AppHeader wants
              // (right now, that sends them to the Login page)
              widget.onAccount();
            }
          },
        ),
        AnimatedBuilder(
          animation: cartModel, // listen to changes in the global cart
          builder: (context, _) {
            final int count = cartModel.totalItemCount;

            return Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    size: 18,
                    color: Colors.grey,
                  ),
                  tooltip: 'Cart',
                  padding: const EdgeInsets.all(8),
                  constraints:
                      const BoxConstraints(minWidth: 32, minHeight: 32),
                  onPressed: () {
                    // 1) Navigate to the cart page
                    Navigator.pushNamed(context, '/cart');

                    // 2) Still call the callback in case AppHeader wants to do anything
                    widget.onCart();
                  },
                ),

                // This is the red little number badge
                if (count > 0)
                  Positioned(
                    right: 2, // tweak these to adjust position
                    top: 2,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Center(
                        child: Text(
                          '$count', // show the number of items in cart
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        PopupMenuButton<int>(
          icon: const Icon(Icons.menu, size: 18, color: Colors.grey),
          tooltip: 'Menu',
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          position: PopupMenuPosition.under,
          onSelected: (value) {
            if (value == 0) {
              Navigator.of(context).pushNamed('/');
            } else if (value == 1) {
              Navigator.of(context).pushNamed('/collections');
            } else if (value == 2) {
              Navigator.of(context).pushNamed('/sale');
            } else if (value == 3) {
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountPage(),
                  ),
                );
              } else {
                Navigator.of(context).pushNamed('/login');
              }
            } else if (value == 4) {
              Navigator.of(context).pushNamed('/about');
            } else if (value == 5) {
              Navigator.of(context).pushNamed('/orders');
            }
            widget.onMenu();
          },
          itemBuilder: (context) => const [
            PopupMenuItem<int>(
              value: 0,
              child: Row(
                children: [
                  Icon(Icons.home, size: 10),
                  SizedBox(width: 5),
                  Text('Home'),
                ],
              ),
            ),
            PopupMenuItem<int>(
              value: 1,
              child: Row(
                children: [
                  Icon(Icons.collections_bookmark, size: 10),
                  SizedBox(width: 5),
                  Text('Collections'),
                ],
              ),
            ),
            PopupMenuItem<int>(
              value: 2,
              child: Row(
                children: [
                  Icon(Icons.local_offer_outlined, size: 10),
                  SizedBox(width: 5),
                  Text('Sales'),
                ],
              ),
            ),
            PopupMenuItem<int>(
              value: 3,
              child: Row(
                children: [
                  Icon(Icons.person_outline, size: 10),
                  SizedBox(width: 5),
                  Text('Account'),
                ],
              ),
            ),
            PopupMenuItem<int>(
              value: 4,
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 10),
                  SizedBox(width: 5),
                  Text('About Us'),
                ],
              ),
            ),
            PopupMenuItem<int>(
              value: 5,
              child: Row(
                children: [
                  Icon(Icons.history, size: 10),
                  SizedBox(width: 5),
                  Text('Orders'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// EDIT: Reintroduced BrowseProductsButton so HomeScreen can use it in the hero.
class BrowseProductsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BrowseProductsButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF4d2963),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      child: const Text(
        'BROWSE PRODUCTS',
        style: TextStyle(
          letterSpacing: 1.2,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
