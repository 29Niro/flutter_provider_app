import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';

class PostProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Post> _posts = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadPosts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _posts = await _apiService.fetchPosts();
      if (_posts.isEmpty) {
        _errorMessage = "No posts available";
      }
    } catch (e) {
      _posts = [];
      _errorMessage = "Network error. Please check your connection.";
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addPost(Post post) async {
    try {
      final newPost = await _apiService.addPost(post);
      _posts.insert(0, newPost);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to add post";
      notifyListeners();
    }
  }

  Future<void> updatePost(Post post) async {
    try {
      final updatedPost = await _apiService.updatePost(post);
      int index = _posts.indexWhere((p) => p.id == post.id);
      if (index != -1) {
        _posts[index] = updatedPost;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = "Failed to update post";
      notifyListeners();
    }
  }

  Future<void> deletePost(int id) async {
    try {
      await _apiService.deletePost(id);
      _posts.removeWhere((post) => post.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to delete post";
      notifyListeners();
    }
  }
}
