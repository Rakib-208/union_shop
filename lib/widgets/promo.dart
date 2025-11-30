// lib/header.dart
import 'package:flutter/material.dart';

class TopPromo extends StatelessWidget {
  const TopPromo({super.key});

  void _navigateToSaleCollection(BuildContext context) {
    Navigator.pushNamed(context, '/sale');
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    final double fontSize = isMobile ? 12 : 14;
    final double verticalPadding = isMobile ? 6 : 8;
    final double horizontalPadding = isMobile ? 12 : 16;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () => _navigateToSaleCollection(context),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.10), // purple-ish, low opacity
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(
                Icons.local_offer_outlined,
                size: 16,
                color: Colors.purple,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Student sale: up to 20% off selected products – limited time.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                    color: Colors.purple.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
