import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/enums.dart';
import 'package:todo/core/utils/utils.dart';
import 'package:todo/router/router.dart';
import 'package:todo/screens/home/task_list/data/models/task.dart';
import 'package:todo/widgets/bottom_sheet_button.dart';
import 'package:todo/widgets/raw_button.dart';


class TaskCardView extends StatelessWidget {
  const TaskCardView({super.key, required this.task});

  final Task task;
  @override
  Widget build(BuildContext context) {
    return RawButton(
      padding: const EdgeInsets.all(12),
      onTap: (){
        context.go(RouterPaths.taskDetails(task.id ?? ""), extra: task);
      },
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.due?.date ?? "", style: Theme.of(context).textTheme.bodySmall),
              Text(task.content ?? "", style: Theme.of(context).textTheme.titleMedium,),
              Text(task.description ?? "", style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
          const Spacer(),
          RawButton(
              color: Colors.transparent,
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.all(8),
              child: const Row(
                children: [
                  FaIcon(FontAwesomeIcons.ellipsisVertical, color: Colors.grey, size: 18,)
                ],
              ),
              onTap: (){
                showCustomBottomSheet(
                    context,
                    isScrollControlled: true,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if(task.labels?.firstOrNull == TaskStatus.todo.value || task.labels?.firstOrNull == TaskStatus.done.value)
                            BottomSheetButton(onTap: (){
                              Navigator.pop(context);
                              //context.read<TaskBloc>().add(DeleteTaskCommentEvent(commentId: list[index].id ?? "", taskId: list[index].taskId ?? ""));
                            }, label: "Move To In Progress", icon: Icons.play_arrow_outlined,),
                          if(task.labels?.firstOrNull == TaskStatus.todo.value || task.labels?.firstOrNull == TaskStatus.inProgress.value)
                            BottomSheetButton(onTap: (){
                              Navigator.pop(context);
                              //context.read<TaskBloc>().add(DeleteTaskCommentEvent(commentId: list[index].id ?? "", taskId: list[index].taskId ?? ""));
                            }, label: "Move To Done", icon: Icons.check,),
                          if(task.labels?.firstOrNull == TaskStatus.inProgress.value || task.labels?.firstOrNull == TaskStatus.done.value)
                            BottomSheetButton(onTap: (){
                              Navigator.pop(context);
                              //context.read<TaskBloc>().add(DeleteTaskCommentEvent(commentId: list[index].id ?? "", taskId: list[index].taskId ?? ""));
                            }, label: "Move To To Do", icon: Icons.check,),
                          const SizedBox(height: 24,),
                        ],
                      ),
                    )
                );

              })
        ],
      ),
    );
  }
}