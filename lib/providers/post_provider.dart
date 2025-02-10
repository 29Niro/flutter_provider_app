import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';

class PostProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Post> _posts = [];
  bool _isLoading = false;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;

  Future<void> loadPosts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _posts = await _apiService.fetchPosts();
    } catch (e) {
      _posts = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addPost(Post post) async {
    final newPost = await _apiService.addPost(post);
    _posts.insert(0, newPost);
    notifyListeners();
  }

  Future<void> updatePost(Post post) async {
    final updatedPost = await _apiService.updatePost(post);
    int index = _posts.indexWhere((p) => p.id == post.id);
    if (index != -1) {
      _posts[index] = updatedPost;
      notifyListeners();
    }
  }

  Future<void> deletePost(int id) async {
    await _apiService.deletePost(id);
    _posts.removeWhere((post) => post.id == id);
    notifyListeners();
  }
}
