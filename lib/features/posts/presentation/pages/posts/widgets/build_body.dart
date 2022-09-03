import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_app/features/posts/presentation/pages/add_update_post/widgets/message_display_widget.dart';
import 'package:posts_app/features/posts/presentation/pages/posts/widgets/post_list_widget.dart';

class BuildBody extends StatelessWidget {
  const BuildBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        10.0,
      ),
      child: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
        if (state is LoadingPostsState) {
          return const LoadingWidget();
        } else if (state is LoadedPostsState) {
          return RefreshIndicator(
            onRefresh: ()=>_onRefresh(context),
            child: PostListWidget(posts: state.posts),
          );
        } else if (state is ErrorPostState) {
          return MessageDisplayWidget(
            message: state.error,
          );
        }
        return const LoadingWidget();
      }),
    );
  }

  Future <void>_onRefresh(BuildContext context)async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }
}
