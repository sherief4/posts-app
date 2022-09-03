// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/exceptions.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost({required int id});

  Future<Unit> updatePost({required PostModel postModel});

  Future<Unit> addPost({required PostModel postModel});
}

const BASE_URL = "https://jsonplaceholder.typicode.com";

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse("$BASE_URL/posts/"),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodedJson.map<PostModel>((jsonPost) {
        return PostModel.fromJson(jsonPost);
      }).toList();

      return postModels;
    } else {
      throw ApiException();
    }
  }

  @override
  Future<Unit> addPost({required PostModel postModel}) async {
    final body = {
      "body": postModel.body,
      "title": postModel.title,
    };
    final response =
        await client.post(Uri.parse("$BASE_URL /posts/"), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ApiException();
    }
  }

  @override
  Future<Unit> deletePost({required int id}) async {
    final response = await client.delete(
        Uri.parse("$BASE_URL /posts/${id.toString()}"),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ApiException();
    }
  }

  @override
  Future<Unit> updatePost({required PostModel postModel}) async {
    final postId = postModel.id.toString();
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };
    final response =
        await client.patch(Uri.parse("$BASE_URL /posts/$postId"), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ApiException();
    }
  }
}
