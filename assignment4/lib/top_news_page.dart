// ============= top_news_page.dart =============
import 'package:ass4/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TopNewsPage extends ConsumerWidget {
  const TopNewsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storiesAsync = ref.watch(topStoriesProvider);  // Changed from topStoryIdsProvider

    return Scaffold(
      appBar: AppBar(title: const Text('Top Stories')),
      body: storiesAsync.when(
        data: (stories) {  // Changed from storyIds to stories
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: stories.length,
            itemBuilder: (context, index) {
              final story = stories[index];  // Get the story object
              return Card(
                margin: const EdgeInsets.symmetric(
                    vertical: 8, horizontal: 4),
                child: InkWell(
                  onTap: () {
                    context.go('/story/${story.id}');
                  },
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text(
                      story.title,  // Show the title
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'by ${story.by} • ${story.score} points',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error: $error',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(topStoriesProvider);  // Changed here too
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}