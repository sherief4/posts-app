import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/themes/app_theme.dart';
import 'package:posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_app/features/posts/presentation/pages/posts/posts_page.dart';
import 'core/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
          BlocProvider(create: (_) => di.sl<AddDeleteUpdateBLoc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Posts App',
          theme: appTheme,
          home: const PostsPage(),
        ));
  }
}
