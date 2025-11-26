import 'package:flutter/material.dart';

class HeaderButtons extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.search, size: 18, color: Colors.grey),
          tooltip: 'Search',
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          onPressed: onSearch,
        ),
        IconButton(
          icon: const Icon(Icons.person_outline, size: 18, color: Colors.grey),
          tooltip: 'Account',
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          onPressed: onAccount,
        ),
        IconButton(
          icon: const Icon(Icons.shopping_bag_outlined,
              size: 18, color: Colors.grey),
          tooltip: 'Cart',
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          onPressed: onCart,
        ),
        IconButton(
          icon: const Icon(Icons.menu, size: 18, color: Colors.grey),
          tooltip: 'Menu',
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          onPressed: onMenu,
        ),
      ],
    );
  }
}

class BrowseProductsButton extends StatelessWidget {
  final VoidCallback onPressed;
  const BrowseProductsButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4d2963),
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      child: const Text(
        'BROWSE PRODUCTS',
        style: TextStyle(fontSize: 14, letterSpacing: 1),
      ),
    );
  }
}
