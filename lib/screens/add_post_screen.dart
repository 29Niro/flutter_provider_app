import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import '../providers/post_provider.dart';

class AddPostScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Add Post")),
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

                final newPost = Post(id: 0, title: title, body: body);

                try {
                  await postProvider.addPost(newPost);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Post added successfully!"),
                      backgroundColor: Colors.green,
                    ),
                  );

                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Failed to add post. Try again!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text("Add Post"),
            ),
          ],
        ),
      ),
    );
  }
}
