import 'package:flutter/material.dart';

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
  void _showSearchOverlay() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Search'),
          content: const TextField(
            decoration: InputDecoration(
              hintText: 'Search products…',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
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
          onPressed: widget.onAccount,
        ),
        IconButton(
          icon: const Icon(
            Icons.shopping_bag_outlined,
            size: 18,
            color: Colors.grey,
          ),
          tooltip: 'Cart',
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          onPressed: widget.onCart,
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
              Navigator.of(context).pushNamed('/about');
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
                  Icon(Icons.info_outline, size: 10),
                  SizedBox(width: 5),
                  Text('About Us'),
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
