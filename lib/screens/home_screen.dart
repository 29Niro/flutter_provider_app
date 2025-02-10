import 'package:flutter/material.dart';
import '../models/post_model.dart';
import 'add_post_screen.dart';
import 'edit_post_screen.dart';
import '../widgets/post_card.dart';

class HomeScreen extends StatelessWidget {
  final List<Post> posts = [
    Post(id: 1, title: "First Post", body: "This is the first post."),
    Post(id: 2, title: "Second Post", body: "This is the second post."),
    Post(id: 3, title: "Third Post", body: "This is the third post."),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter CRUD App")),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
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
              // Hardcoded delete functionality (later use Provider)
              print("Deleted Post ID: ${post.id}");
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPostScreen()),
          );
        },
      ),
    );
  }
}
