import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

class AddPostUseCase {
  AddPostUseCase({required this.repository});

  final PostsRepository repository;

  Future<Either<Failure, Unit>> call({required Post post}) async {
    return await repository.addPost(post: post);
  }
}
