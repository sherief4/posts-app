part of 'add_delete_update_bloc.dart';

abstract class AddDeleteUpdatePostState extends Equatable {
  const AddDeleteUpdatePostState();

  @override
  List<Object> get props => [];
}

class AddDeleteUpdateInitialState extends AddDeleteUpdatePostState {}

class AddDeleteUpdateLoadingState extends AddDeleteUpdatePostState {}

class AddDeleteUpdateErrorState extends AddDeleteUpdatePostState {
  const AddDeleteUpdateErrorState({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class AddDeleteUpdateSuccessState extends AddDeleteUpdatePostState {
  const AddDeleteUpdateSuccessState({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
