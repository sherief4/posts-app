part  of 'posts_bloc.dart';
abstract class PostsState extends Equatable{
  const PostsState();

  @override
  List<Object>  get props => [];

}
class PostInitial extends PostsState{}

class LoadingPostsState extends PostsState{}

class LoadedPostsState extends  PostsState{
  const LoadedPostsState({required this.posts});
  final List<Post> posts;
  @override
  List<Object>  get props => [posts];
}
class  ErrorPostState extends PostsState{
  const ErrorPostState({required this.error});
  final String error;
  @override
  List<Object>  get props => [error];
}