import 'package:equatable/equatable.dart';

import '../models/post.dart';

/// Состояния BLoC
abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

/// Начальное состояние, данных ещё нет
class PostInitial extends PostState {
  const PostInitial();
}

/// Идёт загрузка
class PostLoading extends PostState {
  const PostLoading();
}

/// Посты загружены
class PostLoaded extends PostState {
  final List<Post> posts;

  const PostLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

/// Ошибка загрузки
class PostError extends PostState {
  final String message;

  const PostError(this.message);

  @override
  List<Object?> get props => [message];
}
