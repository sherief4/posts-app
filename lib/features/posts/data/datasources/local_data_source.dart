// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/exceptions.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<List<PostModel>> getCachedPosts();

  Future<Unit> cachePosts({required List<PostModel> posts});
}
const CACHED_POSTS =  'CACHED_POSTS';
class LocalDataSourceImpl implements LocalDataSource {
  LocalDataSourceImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<Unit> cachePosts({required List<PostModel> posts}) {
    List postModelToJson = posts
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_POSTS, json.encode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
