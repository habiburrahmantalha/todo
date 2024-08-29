part of 'task_list_bloc.dart';

@immutable
sealed class TaskListState {}

final class TaskInitial extends TaskListState {}
final class TaskLoading extends TaskListState {}
final class TaskLoaded extends TaskListState {
  final List<Task> listTodo;
  final List<Task> listInProgress;
  final List<Task> listDone;

  TaskLoaded({
    required this.listTodo,
    required this.listInProgress,
    required this.listDone,
  });
}
final class TaskError extends TaskListState {}
