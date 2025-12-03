import 'package:flutter/material.dart';

class PrintShackPage extends StatelessWidget {
  const PrintShackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Print Shack – Personalisation'),
      ),
      body: const Center(
        child: Text(
          'Print Shack personalisation page (placeholder)',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
