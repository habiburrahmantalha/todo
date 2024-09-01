part of 'task_progress_bloc.dart';

class TaskProgressState extends Equatable {

  final TaskDB? taskDB;
  final bool isStarted;
  final int duration;
  final LoadingStatus statusUpdate;
  final LoadingStatus statusDelete;


  const TaskProgressState({
    this.taskDB,
    this.isStarted = false,
    this.duration = 0,
    this.statusUpdate = LoadingStatus.initial,
    this.statusDelete = LoadingStatus.initial,
  });

  @override
  List<Object?> get props => [taskDB, isStarted, duration, statusUpdate, statusDelete];

  TaskProgressState copyWith({
    TaskDB? taskDB,
    bool? isStarted,
    int? duration,
    LoadingStatus? statusUpdate,
    LoadingStatus? statusDelete,
  }) {
    return TaskProgressState(
      taskDB: taskDB ?? this.taskDB,
      isStarted: isStarted ?? this.isStarted,
      duration: duration ?? this.duration,
      statusUpdate: statusUpdate ?? this.statusUpdate,
      statusDelete: statusDelete ?? this.statusDelete,
    );
  }
}


