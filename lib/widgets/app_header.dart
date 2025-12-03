import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:union_shop/widgets/buttons.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  // Navigation helpers
  void _navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void _navigateToCollections(BuildContext context) {
    Navigator.pushNamed(context, '/collections');
  }

  void _navigateToSaleCollections(BuildContext context) {
    Navigator.pushNamed(context, '/sale');
  }

  void _navigateToAboutUs(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }

  void _placeholderCallback() {
    // For search/cart/menu actions not implemented yet.
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: LayoutBuilder(
          builder: (context, headerConstraints) {
            final bool isMobile = headerConstraints.maxWidth < 600;

            if (isMobile) {
              // Mobile / small-width header: logo + header buttons
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 45,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => _navigateToHome(context),
                        child: Image.network(
                          'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                          height: 32,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.store,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 55,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: _buildAccountActions(context),
                    ),
                  ),
                ],
              );
            } else {
              // Desktop / tablet header: logo + nav links + header buttons
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 20,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => _navigateToHome(context),
                        child: Image.network(
                          'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                          height: 40,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.store,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 40,
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => _navigateToHome(context),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'Home',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _navigateToCollections(context),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'Collections',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _navigateToSaleCollections(context),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'Sale',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _navigateToAboutUs(context),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'About Us',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 20,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: HeaderButtons(
                        onSearch: _placeholderCallback,
                        onAccount: () => _navigateToLogin(context),
                        onCart: _placeholderCallback,
                        onMenu: _placeholderCallback,
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildAccountActions(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is logged in
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '👤 Hello, ${user.displayName ?? 'User'}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
              }
            },
          ),
        ],
      );
    } else {
      // Not logged in — show the regular icon bar
      return HeaderButtons(
        onSearch: _placeholderCallback,
        onAccount: () => _navigateToLogin(context),
        onCart: _placeholderCallback,
        onMenu: _placeholderCallback,
      );
    }
  }
}
