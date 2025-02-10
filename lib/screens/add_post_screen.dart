import 'package:flutter/material.dart';
import '../models/post_model.dart';

class AddPostScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Post")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title")),
            TextField(
                controller: bodyController,
                decoration: InputDecoration(labelText: "Body")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newPost = Post(
                    id: 0,
                    title: titleController.text,
                    body: bodyController.text);
                print("Added: ${newPost.title}");
                Navigator.pop(context);
              },
              child: Text("Add Post"),
            ),
          ],
        ),
      ),
    );
  }
}
