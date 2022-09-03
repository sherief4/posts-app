part of 'add_delete_update_bloc.dart';

abstract class AddDeleteUpdatePostEvent extends Equatable {
  const AddDeleteUpdatePostEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddDeleteUpdatePostEvent {
  const AddPostEvent({required this.post});

  final Post post;

  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends AddDeleteUpdatePostEvent {
  const UpdatePostEvent({required this.post});

  final Post post;

  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends AddDeleteUpdatePostEvent {
  const DeletePostEvent({required this.postId});

  final int postId;

  @override
  List<Object> get props => [postId];
}
