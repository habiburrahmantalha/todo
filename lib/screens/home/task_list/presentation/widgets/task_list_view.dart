import 'package:flutter/material.dart';
import 'package:todo/generated/assets.dart';
import 'package:todo/screens/home/task_list/data/models/task.dart';
import 'package:todo/screens/home/task_list/presentation/widgets/task_card_view.dart';
import 'package:todo/widgets/empty_view.dart';
import 'package:todo/widgets/raw_button.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key, required this.list});

  final List<Task> list;

  @override
  Widget build(BuildContext context) {
    return list.isEmpty ?
    EmptyView(
      title: "Task not found",
      description: "Add some task",
      button: RawButton(
          padding: const EdgeInsets.all(12),
          child: Center(child: Text("Create Task", style: Theme.of(context).textTheme.titleMedium)),
          onTap: (){}
      ),
      image: Image.asset(Assets.imagesEmpty),
    ) :
    ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        itemBuilder: (context, index){
          return TaskCardView(task: list[index]);
        },
        separatorBuilder: (context, index){
          return const SizedBox(height: 12,);
        },
        itemCount: list.length
    );
  }
}