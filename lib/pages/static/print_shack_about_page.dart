import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/footer.dart';

class PrintShackAboutPage extends StatelessWidget {
  const PrintShackAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppHeader(),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Print Shack',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Print Shack allows you to personalise merch with your own text. '
                      'You can choose between one line or two lines of text, and enter '
                      'your custom message before adding the item to your cart.',
                      style: TextStyle(fontSize: 16, height: 1.4),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Example uses include adding your name, course, society name, or '
                      'a short message to hoodies, tees, or other items.',
                      style: TextStyle(fontSize: 16, height: 1.4),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Pricing in this demo is based on £3.00 per line of text. '
                      'This page is here to explain the feature as part of your coursework '
                      'and to mirror the behaviour of the official UPSU Print Shack store.',
                      style: TextStyle(fontSize: 16, height: 1.4),
                    ),
                  ],
                ),
              ),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
