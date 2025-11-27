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
  OverlayEntry? _searchOverlayEntry;
  final TextEditingController _searchController = TextEditingController();

  void _showSearchOverlay() {
    if (_searchOverlayEntry != null) return;

    _searchOverlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Full-screen translucent area to detect outside taps
            Positioned.fill(
              child: Listener(
                behavior: HitTestBehavior.translucent,
                onPointerDown: (PointerDownEvent e) {
                  // Determine if tap is outside the search box by layout bounds
                  // Since we don't have the box rect here, close immediately,
                  // then forward the original pointer down so underlying widgets receive it.
                  _removeSearchOverlay();
                  // Forward the original event to underlying widgets
                  WidgetsBinding.instance.handlePointerEvent(e);
                },
              ),
            ),
            // Top search bar
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: Material(
                color: Colors.transparent,
                child: SafeArea(
                  bottom: false,
                  child: Container(
                    color: Colors.white,
                    // Reduce vertical padding to shrink height
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              hintText: 'Search...',
                              border: OutlineInputBorder(),
                              isDense: true,
                              // Reduce content padding for a shorter field
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.search, color: Colors.grey),
                          tooltip: 'Go',
                          onPressed: () {
                            // Navigate to home page using existing '/' route.
                            Navigator.of(context).pushNamed('/');
                            _removeSearchOverlay();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.grey),
                          tooltip: 'Close',
                          onPressed: _removeSearchOverlay,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_searchOverlayEntry!);
  }

  void _removeSearchOverlay() {
    _searchOverlayEntry?.remove();
    _searchOverlayEntry = null;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _removeSearchOverlay();
    super.dispose();
  }

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
          icon: const Icon(Icons.shopping_bag_outlined,
              size: 18, color: Colors.grey),
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
          onSelected: (value) {
            if (value == 0) {
              Navigator.of(context).pushNamed('/');
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem<int>(
              value: 0,
              child: Row(
                children: [
                  Icon(Icons.home, size: 18),
                  SizedBox(width: 8),
                  Text('Home'),
                ],
              ),
            ),
          ],
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
