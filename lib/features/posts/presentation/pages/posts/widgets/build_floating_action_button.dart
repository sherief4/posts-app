import 'package:flutter/material.dart';

class BuildFloatingActionButton extends StatelessWidget {
  const BuildFloatingActionButton({Key? key, required this.onPressed})
      : super(key: key);
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}
