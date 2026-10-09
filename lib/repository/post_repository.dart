import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post.dart';

/// Репозиторий: получает посты из API.
class PostRepository {
  PostRepository({http.Client? client}) : _client = client ?? http.Client();

  static const _url = 'https://jsonplaceholder.typicode.com/posts';

  final http.Client _client;

  Future<List<Post>> fetchPosts() async {
    final response = await _client.get(Uri.parse(_url));

    if (response.statusCode != 200) {
      throw Exception('Server error: ${response.statusCode}');
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((item) => Post.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
