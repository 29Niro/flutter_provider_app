import 'package:flutter/material.dart';
import '../models/post_model.dart';

class EditPostScreen extends StatelessWidget {
  final Post post;
  final TextEditingController titleController;
  final TextEditingController bodyController;

  EditPostScreen({super.key, required this.post})
      : titleController = TextEditingController(text: post.title),
        bodyController = TextEditingController(text: post.body);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Post")),
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
                print("Updated: ${titleController.text}");
                Navigator.pop(context);
              },
              child: Text("Update Post"),
            ),
          ],
        ),
      ),
    );
  }
}
