import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.all(24),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Opening Hours',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12),
          Text(
            '❄️ Winter Break Closure Dates ❄️',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Closing 4pm 19/12/2025\n'
            'Reopening 10am 05/01/2026\n'
            'Last post date: 12pm on 18/12/2025',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 20),
          Text(
            '(Term Time)\n'
            'Monday - Friday 10am - 4pm\n'
            '(Outside of Term Time / Consolidation Weeks)\n'
            'Monday - Friday 10am - 3pm\n'
            'Purchase online 24/7',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Help and Information',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Search\n'
            'Terms & Conditions of Sale Policy\n'
            'About Us',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
