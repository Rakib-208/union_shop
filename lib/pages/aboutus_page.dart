import 'package:flutter/material.dart';
import 'package:union_shop/widgets/footer.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4D2963),
        elevation: 0,
        title: const Text(
          'About Us',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                height: 180,
                width: double.infinity,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.image, size: 48, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            // Title
            const Text(
              'Who We Are',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'The University of Portsmouth Students’ Union (UPSU) exists to support, empower and represent students. Our Union Shop provides students, staff and visitors with high-quality merchandise designed to celebrate student life, local identity and Portsmouth pride.',
              style:
                  TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
            ),

            const SizedBox(height: 32),

            // Mission
            const Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'We aim to deliver excellent products and a seamless shopping experience. Every purchase supports UPSU initiatives, student activities, and the wider student community.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),

            const SizedBox(height: 32),

            // What We Offer
            const Text(
              'What We Offer',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 12),

            bulletPoint('Official University merchandise and apparel'),
            bulletPoint('Local Portsmouth gifts and accessories'),
            bulletPoint('Course-related products and student essentials'),
            bulletPoint('Online ordering with fast delivery'),
            bulletPoint('Support for Union events and student life'),

            const SizedBox(height: 32),

            // Vision
            const Text(
              'Our Vision',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'To be the trusted destination for students and the community to celebrate Portsmouth identity, while reinvesting profits directly into improving the student experience.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),

            const SizedBox(height: 48),

            // Contact Section
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 12),

            contactRow(Icons.location_on,
                'University of Portsmouth Students’ Union\nCambridge Road, Portsmouth PO1 2EF'),
            const SizedBox(height: 12),
            contactRow(Icons.email, 'support@upsu.net'),
            const SizedBox(height: 12),
            contactRow(
                Icons.access_time, 'Monday–Friday: 10am–4pm (Term Time)'),

            const SizedBox(height: 50),
            const Footer(),
          ],
        ),
      ),
    );
  }

  // Reusable bullet point widget
  static Widget bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 18)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable contact info row
  static Widget contactRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 22, color: Colors.grey[700]),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, height: 1.4),
          ),
        ),
      ],
    );
  }
}
