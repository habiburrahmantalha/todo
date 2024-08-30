import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/screens/home/task_list/presentation/blocs/task_list_bloc.dart';
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
    return BlocBuilder<TaskListBloc, TaskListState>(
      builder: (context, state) {
        return DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(text: 'TO DO'),
                      Tab(text: 'IN PROGRESS'),
                      Tab(text: 'DONE'),
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