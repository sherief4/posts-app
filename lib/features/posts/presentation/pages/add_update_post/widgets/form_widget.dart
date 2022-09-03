import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_bloc.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key, required this.isUpdatePost, this.post})
      : super(key: key);
  final bool isUpdatePost;
  final Post? post;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  void validateFormThenSubmit() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      final Post post = Post(
        id: widget.isUpdatePost ? widget.post!.id : null,
        title: titleController.text,
        body: bodyController.text,
      );
      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdateBLoc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdateBLoc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            child: TextFormField(
              controller: titleController,
              validator: (val) =>
                  val!.isEmpty ? 'Title can\'t be empty' : null,
              decoration: const InputDecoration(hintText: 'title'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            child: TextFormField(
              controller: bodyController,
              validator: (val) =>
                  val!.isEmpty ? 'Body can\'t be empty' : null,
              minLines: 6,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: 'body',
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              validateFormThenSubmit();
            },
            icon: widget.isUpdatePost
                ? const Icon(Icons.edit)
                : const Icon(Icons.add),
            label: Text(widget.isUpdatePost ? 'Update' : 'Add'),
          ),
        ],
      ),
    );
  }
}
