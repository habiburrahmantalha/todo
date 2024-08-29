part of 'task_list_bloc.dart';

@immutable
sealed class TaskListEvent {}

class GetTaskListEvent extends TaskListEvent{}
