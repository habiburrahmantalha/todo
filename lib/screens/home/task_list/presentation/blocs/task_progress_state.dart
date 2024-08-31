part of 'task_progress_bloc.dart';

class TaskProgressState extends Equatable {

  final TaskDB? taskDB;
  final bool isStarted;
  final int duration;
  final LoadingStatus status;


  const TaskProgressState({
    this.taskDB,
    this.isStarted = false,
    this.duration = 0,
    this.status = LoadingStatus.initial,
  });

  @override
  List<Object?> get props => [taskDB, isStarted, duration, status];

  TaskProgressState copyWith({
    TaskDB? taskDB,
    bool? isStarted,
    int? duration,
    LoadingStatus? status,
  }) {
    return TaskProgressState(
      taskDB: taskDB ?? this.taskDB,
      isStarted: isStarted ?? this.isStarted,
      duration: duration ?? this.duration,
      status: status ?? this.status,
    );
  }
}


