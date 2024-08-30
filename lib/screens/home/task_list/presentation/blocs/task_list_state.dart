part of 'task_list_bloc.dart';

class TaskListState extends Equatable {
  final List<Task>? listTodo;
  final List<Task>? listInProgress;
  final List<Task>? listDone;
  final LoadingStatus status;
  final int? currentTime;

  const TaskListState({
    this.listTodo,
    this.listInProgress,
    this.listDone,
    this.status = LoadingStatus.initial,
    this.currentTime
  });

  @override
  List<Object?> get props => [listTodo, listInProgress, listDone, status, currentTime];

  TaskListState copyWith({
    List<Task>? listTodo,
    List<Task>? listInProgress,
    List<Task>? listDone,
    LoadingStatus? status,
    int? currentTime,
  }) {
    return TaskListState(
      listTodo: listTodo ?? this.listTodo,
      listInProgress: listInProgress ?? this.listInProgress,
      listDone: listDone ?? this.listDone,
      status: status ?? this.status,
      currentTime: currentTime ?? this.currentTime,
    );
  }
}
