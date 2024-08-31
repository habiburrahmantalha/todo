import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/enums.dart';
import 'package:todo/core/utils/extensions.dart';
import 'package:todo/core/utils/utils.dart';
import 'package:todo/router/router.dart';
import 'package:todo/screens/home/task_list/data/repositories/repository_task_progress_implementation.dart';
import 'package:todo/screens/home/task_list/domain/entities/task.dart';
import 'package:todo/screens/home/task_list/presentation/blocs/task_list_cubit.dart';
import 'package:todo/screens/home/task_list/presentation/blocs/task_progress_bloc.dart';
import 'package:todo/widgets/bottom_sheet_button.dart';
import 'package:todo/widgets/loading_indicator.dart';
import 'package:todo/widgets/raw_button.dart';
import 'package:url_launcher/url_launcher.dart';


class TaskCardView extends StatelessWidget {
  const TaskCardView({super.key, required this.task});

  final Task task;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskProgressBloc(repository: RepositoryTaskProgressImplementation(), task: task)
        ..add(const GetLocalTaskEvent()),
      child: BlocConsumer<TaskProgressBloc, TaskProgressState>(
        listenWhen: (prev, current){
          return prev.status != current.status;
        },
        listener: (context, state){
          if(state.status.isSuccess){
            showOkToast(context.tr("task_updated"), type: ToastType.success);
            //context.read<TaskProgressBloc>().add(const ResetTaskUpdateStatusEvent());
            context.read<TaskListCubit>().getTaskList();
          }
          else if(state.status.isFailed){
            showOkToast(context.tr("task_update_failed"), type: ToastType.error);
            context.read<TaskProgressBloc>().add(const ResetTaskUpdateStatusEvent());
          }
        },
        builder: (context, state) {
          printDebug("timer ${state.duration}");
          return BlocBuilder<TaskListCubit, TaskListState>(
            builder: (context, stateTaskList) {
              return RawButton(
                onTap: (){
                  context.go(RouterPaths.taskDetailsPath, extra: task.copyWith(duration: (state.taskDB?.duration ?? 0) + state.duration));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 12,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(task.dueDate != null)
                              Text("${context.tr("due_date")}: ${task.dueDate?.toddMMMyyyy() ?? ""}", style: Theme.of(context).textTheme.bodySmall),
                            if((state.taskDB?.duration ?? 0) + state.duration > 0)
                              Text("${context.tr("spent")}: ${state.isStarted ?  formatDuration((state.taskDB?.duration ?? 0) + state.duration) :
                              formatDuration(state.taskDB?.duration ?? 0)}", style: Theme.of(context).textTheme.bodySmall),

                          ],
                        ),
                        const Spacer(),
                        state.status.isLoading || (state.status.isSuccess && stateTaskList.status.isLoading)? const Padding(
                          padding: EdgeInsets.all(12),
                          child: LoadingIndicator(),
                        ): Row(
                          children: [
                            if(task.status != TaskStatus.done)
                              RawButton(
                                  padding: const EdgeInsets.all(12),
                                  child: Icon( state.isStarted ?  Icons.stop_circle_outlined: Icons.play_arrow_outlined,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                  onTap: (){
                                    if(state.isStarted) {
                                      context.read<TaskProgressBloc>().add(const StopTaskEvent());
                                    }else{
                                      if(task.status == TaskStatus.todo){
                                        context.read<TaskProgressBloc>().add(const UpdateTaskStatusEvent(TaskStatus.inProgress));
                                      }
                                      context.read<TaskProgressBloc>().add(const StartTaskEvent());
                                    }
                                  }
                              ),
                            RawButton(
                                padding: const EdgeInsets.all(12),
                                child: Icon( Icons.check,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                onTap: (){
                                  context.read<TaskProgressBloc>().add(const UpdateTaskStatusEvent(TaskStatus.done));
                                  // if(state.isStarted) {
                                  //   context.read<TaskProgressCubit>().endTask();
                                  // }else{
                                  //   if(task.status == TaskStatus.todo){
                                  //     context.read<TaskListBloc>().add(UpdateTaskStatusEvent(task, TaskStatus.inProgress));
                                  //   }
                                  //   context.read<TaskProgressCubit>().startTask();
                                  // }
                                }
                            ),
                            RawButton(
                                color: Colors.transparent,
                                padding: const EdgeInsets.all(12),
                                child: FaIcon(FontAwesomeIcons.ellipsisVertical, color: Theme.of(context).iconTheme.color, size: 18,),
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
                                              }, label: context.tr("add_to_google_calender"), icon: Icons.calendar_month,),

                                            if(task.status == TaskStatus.todo || task.status == TaskStatus.done)
                                              BottomSheetButton(
                                                color: Colors.indigo[400],
                                                onTap: (){
                                                  Navigator.pop(context);
                                                  context.read<TaskProgressBloc>().add(const UpdateTaskStatusEvent(TaskStatus.inProgress));
                                                }, label: context.tr("move_to_in_progress"), icon: Icons.play_arrow_outlined,),
                                            if(task.status == TaskStatus.todo || task.status == TaskStatus.inProgress)
                                              BottomSheetButton(onTap: (){
                                                Navigator.pop(context);
                                                context.read<TaskProgressBloc>().add(const UpdateTaskStatusEvent( TaskStatus.done));
                                              }, label: context.tr("move_to_done"), icon: Icons.check,),
                                            if(task.status == TaskStatus.inProgress || task.status == TaskStatus.done)
                                              BottomSheetButton(
                                                color: Colors.brown[400],
                                                onTap: (){
                                                  Navigator.pop(context);
                                                  context.read<TaskProgressBloc>().add( const UpdateTaskStatusEvent( TaskStatus.todo));
                                                }, label: context.tr("move_to_to_do"), icon: Icons.pending_actions,),

                                            BottomSheetButton(
                                              color: Colors.blueGrey[400],
                                              onTap: (){
                                                Navigator.pop(context);
                                                context.go(RouterPaths.taskUpdatePathFromHome, extra: task);
                                              },
                                              label: context.tr("edit"), icon: Icons.edit,),

                                            BottomSheetButton(
                                              color: Theme.of(context).colorScheme.onError,
                                              onTap: (){
                                                Navigator.pop(context);
                                                context.read<TaskProgressBloc>().add( const DeleteTaskEvent());
                                              },
                                              label: context.tr("delete"), icon: Icons.delete,),

                                            const SizedBox(height: 24,),
                                          ],
                                        ),
                                      )
                                  );
                                }),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(task.content, style: Theme.of(context).textTheme.titleMedium,),
                    ),
                    const SizedBox(height: 4,),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text((task.description ?? ""), style: Theme.of(context).textTheme.bodyLarge),
                    ),
                    const SizedBox(height: 12,)
                  ],
                ),
              );
            },
          );
        },
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