import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/assets.dart';
import 'package:todo/screens/home/task_list/domain/entities/task.dart';
import 'package:todo/screens/home/task_list/presentation/blocs/task_list_cubit.dart';
import 'package:todo/screens/home/task_list/presentation/widgets/task_card_view.dart';
import 'package:todo/widgets/empty_view.dart';
import 'package:todo/widgets/raw_button.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key, required this.list});

  final List<Task> list;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: Column(
          children: [
            Expanded(
                child: list.isEmpty ? EmptyView(
                  title: context.tr("task_not_found"),
                  description: context.tr("add_a_task"),
                  button: RawButton(
                      padding: const EdgeInsets.all(12),
                      child: Center(child: Text(context.tr("create_task"), style: Theme.of(context).textTheme.titleMedium)),
                      onTap: (){}
                  ),
                  image: Image.asset(Assets.imagesEmpty, height: 128,),
                ) :
                ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    itemBuilder: (context, index){
                      return TaskCardView(key: Key(list[index].id),task: list[index]);
                    },
                    separatorBuilder: (context, index){
                      return const SizedBox(height: 12,);
                    },
                    itemCount: list.length
                )
            )
          ],
        ),
        onRefresh: () async{
          context.read<TaskListCubit>().getTaskList();
        });
  }
}