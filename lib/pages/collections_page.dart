import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const collections = [
      _CollectionData(
        title: 'Course Hoodies',
        description: 'Faculty and course specific hoodies and sweatshirts.',
        routeName: '/collection-example',
      ),
      _CollectionData(
        title: 'Student Essentials',
        description: 'Stationery, study accessories and everyday basics.',
        routeName: null,
      ),
      _CollectionData(
        title: 'Gifts & Souvenirs',
        description: 'Portsmouth themed gifts, mugs and accessories.',
        routeName: null,
      ),
      _CollectionData(
        title: 'Sale & Clearance',
        description: 'Discounted end-of-line stock and seasonal promotions.',
        routeName: '/sale',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Collections'),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFF3E9FB),
            child: const Text(
              'Browse our collections of University of Portsmouth merchandise '
              'and student essentials. This page uses hardcoded dummy data '
              'for coursework purposes.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(24),
              itemCount: collections.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final data = collections[index];
                return Card(
                  elevation: 1,
                  child: ListTile(
                    title: Text(
                      data.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        data.description,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: data.routeName == null
                        ? null
                        : () => Navigator.of(context).pushNamed(data.routeName!),
                  ),
                );
              },
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}

class _CollectionData {
  final String title;
  final String description;
  final String? routeName;

  const _CollectionData({
    required this.title,
    required this.description,
    this.routeName,
  });
}
