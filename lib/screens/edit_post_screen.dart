import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import '../providers/post_provider.dart';

class EditPostScreen extends StatelessWidget {
  final Post post;
  final TextEditingController titleController;
  final TextEditingController bodyController;

  EditPostScreen({super.key, required this.post})
      : titleController = TextEditingController(text: post.title),
        bodyController = TextEditingController(text: post.body);

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Edit Post")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(labelText: "Body"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final title = titleController.text.trim();
                final body = bodyController.text.trim();

                if (title.isEmpty || body.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Title and Body cannot be empty!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                final updatedPost = Post(id: post.id, title: title, body: body);

                try {
                  await postProvider.updatePost(updatedPost);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Post updated successfully!"),
                      backgroundColor: Colors.green,
                    ),
                  );

                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Failed to update post. Try again!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text("Update Post"),
            ),
          ],
        ),
      ),
    );
  }
}
