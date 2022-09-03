import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  const DeleteDialogWidget({Key? key, required this.postId}) : super(key: key);
  final int postId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<AddDeleteUpdateBLoc>(context)
                .add(DeletePostEvent(postId: postId));
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
