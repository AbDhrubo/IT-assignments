// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:ass4/story_details_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'best_news_page.dart';
import 'top_news_page.dart';
import 'latest_news_page.dart';

/// This sample app shows an app with bottom navigation bar.
///
/// The app has three screens accessible via bottom navigation:
/// - Top News (/)
/// - Latest News (/latest)
/// - Best News (/best)
void main() {
  runApp(
    const ProviderScope(  // Wrap your app with ProviderScope
      child: MyApp(),
    ),
  );
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              builder: (BuildContext context, GoRouterState state) {
                return const TopNewsPage();
              },
              routes: <RouteBase>[
                GoRoute(
                  path: 'story/:id',
                  builder: (BuildContext context, GoRouterState state) {
                    final id = int.parse(state.pathParameters['id']!);
                    return StoryDetailPage(storyId: id);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/latest',
              builder: (BuildContext context, GoRouterState state) {
                return const LatestNewsPage();
              },
              routes: <RouteBase>[
                GoRoute(
                  path: 'story/:id',
                  builder: (BuildContext context, GoRouterState state) {
                    final id = int.parse(state.pathParameters['id']!);
                    return StoryDetailPage(storyId: id);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/best',
              builder: (BuildContext context, GoRouterState state) {
                return const BestNewsPage();
              },
              routes: <RouteBase>[
                GoRoute(
                  path: 'story/:id',
                  builder: (BuildContext context, GoRouterState state) {
                    final id = int.parse(state.pathParameters['id']!);
                    return StoryDetailPage(storyId: id);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up),
              label: 'Top',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: 'Latest',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_awesome),
              label: 'Best',
            ),
          ],
          currentIndex: navigationShell.currentIndex,
          onTap: (int index) => _onTap(context, index),
          selectedItemColor: const Color(0xFF8B5CF6), // Purple
          unselectedItemColor: Colors.grey[400],
          backgroundColor: const Color(0xFF18181B), // Almost black
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}