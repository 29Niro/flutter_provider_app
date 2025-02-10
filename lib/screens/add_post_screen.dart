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
      appBar: AppBar(
        title: Text("Add Post"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            SizedBox(height: 20), 
            TextField(
              controller: bodyController,
              maxLines: 3, 
              decoration: InputDecoration(
                labelText: "Body",
                floatingLabelBehavior:
                    FloatingLabelBehavior.always, 
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ), 
                filled: true,
                fillColor: Colors.grey[200], 
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14), 
              ),
            ),
            SizedBox(height: 30), 
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple, 
                foregroundColor: Colors.white, 
                padding: EdgeInsets.symmetric(
                    horizontal: 24, vertical: 14), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ), 
                elevation: 2,
              ),
              child: Text(
                "Add Post",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
