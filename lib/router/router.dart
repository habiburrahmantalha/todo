import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/screens/home/presentation/screens/screen_home.dart';
import 'package:todo/screens/home/task_list/data/repositories/repository_task_list_implementation.dart';
import 'package:todo/screens/home/task_list/domain/entities/task.dart';
import 'package:todo/screens/home/task_list/presentation/blocs/task_list_cubit.dart';
import 'package:todo/screens/task/data/repositories/repository_task_implementation.dart';
import 'package:todo/screens/task/presentation/blocs/task_bloc.dart';
import 'package:todo/screens/task/presentation/screens/screen_task_create.dart';
import 'package:todo/screens/task/presentation/screens/screen_task_details.dart';

class RouterPaths {
  static String taskCreatePath = "/${ScreenTaskCreate.routeName}";

  static String taskUpdatePathFromDetails = "/${ScreenTaskDetails.routeName}/${ScreenTaskCreate.routeName}";
  static String taskUpdatePathFromHome = "/${ScreenTaskCreate.routeName}";

  static String taskDetailsPath = "/${ScreenTaskDetails.routeName}";
}

final List<GoRoute> routes = [
  GoRoute(
      path: ScreenHome.routeName,
      builder: (context, state) => BlocProvider(
        create: (contexts) => TaskListCubit(repository: RepositoryTaskListImplementation())..getTaskList(),
        child: const ScreenHome(),
      ),
      routes: [
        GoRoute(
            path: ScreenTaskDetails.routeName,
            builder: (context, state) => BlocProvider(
              create: (context) => TaskBloc(repository: RepositoryTaskImplementation()),
              child: ScreenTaskDetails(task: state.extra as Task?,),
            ),
          routes: [
            GoRoute(
              path: ScreenTaskCreate.routeName,
              builder: (context, state) => BlocProvider(
                create: (context) => TaskBloc(repository: RepositoryTaskImplementation()),
                child: ScreenTaskCreate(task: state.extra as Task?),
              ),
            ),
          ]
        ),
        GoRoute(
          path: ScreenTaskCreate.routeName,
          builder: (context, state) => BlocProvider(
            create: (context) => TaskBloc(repository: RepositoryTaskImplementation()),
            child: ScreenTaskCreate(task: state.extra as Task?),
          ),
        ),
      ],
  ),
];
