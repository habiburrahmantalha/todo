import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/enums.dart';
import 'package:todo/core/utils/utils.dart';
import 'package:todo/router/router.dart';
import 'package:todo/screens/home/task_list/domain/entities/task.dart';
import 'package:todo/screens/home/task_list/presentation/blocs/task_list_bloc.dart';
import 'package:todo/widgets/bottom_sheet_button.dart';
import 'package:todo/widgets/raw_button.dart';
import 'package:url_launcher/url_launcher.dart';


class TaskCardView extends StatelessWidget {
  const TaskCardView({super.key, required this.task});

  final Task task;
  @override
  Widget build(BuildContext context) {
    return RawButton(
      padding: const EdgeInsets.all(12),
      onTap: (){
        context.go(RouterPaths.taskDetails(task.id), extra: task);
      },
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.dueDate?.toIso8601String() ?? "", style: Theme.of(context).textTheme.bodySmall),
              Text(task.content, style: Theme.of(context).textTheme.titleMedium,),
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
                          if(task.status == TaskStatus.todo || task.status == TaskStatus.inProgress)
                          BottomSheetButton(onTap: (){
                            Navigator.pop(context);
                            addEventToGoogleCalendar(task);
                          }, label: "Add to google Calender", icon: Icons.calendar_month,),

                          if(task.status == TaskStatus.todo || task.status == TaskStatus.done)
                            BottomSheetButton(onTap: (){
                              Navigator.pop(context);
                              context.read<TaskListBloc>().add(UpdateTaskStatusEvent(task, TaskStatus.inProgress));
                            }, label: "Move To In Progress", icon: Icons.play_arrow_outlined,),
                          if(task.status == TaskStatus.todo || task.status == TaskStatus.inProgress)
                            BottomSheetButton(onTap: (){
                              Navigator.pop(context);
                              context.read<TaskListBloc>().add(UpdateTaskStatusEvent(task, TaskStatus.done));
                            }, label: "Move To Done", icon: Icons.check,),
                          if(task.status == TaskStatus.inProgress || task.status == TaskStatus.done)
                            BottomSheetButton(onTap: (){
                              Navigator.pop(context);
                              context.read<TaskListBloc>().add(UpdateTaskStatusEvent(task, TaskStatus.todo));
                            }, label: "Move To To Do", icon: Icons.pending_actions,),
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

void addEventToGoogleCalendar(Task task) async {
  final Uri googleCalendarUrl = Uri(
    scheme: 'https',
    host: 'www.google.com',
    path: '/calendar/render',
    queryParameters: {
      'action': 'TEMPLATE',
      'text': task.content,
      'details': task.description,
    },
  );

  if (await canLaunchUrl(googleCalendarUrl)) {
    await launchUrl(googleCalendarUrl);
  } else {
    throw 'Could not launch $googleCalendarUrl';
  }
}