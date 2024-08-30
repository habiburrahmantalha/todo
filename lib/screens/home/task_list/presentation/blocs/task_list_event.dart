part of 'task_list_bloc.dart';

@immutable
sealed class TaskListEvent extends Equatable {}

class GetTaskListEvent extends TaskListEvent {
  @override
  List<Object> get props => [];
}

class UpdateTaskStatusEvent extends TaskListEvent {

  final Task task;
  final TaskStatus status;

  UpdateTaskStatusEvent(this.task, this.status);

  @override
  List<Object> get props => [];
}
