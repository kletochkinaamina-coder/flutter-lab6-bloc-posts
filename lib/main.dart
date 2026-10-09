import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/post_bloc.dart';
import 'bloc/post_event.dart';
import 'pages/posts_page.dart';
import 'repository/post_repository.dart';

void main() {
  runApp(MyApp(repository: PostRepository()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.repository});

  final PostRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laboratory work 6',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      // BLoC создаётся над PostsPage и сразу загружает посты
      home: BlocProvider(
        create: (_) => PostBloc(repository)..add(const FetchPosts()),
        child: const PostsPage(),
      ),
    );
  }
}
