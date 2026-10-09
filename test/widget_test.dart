import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:lab6_app/main.dart';
import 'package:lab6_app/models/post.dart';
import 'package:lab6_app/repository/post_repository.dart';

void main() {
  test('Post.fromJson читает JSON', () {
    final post = Post.fromJson(
      {'userId': 1, 'id': 2, 'title': 'Hello', 'body': 'World'},
    );
    expect(post.id, 2);
    expect(post.title, 'Hello');
    expect(post.toJson()['body'], 'World');
  });

  testWidgets('Посты загружаются и показываются списком', (tester) async {
    final client = MockClient((_) async => http.Response(
          jsonEncode([
            {'userId': 1, 'id': 1, 'title': 'First post', 'body': 'Body 1'},
            {'userId': 1, 'id': 2, 'title': 'Second post', 'body': 'Body 2'},
          ]),
          200,
        ));
    await tester.pumpWidget(
      MyApp(repository: PostRepository(client: client)),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('First post'), findsOneWidget);
    expect(find.text('Body 2'), findsOneWidget);
  });

  testWidgets('Ошибка сервера показывает сообщение и кнопку Retry',
      (tester) async {
    final client = MockClient((_) async => http.Response('', 500));
    await tester.pumpWidget(
      MyApp(repository: PostRepository(client: client)),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('Failed to load posts'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });
}
