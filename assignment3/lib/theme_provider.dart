// theme_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for SharedPreferences instance
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

/// Provider for theme mode (dark/light)
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, bool>((ref) {
  return ThemeModeNotifier(ref);
});

/// Provider for font size
final fontSizeProvider = StateNotifierProvider<FontSizeNotifier, double>((ref) {
  return FontSizeNotifier(ref);
});

/// Notifier for managing theme mode
class ThemeModeNotifier extends StateNotifier<bool> {
  final Ref ref;
  static const String _themeKey = 'isDarkMode';

  ThemeModeNotifier(this.ref) : super(false) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    state = prefs.getBool(_themeKey) ?? false;
  }

  Future<void> toggleTheme() async {
    state = !state;
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setBool(_themeKey, state);
  }
}

/// Notifier for managing font size
class FontSizeNotifier extends StateNotifier<double> {
  final Ref ref;
  static const String _fontSizeKey = 'fontSize';

  FontSizeNotifier(this.ref) : super(16.0) {
    _loadFontSize();
  }

  Future<void> _loadFontSize() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    state = prefs.getDouble(_fontSizeKey) ?? 16.0;
  }

  Future<void> setFontSize(double size) async {
    state = size;
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setDouble(_fontSizeKey, size);
  }
}

/// Light theme
final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.grey[50],
  colorScheme: ColorScheme.light(
    primary: Colors.black87,
    secondary: Colors.grey[700]!,
  ),
);

/// Dark theme
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey[900],
  colorScheme: ColorScheme.dark(
    primary: Colors.white,
    secondary: Colors.grey[400]!,
  ),
);