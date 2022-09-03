import 'package:flutter/material.dart';
import 'package:posts_app/core/themes/app_theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: Center(
        child: SizedBox(
          height: 30.0,
          width: 30.0,
          child: CircularProgressIndicator(
            color: secondaryColor,
          ),
        ),
      ),
    );
  }
}
