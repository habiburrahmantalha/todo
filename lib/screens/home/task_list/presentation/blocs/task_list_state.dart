part of 'task_list_cubit.dart';

class TaskListState extends Equatable {
  final List<Task>? listTodo;
  final List<Task>? listInProgress;
  final List<Task>? listDone;
  final LoadingStatus status;



  const TaskListState({
    this.listTodo,
    this.listInProgress,
    this.listDone,
    this.status = LoadingStatus.initial,
  });

  @override
  List<Object?> get props => [listTodo, listInProgress, listDone, status];

  TaskListState copyWith({
    List<Task>? listTodo,
    List<Task>? listInProgress,
    List<Task>? listDone,
    LoadingStatus? status,
  }) {
    return TaskListState(
      listTodo: listTodo ?? this.listTodo,
      listInProgress: listInProgress ?? this.listInProgress,
      listDone: listDone ?? this.listDone,
      status: status ?? this.status,
    );
  }
}
