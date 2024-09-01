import 'package:easy_localization/easy_localization.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/constants/enums.dart';
import 'package:todo/core/resource/resource.dart';
import 'package:todo/core/utils/utils.dart';
import 'package:todo/screens/home/task_list/presentation/blocs/task_list_cubit.dart';
import 'package:todo/screens/home/task_list/presentation/widgets/task_list_view.dart';


class PageTaskView extends StatefulWidget {
  const PageTaskView({super.key});

  @override
  State<PageTaskView> createState() => _PageTaskViewState();
}

class _PageTaskViewState extends State<PageTaskView> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {

  @override
  bool get wantKeepAlive => true;

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);

    FBroadcast.instance().register(R.string.switchTab, (value, __){

      TaskStatus? status = value["index"] as TaskStatus?;
      printDebug("FBroadcast $value ${status?.value}");
      switch(status){
        case TaskStatus.todo:
          tabController.animateTo(0);
        case TaskStatus.inProgress:
          tabController.animateTo(1);
        case TaskStatus.done:
          tabController.animateTo(2);
        case null:
          tabController.animateTo(0);
      }
    }, context: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TaskListCubit, TaskListState>(
      builder: (context, state) {
        return Column(
          children: [
            TabBar(
                controller: tabController,
                isScrollable: true,
                tabs: [
                  Tab(text: context.tr("to_do")),
                  Tab(text: context.tr("in_progress")),
                  Tab(text: context.tr("done")),
                ]),
            Expanded(
              child: TabBarView(
                  controller: tabController,
                  children: [
                    TaskListView(list: state.listTodo ?? []),
                    TaskListView(list: state.listInProgress ?? []),
                    TaskListView(list: state.listDone ?? [])
                  ]),
            ),
          ],
        );
      },
    );
  }
}