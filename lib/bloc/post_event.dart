import 'package:equatable/equatable.dart';

/// События BLoC
abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

/// Загрузить посты (при открытии страницы, при повторе и при обновлении)
class FetchPosts extends PostEvent {
  const FetchPosts();
}
