import 'package:ass3/providers/notes_provider.dart';
import 'package:ass3/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'color_scheme.dart';
// Import your providers and AppColors here

/// The details screen showing all notes
class DetailsScreen extends ConsumerWidget {
  /// Constructs a [DetailsScreen]
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeModeProvider);

    final notes = ref.watch(notesProvider);

    return Scaffold(
      backgroundColor: AppColors.background[isDark ? 1 : 0],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background[isDark ? 1 : 0],
        title: Text(
          'Notes',
          style: TextStyle(
            color: AppColors.textPrimary[isDark ? 1 : 0],
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: notes.isEmpty ? Center(
        child: Text(
          'No notes yet',
          style: TextStyle(
            color: AppColors.textSecondary[isDark ? 1 : 0],
            fontSize: 16,
          ),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return InkWell(
            onTap: () => context.go('/', extra: note),  // ← Also fixed: pass note for editing
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface[isDark ? 1 : 0],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(  // ← Changed to Row
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(  // ← Wrap Column in Expanded
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (note.title.isNotEmpty)
                          Text(
                            note.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary[isDark ? 1 : 0],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        if (note.title.isNotEmpty)
                          const SizedBox(height: 6),
                        Text(
                          note.content,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary[isDark ? 1 : 0],
                            height: 1.5,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(  // ← Added delete button
                    icon: Icon(
                      Icons.delete_outline,
                      color: AppColors.textSecondary[isDark ? 1 : 0],
                    ),
                    onPressed: () {
                      ref.read(notesProvider.notifier).deleteNote(note.id!);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/'),
        backgroundColor: AppColors.iconPrimary[isDark ? 1 : 0],
        foregroundColor: AppColors.background[isDark ? 1 : 0],
        child: const Icon(Icons.add),
      ),
    );
  }
}