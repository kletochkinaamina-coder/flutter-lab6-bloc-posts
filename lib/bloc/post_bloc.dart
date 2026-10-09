import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/post_repository.dart';
import 'post_event.dart';
import 'post_state.dart';

/// BLoC: принимает событие FetchPosts и выдаёт состояния
/// Loading -> Loaded или Loading -> Error.
class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this._repository) : super(const PostInitial()) {
    on<FetchPosts>(_onFetchPosts);
  }

  final PostRepository _repository;

  Future<void> _onFetchPosts(
    FetchPosts event,
    Emitter<PostState> emit,
  ) async {
    emit(const PostLoading());
    try {
      final posts = await _repository.fetchPosts();
      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError('Failed to load posts: $e'));
    }
  }
}
