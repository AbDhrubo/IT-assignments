import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The details screen
class BestNewsPage extends StatelessWidget {
  /// Constructs a [DetailsScreen]
  const BestNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Best Stories')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Go back to the Top news'),
        ),
      ),
    );
  }
}
