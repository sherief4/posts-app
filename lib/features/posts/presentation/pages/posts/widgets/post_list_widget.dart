import 'package:flutter/material.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/presentation/pages/post_detail/post_detail_page.dart';

class PostListWidget extends StatelessWidget {
  const PostListWidget({Key? key, required this.posts}) : super(key: key);
  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(posts[index].id.toString()),
            title: Text(
              posts[index].title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              posts[index].body,
              style: const TextStyle(fontSize: 16.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PostDetailPage(post: posts[index])));
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 1,
          );
        },
        itemCount: posts.length);
  }
}
