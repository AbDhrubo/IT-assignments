import 'package:ass3/providers/notes_provider.dart';
import 'package:ass3/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


import 'color_scheme.dart';
import 'models/notes.dart';
// Import your providers and AppColors here

/// The note editor screen
class HomeScreen extends ConsumerStatefulWidget {
  final Note? note;
  /// Constructs a [HomeScreen]
  const HomeScreen({super.key, this.note});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final FocusNode _contentFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
    else{
      _titleController.text = '';
      _contentController.text = '';
    }
  }



  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty && content.isEmpty) return;

    if (widget.note != null) {
      final updatedNote = Note(
        id: widget.note!.id,
        title: title,
        content: content,
      );
      await ref.read(notesProvider.notifier).updateNote(updatedNote);
    } else {
      await ref.read(notesProvider.notifier).addNote(title, content);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider);

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
          onPressed: () async{
            await _saveNote();
            if(context.mounted) {
              context.go('/details');
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: AppColors.iconPrimary[isDark ? 1 : 0],
            ),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary[isDark ? 1 : 0],
              ),
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textHint[isDark ? 1 : 0],
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (_) {
                _contentFocusNode.requestFocus();
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              focusNode: _contentFocusNode,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary[isDark ? 1 : 0],
                height: 1.6,
              ),
              decoration: InputDecoration(
                hintText: 'Start typing your note...',
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: AppColors.textHint[isDark ? 1 : 0],
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
    );
  }
}