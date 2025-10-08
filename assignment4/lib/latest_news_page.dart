import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The details screen
class LatestNewsPage extends StatelessWidget {
  /// Constructs a [DetailsScreen]
  const LatestNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Latest Stories')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Go back to the Top news'),
        ),
      ),
    );
  }
}
