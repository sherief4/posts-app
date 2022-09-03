import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/core/strings/failures.dart';
import 'package:posts_app/core/strings/messages.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/domain/usecases/add_post.dart';
import 'package:posts_app/features/posts/domain/usecases/delete_post.dart';
import 'package:posts_app/features/posts/domain/usecases/update_post.dart';

part 'add_delete_update_post_event.dart';

part 'add_delete_update_post_states.dart';

class AddDeleteUpdateBLoc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUseCase addPost;
  final DeletePostUseCase deletePost;
  final UpdatePostUseCase updatePost;

  AddDeleteUpdateBLoc({
    required this.addPost,
    required this.deletePost,
    required this.updatePost,
  }) : super(AddDeleteUpdateInitialState()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(AddDeleteUpdateLoadingState());
        final failureOrDone = await addPost(post: event.post);
        failureOrDone.fold((l) {
          emit(AddDeleteUpdateErrorState(message: _mapFailureToString(l)));
        }, (r) {
          emit(const AddDeleteUpdateSuccessState(
              message: UPDATE_SUCCESS_MESSAGE));
        });
      } else if (event is UpdatePostEvent) {
        emit(AddDeleteUpdateLoadingState());
        final failureOrDone = await updatePost(post: event.post);
        failureOrDone.fold((l) {
          emit(AddDeleteUpdateErrorState(message: _mapFailureToString(l)));
        }, (r) {
          emit(const AddDeleteUpdateSuccessState(message: ADD_SUCCESS_MESSAGE));
        });
      } else if (event is DeletePostEvent) {
        emit(AddDeleteUpdateLoadingState());
        final failureOrDone = await deletePost(event.postId);
        failureOrDone.fold((l) {
          emit(AddDeleteUpdateErrorState(message: _mapFailureToString(l)));
        }, (r) {
          emit(const AddDeleteUpdateSuccessState(
              message: DELETE_SUCCESS_MESSAGE));
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
