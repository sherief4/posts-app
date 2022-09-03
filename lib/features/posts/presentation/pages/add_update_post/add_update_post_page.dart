import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_bloc.dart';
import 'package:posts_app/features/posts/presentation/pages/add_update_post/widgets/form_widget.dart';
import 'package:posts_app/features/posts/presentation/pages/posts/posts_page.dart';

class AddUpdatePostPage extends StatelessWidget {
  const AddUpdatePostPage({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);
  final Post? post;
  final bool isUpdatePost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdatePost ? 'Edit Post' : 'Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          10.0,
        ),
        child: BlocConsumer<AddDeleteUpdateBLoc, AddDeleteUpdatePostState>(
          listener: (context, state) {
            if (state is AddDeleteUpdateSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const PostsPage(),
                  ),
                  (route) => false);
            }
            if (state is AddDeleteUpdateErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AddDeleteUpdateLoadingState) {
              return const LoadingWidget();
            }
            return FormWidget(
                isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
          },
        ),
      ),
    );
  }
}
