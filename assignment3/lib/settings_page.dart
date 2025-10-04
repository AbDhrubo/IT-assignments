import 'package:ass3/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'color_scheme.dart';
// Import your providers and AppColors here

/// The settings screen
class SettingsScreen extends ConsumerWidget {
  /// Constructs a [SettingsScreen]
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeModeProvider);
    final fontSize = ref.watch(fontSizeProvider);

    return Scaffold(
      backgroundColor: AppColors.background[isDark ? 1 : 0],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background[isDark ? 1 : 0],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.iconPrimary[isDark ? 1 : 0],
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: AppColors.textPrimary[isDark ? 1 : 0],
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface[isDark ? 1 : 0],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Theme',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary[isDark ? 1 : 0],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        isDark ? 'Dark Mode' : 'Light Mode',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary[isDark ? 1 : 0],
                        ),
                      ),
                    ),
                    Switch(
                      value: isDark,
                      onChanged: (_) {
                        ref.read(themeModeProvider.notifier).toggleTheme();
                      },
                      activeColor: AppColors.iconPrimary[isDark ? 1 : 0],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface[isDark ? 1 : 0],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Font Size',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary[isDark ? 1 : 0],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'Small',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary[isDark ? 1 : 0],
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        value: fontSize,
                        min: 12.0,
                        max: 24.0,
                        divisions: 6,
                        activeColor: AppColors.iconPrimary[isDark ? 1 : 0],
                        onChanged: (value) {
                          ref.read(fontSizeProvider.notifier).setFontSize(value);
                        },
                      ),
                    ),
                    Text(
                      'Large',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary[isDark ? 1 : 0],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Preview Text',
                    style: TextStyle(
                      fontSize: fontSize,
                      color: AppColors.textPrimary[isDark ? 1 : 0],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}