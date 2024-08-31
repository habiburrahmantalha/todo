import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/screens/home/task_list/presentation/blocs/task_list_cubit.dart';
import 'package:todo/screens/home/task_list/presentation/widgets/task_list_view.dart';


class PageTaskView extends StatefulWidget {
  const PageTaskView({super.key});

  @override
  State<PageTaskView> createState() => _PageTaskViewState();
}

class _PageTaskViewState extends State<PageTaskView> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TaskListCubit, TaskListState>(
      builder: (context, state) {
        return DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(text: context.tr("to_do")),
                      Tab(text: context.tr("in_progress")),
                      Tab(text: context.tr("done")),
                    ]),
                Expanded(
                  child: TabBarView(children: [
                    TaskListView(list: state.listTodo ?? []),
                    TaskListView(list: state.listInProgress ?? []),
                    TaskListView(list: state.listDone ?? [])
                  ]),
                ),
              ],
            )
        );
      },
    );
  }
}