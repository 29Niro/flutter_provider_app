import 'package:dio/dio.dart';
import '../models/post_model.dart';

class ApiService {
  final Dio _dio = Dio();
  final String baseUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await _dio.get(baseUrl);
      return (response.data as List)
          .map((json) => Post.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception("Failed to load posts");
    }
  }

  Future<Post> addPost(Post post) async {
    try {
      final response = await _dio.post(baseUrl, data: post.toJson());
      return Post.fromJson(response.data);
    } catch (e) {
      throw Exception("Failed to add post");
    }
  }

  Future<Post> updatePost(Post post) async {
    try {
      final response =
          await _dio.put("$baseUrl/${post.id}", data: post.toJson());
      return Post.fromJson(response.data);
    } catch (e) {
      throw Exception("Failed to update post");
    }
  }

  Future<void> deletePost(int id) async {
    try {
      await _dio.delete("$baseUrl/$id");
    } catch (e) {
      throw Exception("Failed to delete post");
    }
  }
}
