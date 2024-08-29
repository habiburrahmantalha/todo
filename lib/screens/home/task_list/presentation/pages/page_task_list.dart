import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/router/router.dart';
import 'package:todo/screens/home/task_list/data/repositories/repository_task_list_implementation.dart';
import 'package:todo/screens/home/task_list/presentation/blocs/task_list_bloc.dart';
import 'package:todo/screens/home/task_list/presentation/pages/page_task_view.dart';
import 'package:todo/widgets/empty_view.dart';
import 'package:todo/widgets/loading_indicator.dart';
import 'package:todo/widgets/raw_button.dart';

class PageTaskList extends StatefulWidget {
  const PageTaskList({super.key});

  @override
  State<PageTaskList> createState() => _PageTaskListState();
}

class _PageTaskListState extends State<PageTaskList> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (contexts) => TaskListBloc(repository: RepositoryTaskListImplementation())..add(GetTaskListEvent()),
      child: BlocBuilder<TaskListBloc, TaskListState>(
          builder: (context, state){
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Task"),
                  actions: [
                    RawButton(
                        color: Colors.transparent,
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.all(8),
                        child: const Row(
                          children: [
                            Text("Create"),
                            Icon(Icons.add)
                          ],
                        ),
                        onTap: (){
                          context.go(RouterPaths.taskCreate);

                        })
                  ],
                ),
                body: switch(state){
                  TaskInitial() => Container(),
                  TaskLoading() => const LoadingIndicator(),
                  TaskLoaded() => const PageTaskView(),
                  TaskError() => EmptyView(
                    title: "Something went wrong, please try again",
                    button: RawButton(
                      padding: const EdgeInsets.all(12),
                        child: const Center(child: Text("Reload")),
                        onTap: (){
                        context.read<TaskListBloc>().add(GetTaskListEvent());
                        }),
                  ),
                }
            );
          }
      ),
    );
  }
}




