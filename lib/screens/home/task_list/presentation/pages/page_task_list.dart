import 'package:easy_localization/easy_localization.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/enums.dart';
import 'package:todo/core/resource/resource.dart';
import 'package:todo/router/router.dart';
import 'package:todo/screens/home/task_list/presentation/blocs/task_list_cubit.dart';
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
  void initState() {
    super.initState();

    FBroadcast.instance().register(R.string.reloadTask, (_, __){
      reloadTaskList();
    }, context: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TaskListCubit, TaskListState>(
        builder: (context, state){
          return Scaffold(
              appBar: AppBar(
                title: Text(context.tr("task")),
                actions: [
                  RawButton(
                      color: Colors.transparent,
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Text(context.tr("create")),
                          Icon(Icons.add, color: Theme.of(context).iconTheme.color)
                        ],
                      ),
                      onTap: ()=> context.go(RouterPaths.taskCreatePath)
                  )
                ],
              ),
              body: state.status == LoadingStatus.failed ? EmptyView(
                title: context.tr("something_went_wrong_please_try_again"),
                button:RawButton(
                    padding: const EdgeInsets.all(12),
                    child: Center(child: Text(context.tr("reload_task"), style: Theme.of(context).textTheme.titleMedium)),
                    onTap: (){
                      context.read<TaskListCubit>().getTaskList();
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
    context.read<TaskListCubit>().getTaskList();
  }
}




