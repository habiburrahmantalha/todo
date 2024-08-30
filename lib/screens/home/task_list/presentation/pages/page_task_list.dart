import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/enums.dart';
import 'package:todo/screens/home/task_list/presentation/blocs/task_list_bloc.dart';
import 'package:todo/screens/home/task_list/presentation/pages/page_task_view.dart';
import 'package:todo/screens/task_create/presentation/screens/screen_task_create.dart';
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
    return BlocBuilder<TaskListBloc, TaskListState>(
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
                      onTap: ()=> context.pushNamed(ScreenTaskCreate.routeName).then((value){
                        if( (value as bool?) == true){
                            reloadTaskList();
                        }
                      }))
                ],
              ),
              body: state.status == LoadingStatus.failed ? EmptyView(
                title: "Something went wrong,\n Please try again",
                button:RawButton(
                    padding: const EdgeInsets.all(12),
                    child: Center(child: Text("Reload Task", style: Theme.of(context).textTheme.titleMedium)),
                    onTap: (){
                      context.read<TaskListBloc>().add(GetTaskListEvent());
                    }
                ),
              ) :
              state.listTodo == null && state.status.isLoading == true ?
              const LoadingIndicator() :
              const PageTaskView()
          );
        }
    );
  }

  reloadTaskList(){
    if (!mounted) return;
    context.read<TaskListBloc>().add(GetTaskListEvent());
  }
}




