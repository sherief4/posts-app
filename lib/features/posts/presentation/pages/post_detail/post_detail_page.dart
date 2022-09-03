import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_bloc.dart';
import 'package:posts_app/features/posts/presentation/pages/add_update_post/add_update_post_page.dart';
import 'package:posts_app/features/posts/presentation/pages/post_detail/widgets/deleteDialogWidget.dart';
import 'package:posts_app/features/posts/presentation/pages/posts/posts_page.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              height: 50.0,
            ),
            Text(
              post.body,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const Divider(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddUpdatePostPage(
                            isUpdatePost: true,
                            post: post,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit')),
                ElevatedButton.icon(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.red,
                    ),
                  ),
                  onPressed: () {
                    deleteDialog(context: context, postId: post.id!);
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  deleteDialog({required BuildContext context, required int postId}) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeleteUpdateBLoc, AddDeleteUpdatePostState>(
              listener: (context, state) {
            if (state is AddDeleteUpdateSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const PostsPage()),
                  (route) => false);
            } else if (state is AddDeleteUpdateErrorState) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }
          }, builder: (context, state) {
            if (state is AddDeleteUpdateLoadingState) {
              return const AlertDialog(
                title: LoadingWidget(),
              );
            }
            return DeleteDialogWidget(postId: postId);
          });
        });
  }
}
