import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/enums.dart';
import 'package:todo/core/utils/extensions.dart';
import 'package:todo/core/utils/utils.dart';
import 'package:todo/router/router.dart';
import 'package:todo/screens/home/task_list/domain/entities/task.dart';

class TaskDetailsView extends StatelessWidget {
  const TaskDetailsView({super.key, required this.task});
  final Task task;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        context.go(RouterPaths.taskUpdatePathFromDetails, extra: task);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(task.status == TaskStatus.done)
            Text(context.tr("completed_on"), style: Theme.of(context).textTheme.titleSmall,),
          if(task.status == TaskStatus.done)
            Text(task.dueDate?.toddMMMyyyy() ?? "", style: Theme.of(context).textTheme.bodySmall),
          Text(context.tr("created_on"), style: Theme.of(context).textTheme.titleSmall,),
          Text(task.createdAt?.toddMMMyyyy() ?? "", style: Theme.of(context).textTheme.bodySmall),
          const Divider(),
          Text(context.tr("title"), style: Theme.of(context).textTheme.titleSmall,),
          Text((task.content), style: Theme.of(context).textTheme.titleMedium,),
          const SizedBox(height: 12,),
          Text(context.tr("description"), style: Theme.of(context).textTheme.titleSmall,),
          Text((task.description ?? ""), style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 12,),
          Text(context.tr("status"), style: Theme.of(context).textTheme.titleSmall,),
          Text(task.status.title, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 12,),
          Text(context.tr("spent_time"), style: Theme.of(context).textTheme.titleSmall,),
          Text(formatDuration(task.duration ?? 0), style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}