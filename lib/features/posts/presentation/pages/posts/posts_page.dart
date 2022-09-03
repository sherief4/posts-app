import 'package:flutter/material.dart';
import 'package:posts_app/features/posts/presentation/pages/add_update_post/add_update_post_page.dart';
import 'package:posts_app/features/posts/presentation/pages/posts/widgets/build_body.dart';
import 'package:posts_app/features/posts/presentation/pages/posts/widgets/build_floating_action_button.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts App'),
      ),
      body: const BuildBody(),
      floatingActionButton: BuildFloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  const AddUpdatePostPage(isUpdatePost: false)));
        },
      ),
    );
  }
}
