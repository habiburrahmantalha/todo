part of 'task_progress_bloc.dart';

sealed class TaskProgressEvent extends Equatable {
  const TaskProgressEvent();
}

class UpdateTaskStatusEvent extends TaskProgressEvent {
  final TaskStatus status;
  const UpdateTaskStatusEvent(this.status);

  @override
  List<Object> get props => [];
}

class DeleteTaskEvent extends TaskProgressEvent {
  const DeleteTaskEvent();

  @override
  List<Object> get props => [];
}

class ResetTaskUpdateStatusEvent extends TaskProgressEvent {
  const ResetTaskUpdateStatusEvent();

  @override
  List<Object> get props => [];
}

class GetLocalTaskEvent extends TaskProgressEvent {
  const GetLocalTaskEvent();

  @override
  List<Object> get props => [];
}

class StartTaskEvent extends TaskProgressEvent {
  const StartTaskEvent();

  @override
  List<Object> get props => [];
}

class StopTaskEvent extends TaskProgressEvent {
  const StopTaskEvent();

  @override
  List<Object> get props => [];
}

class TimerStartEvent extends TaskProgressEvent {
  final int value;
  const TimerStartEvent(this.value);

  @override
  List<Object> get props => [value];
}

class TimerTickEvent extends TaskProgressEvent {
  final int value;
  const TimerTickEvent(this.value);

  @override
  List<Object> get props => [value];
}

class TimerStopEvent extends TaskProgressEvent {
  const TimerStopEvent();

  @override
  List<Object> get props => [];
}
