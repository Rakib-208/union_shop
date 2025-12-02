import 'package:flutter/material.dart';
import 'package:union_shop/pages/search_results_page.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _runFooterSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      // If the box is empty, do nothing.
      return;
    }

    // Go to the same SearchResultsPage that the header search uses,
    // passing the text the user typed.
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SearchResultsPage(query: query),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Opening Hours',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '❄️ Winter Break Closure Dates ❄️',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Closing 4pm 19/12/2025\n'
            'Reopening 10am 05/01/2026\n'
            'Last post date: 12pm on 18/12/2025',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
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
          const SizedBox(height: 24),

          // SECTION TITLE
          const Text(
            'Help and Information',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),

          // 🔍 NEW SEARCH BAR IN FOOTER
          TextField(
            controller: _searchController,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => _runFooterSearch(), // when user hits Enter
            decoration: InputDecoration(
              hintText: 'Search products…',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: _runFooterSearch, // when user taps the icon
              ),
            ),
          ),
          const SizedBox(height: 12),

          // EXISTING LINKS (still clickable)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/terms');
                },
                child: const Text(
                  'Terms & Conditions of Sale Policy',
                  style: TextStyle(
                    color: Colors.blue, // highlight to show link
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/about');
                },
                child: const Text(
                  'About Us',
                  style: TextStyle(
                    color: Colors.blue, // highlight to show link
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
