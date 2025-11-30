import 'package:flutter/material.dart';
import 'package:union_shop/widgets/buttons.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/widgets/header.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  // Navigation helpers – aligned with your existing patterns
  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToCollections(BuildContext context) {
    Navigator.pushNamed(context, '/collections');
  }

  void navigateToSaleCollections(BuildContext context) {
    Navigator.pushNamed(context, '/sale');
  }

  void navigateToAboutUs(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }

  void placeholderCallbackForButtons() {
    // Placeholder callbacks for header buttons – wire these up later if needed
  }

  @override
  Widget build(BuildContext context) {
    const double fixedWidth = 1100;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 600;

          return Container(
            color: Colors.white,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: fixedWidth),
                child: Column(
                  children: [
                    // TOP NAV AREA (responsive, aligned with home_page.dart approach)
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: LayoutBuilder(
                              builder: (context, headerConstraints) {
                                final bool headerIsMobile =
                                    headerConstraints.maxWidth < 600;

                                if (headerIsMobile) {
                                  // Compact header – logo + header buttons
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 45,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: GestureDetector(
                                            onTap: () =>
                                                navigateToHome(context),
                                            child: Image.network(
                                              'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                                              height: 32,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
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
                                          child: HeaderButtons(
                                            onSearch:
                                                placeholderCallbackForButtons,
                                            onAccount: () =>
                                                navigateToLogin(context),
                                            onCart:
                                                placeholderCallbackForButtons,
                                            onMenu:
                                                placeholderCallbackForButtons,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  // Desktop/tablet header – logo + nav links + header buttons
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 20,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: GestureDetector(
                                            onTap: () =>
                                                navigateToHome(context),
                                            child: Image.network(
                                              'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                                              height: 40,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    navigateToHome(context),
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                  ),
                                                  child: Text(
                                                    'Home',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () =>
                                                    navigateToCollections(
                                                        context),
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                  ),
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
                                                onTap: () =>
                                                    navigateToSaleCollections(
                                                        context),
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                  ),
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
                                                onTap: () =>
                                                    navigateToAboutUs(context),
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                  ),
                                                  child: Text(
                                                    'About Us',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Optional: you can later add a direct link here to /terms if required
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 20,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: HeaderButtons(
                                            onSearch:
                                                placeholderCallbackForButtons,
                                            onAccount: () =>
                                                navigateToLogin(context),
                                            onCart:
                                                placeholderCallbackForButtons,
                                            onMenu:
                                                placeholderCallbackForButtons,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // PAGE CONTENT + FOOTER (scrollable, responsive)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const HomeHeaderBanner(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 16 : 24,
                                vertical: isMobile ? 16 : 24,
                              ),
                              child: _TermsBody(isMobile: isMobile),
                            ),
                            const Footer(), // Footer at the end, like home_page.dart
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TermsBody extends StatelessWidget {
  final bool isMobile;

  const _TermsBody({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final double titleFontSize = isMobile ? 22 : 26;
    final double sectionTitleSize = isMobile ? 16 : 18;
    final double bodyFontSize = isMobile ? 13 : 14;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Terms & Conditions of Sale',
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Last updated: November 2025',
          style: TextStyle(
            fontSize: bodyFontSize,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 24),
        _SectionTitle(
          title: '1. Overview',
          fontSize: sectionTitleSize,
        ),
        _Paragraph(
          text:
              'These Terms & Conditions of Sale govern all purchases made via the Union Shop application. By placing an order, you '
              'agree that you are authorised to make the purchase and that you accept these terms in full.',
          fontSize: bodyFontSize,
        ),
        const SizedBox(height: 16),
        _SectionTitle(
          title: '2. Pricing & Availability',
          fontSize: sectionTitleSize,
        ),
        _Paragraph(
          text:
              'All prices are displayed in GBP (£) and include VAT where applicable. We reserve the right to update prices, '
              'products, and availability at any time without prior notice.',
          fontSize: bodyFontSize,
        ),
        _BulletList(
          fontSize: bodyFontSize,
          items: const [
            'Prices are correct at the time of listing.',
            'Promotional pricing may be time-limited or quantity-limited.',
            'Products are subject to availability and may be withdrawn without notice.',
          ],
        ),
        const SizedBox(height: 16),
        _SectionTitle(
          title: '3. Orders & Payment',
          fontSize: sectionTitleSize,
        ),
        _Paragraph(
          text:
              'Placing an order through the Union Shop interface represents an offer to purchase, which we may accept or reject. '
              'A confirmation screen or email (if implemented) indicates that your order has been received.',
          fontSize: bodyFontSize,
        ),
        _BulletList(
          fontSize: bodyFontSize,
          items: const [
            'You are responsible for ensuring that your order details are accurate.',
            'We reserve the right to cancel or refuse any order where there is a pricing or stock error.',
            'In a real deployment, payment would be processed via a secure payment provider.',
          ],
        ),
        const SizedBox(height: 16),
        _SectionTitle(
          title: '4. Collection, Delivery & Click-and-Collect',
          fontSize: sectionTitleSize,
        ),
        _Paragraph(
          text:
              'Fulfilment options (such as on-campus collection or delivery) may vary depending on the configuration of the shop. '
              'Details shown in the app are indicative of the service model and not a live logistics system.',
          fontSize: bodyFontSize,
        ),
        const SizedBox(height: 16),
        _SectionTitle(
          title: '5. Returns & Refunds',
          fontSize: sectionTitleSize,
        ),
        _Paragraph(
          text:
              'In a production environment, customers would have rights to return faulty or misdescribed goods. For the purposes '
              'of this coursework implementation, any return / refund behaviour is illustrative only.',
          fontSize: bodyFontSize,
        ),
        _BulletList(
          fontSize: bodyFontSize,
          items: const [
            'Return windows and conditions would typically be published separately.',
            'Proof of purchase is usually required for any refund or exchange.',
          ],
        ),
        const SizedBox(height: 16),
        _SectionTitle(
          title: '6. Use of the App',
          fontSize: sectionTitleSize,
        ),
        _Paragraph(
          text:
              'You agree not to misuse the Union Shop application, attempt to circumvent security controls, or interfere with '
              'other users’ ability to browse and purchase items.',
          fontSize: bodyFontSize,
        ),
        const SizedBox(height: 16),
        _SectionTitle(
          title: '7. Data & Privacy',
          fontSize: sectionTitleSize,
        ),
        _Paragraph(
          text:
              'If this application is extended with real authentication or payment systems, your personal data would be handled '
              'in line with the University’s privacy and data-protection policies. In this coursework implementation, any data '
              'storage is illustrative only.',
          fontSize: bodyFontSize,
        ),
        const SizedBox(height: 16),
        _SectionTitle(
          title: '8. Changes to These Terms',
          fontSize: sectionTitleSize,
        ),
        _Paragraph(
          text:
              'We may update these Terms & Conditions of Sale periodically. Any changes will apply from the moment they are '
              'published within the application.',
          fontSize: bodyFontSize,
        ),
        const SizedBox(height: 24),
        Text(
          'This Terms & Conditions page is part of a student coursework project and does not represent a live transactional '
          'service. For real purchases, always refer to the official Union Shop website and policies.',
          style: TextStyle(
            fontSize: bodyFontSize,
            color: Colors.black54,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final double fontSize;

  const _SectionTitle({
    required this.title,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }
}

class _Paragraph extends StatelessWidget {
  final String text;
  final double fontSize;

  const _Paragraph({
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.black87,
        height: 1.5,
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  final List<String> items;
  final double fontSize;

  const _BulletList({
    required this.items,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '• ',
                    style: TextStyle(color: Colors.black87),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
