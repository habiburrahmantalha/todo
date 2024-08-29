import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/screens/home/presentation/screens/screen_home.dart';
import 'package:todo/screens/home/task_list/data/models/task.dart';
import 'package:todo/screens/task_create/data/repositories/repository_task_implementation.dart';
import 'package:todo/screens/task_create/presentation/blocs/task_bloc.dart';
import 'package:todo/screens/task_create/presentation/screens/screen_task_create.dart';
import 'package:todo/screens/task_create/presentation/screens/screen_task_details.dart';

class RouterPaths {
  static const String home = ScreenHome.routeName;
  static String taskCreate = "/${ScreenTaskCreate.routeName}";
  static String taskEdit(String id) => "/${ScreenTaskDetails.routeName}/$id/${ScreenTaskCreate.routeName}";
  static String taskDetails(String id) => "/${ScreenTaskDetails.routeName}/$id";
}

final List<GoRoute> routes = [
  GoRoute(
      path: ScreenHome.routeName,
      builder: (context, state) => const ScreenHome(),
      routes: [
        GoRoute(
          path: ScreenTaskCreate.routeName,
          builder: (context, state) => BlocProvider(
            create: (context) => TaskBloc(repository: RepositoryTaskImplementation()),
            child: const ScreenTaskCreate(),
          ),
        ),
        GoRoute(
            path: "${ScreenTaskDetails.routeName}/:id",
            builder: (context, state) => BlocProvider(
              create: (context) => TaskBloc(repository: RepositoryTaskImplementation()),
              child: ScreenTaskDetails(task: state.extra as Task?,),
            ),
            routes: [
              GoRoute(
                path: ScreenTaskCreate.routeName,
                builder: (context, state) => BlocProvider(
                  create: (context) => TaskBloc(repository: RepositoryTaskImplementation()),
                  child: ScreenTaskCreate(task: state.extra as Task?,),
                ),
              ),
            ]
        ),
      ]
  ),
];
