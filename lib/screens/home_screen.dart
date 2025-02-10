import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';
import 'add_post_screen.dart';
import 'edit_post_screen.dart';
import '../widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _itemsPerPage = 10;
  int _currentPage = 1;
  final ScrollController _scrollController = ScrollController();

  void _showDeleteConfirmation(BuildContext context, int postId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Post"),
          content: Text("Are you sure you want to delete this post?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Provider.of<PostProvider>(context, listen: false)
                    .deletePost(postId);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Post deleted successfully!"),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  List<dynamic> _getPaginatedPosts(List<dynamic> allPosts) {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    return allPosts.sublist(
        startIndex, endIndex > allPosts.length ? allPosts.length : endIndex);
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<PostProvider>(context, listen: false).loadPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter Provider App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Consumer<PostProvider>(
        builder: (context, postProvider, child) {
          if (postProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          final totalPosts = postProvider.posts.length;
          final totalPages = (totalPosts / _itemsPerPage).ceil();
          final currentPagePosts = _getPaginatedPosts(postProvider.posts);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: currentPagePosts.length,
                  itemBuilder: (context, index) {
                    final post = currentPagePosts[index];
                    return PostCard(
                      post: post,
                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPostScreen(post: post),
                          ),
                        );
                      },
                      onDelete: () {
                        _showDeleteConfirmation(context, post.id);
                      },
                    );
                  },
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.first_page,
                          color:
                              _currentPage > 1 ? Colors.purple : Colors.grey),
                      onPressed: _currentPage > 1
                          ? () {
                              setState(() => _currentPage = 1);
                              _scrollToTop();
                            }
                          : null,
                    ),
                    IconButton(
                      icon: Icon(Icons.chevron_left,
                          color:
                              _currentPage > 1 ? Colors.purple : Colors.grey),
                      onPressed: _currentPage > 1
                          ? () {
                              setState(() => _currentPage--);
                              _scrollToTop();
                            }
                          : null,
                    ),
                    Text('Page $_currentPage of $totalPages'),
                    IconButton(
                      icon: Icon(Icons.chevron_right,
                          color: _currentPage < totalPages
                              ? Colors.purple
                              : Colors.grey),
                      onPressed: _currentPage < totalPages
                          ? () {
                              setState(() => _currentPage++);
                              _scrollToTop();
                            }
                          : null,
                    ),
                    IconButton(
                      icon: Icon(Icons.last_page,
                          color: _currentPage < totalPages
                              ? Colors.purple
                              : Colors.grey),
                      onPressed: _currentPage < totalPages
                          ? () {
                              setState(() => _currentPage = totalPages);
                              _scrollToTop();
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: Colors.purple,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPostScreen()),
            );
          },
        ),
      ),
    );
  }
}
