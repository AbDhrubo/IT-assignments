// ============= providers.dart =============
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

// Model for a story
// Model for a story
class Story {
  final int id;
  final String title;
  final String by;
  final int score;
  final String? url;
  final int? descendants;
  final int? time;
  final String? type;
  final List<int>? kids;

  Story({
    required this.id,
    required this.title,
    required this.by,
    required this.score,
    this.url,
    this.descendants,
    this.time,
    this.type,
    this.kids,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No title',
      by: json['by'] ?? 'unknown',
      score: json['score'] ?? 0,
      url: json['url'],
      descendants: json['descendants'],
      time: json['time'],
      type: json['type'],
      kids: json['kids'] != null ? List<int>.from(json['kids']) : null,
    );
  }
}

// Provider for fetching top 20 story IDs
final topStoryIdsProvider = FutureProvider<List<int>>((ref) async {
  final url = Uri.https(
      'hacker-news.firebaseio.com', '/v0/topstories.json');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> ids = convert.jsonDecode(response.body);
    return ids.cast<int>().take(20).toList(); // Take only first 20
  } else {
    throw Exception('Failed to load story IDs: ${response.statusCode}');
  }
});

// Provider for fetching a single story by ID
final storyProvider = FutureProvider.family<Story, int>((ref, id) async {
  final url = Uri.https(
      'hacker-news.firebaseio.com', '/v0/item/$id.json');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final json = convert.jsonDecode(response.body) as Map<String, dynamic>;
    return Story.fromJson(json);
  } else {
    throw Exception('Failed to load story $id');
  }
});

// Provider for fetching all top stories with details
final topStoriesProvider = FutureProvider<List<Story>>((ref) async {
  // Get the top 20 story IDs
  final ids = await ref.watch(topStoryIdsProvider.future);

  // Fetch all stories in parallel
  final storyFutures = ids.map((id) =>
      ref.watch(storyProvider(id).future)
  );

  return Future.wait(storyFutures);
});

// Provider for fetching top 20 story IDs
final newStoryIdsProvider = FutureProvider<List<int>>((ref) async {
  final url = Uri.https(
      'hacker-news.firebaseio.com', '/v0/newstories.json');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> ids = convert.jsonDecode(response.body);
    return ids.cast<int>().take(20).toList(); // Take only first 20
  } else {
    throw Exception('Failed to load story IDs: ${response.statusCode}');
  }
});

// Add Comment model
class Comment {
  final int id;
  final String by;
  final String text;
  final int time;
  final int parent;
  final String type;

  Comment({
    required this.id,
    required this.by,
    required this.text,
    required this.time,
    required this.parent,
    required this.type,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? 0,
      by: json['by'] ?? 'unknown',
      text: json['text'] ?? '',
      time: json['time'] ?? 0,
      parent: json['parent'] ?? 0,
      type: json['type'] ?? 'comment',
    );
  }
}

// Provider for fetching a single comment by ID
final commentProvider = FutureProvider.family<Comment, int>((ref, id) async {
  final url = Uri.https(
      'hacker-news.firebaseio.com', '/v0/item/$id.json');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final json = convert.jsonDecode(response.body) as Map<String, dynamic>;
    return Comment.fromJson(json);
  } else {
    throw Exception('Failed to load comment $id');
  }
});

// Provider for fetching comments for a story
final storyCommentsProvider = FutureProvider.family<List<Comment>, List<int>>((ref, commentIds) async {
  // Fetch first 10 comments only to avoid too many requests
  final idsToFetch = commentIds.take(10).toList();

  final commentFutures = idsToFetch.map((id) =>
      ref.watch(commentProvider(id).future)
  );

  return Future.wait(commentFutures);
});