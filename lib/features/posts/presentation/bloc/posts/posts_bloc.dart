import 'package:equatable/equatable.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/core/strings/failures.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:bloc/bloc.dart';
import 'package:posts_app/features/posts/domain/usecases/get_all_posts.dart';

part 'posts_event.dart';

part 'posts_states.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;

  PostsBloc({required this.getAllPosts}) : super(PostInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts();
        failureOrPosts.fold((l) {
          emit(ErrorPostState(error: _mapFailureToString(l)));
        }, (r) {
          emit(LoadedPostsState(posts: r));
        });
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts();
        failureOrPosts.fold((l) {
          emit(ErrorPostState(error: _mapFailureToString(l)));
        }, (r) {
          emit(LoadedPostsState(posts: r));
        });
      }
    });
  }

  String _mapFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ApiFailure:
        return API_FAILURE_MESSAGE;

      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;

      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;

      default:
        return "Unexpected failure, please try again later";
    }
  }
}
