import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/exceptions.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/features/posts/data/datasources/local_data_source.dart';
import 'package:posts_app/features/posts/data/datasources/remote_data_source.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

class PostsRepositoryImpl extends PostsRepository {
  PostsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        await localDataSource.cachePosts(posts: remotePosts);
        return Right(remotePosts);
      } on ApiException {
        return Left(ApiFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost({required Post post}) async {
    final PostModel postModel = PostModel(
      title: post.title,
      body: post.body,
    );
    return await _getMessage(() {
      return remoteDataSource.addPost(postModel: postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost({required int id}) async {
    return await _getMessage(() {
      return remoteDataSource.deletePost(id: id);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost({required Post post}) async {
    final PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return await _getMessage(() {
      return remoteDataSource.updatePost(postModel: postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      Future<Unit> Function() function) async {
    if (await networkInfo.isConnected) {
      try {
        function();
        return const Right(unit);
      } on ApiException {
        return Left(ApiFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
