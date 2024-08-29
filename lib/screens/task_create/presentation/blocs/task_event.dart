part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();
}

class SetTitleEvent extends TaskEvent {
  final String value;

  const SetTitleEvent(this.value);

  @override
  List<Object> get props => [value];
}

class SetDescriptionEvent extends TaskEvent {
  final String value;

  const SetDescriptionEvent(this.value);

  @override
  List<Object> get props => [value];
}

class SetDateEvent extends TaskEvent {
  final DateTime value;

  const SetDateEvent(this.value);

  @override
  List<Object> get props => [value];
}

class CreateTaskEvent extends TaskEvent {

  const CreateTaskEvent();

  @override
  List<Object> get props => [];
}

class UpdateTaskEvent extends TaskEvent {

  const UpdateTaskEvent();

  @override
  List<Object> get props => [];
}

class AddTaskCommentEvent extends TaskEvent {
  final String id;
  final String value;

  const AddTaskCommentEvent({required this.id, required this.value});

  @override
  List<Object> get props => [id, value];
}

class DeleteTaskCommentEvent extends TaskEvent {
  final String commentId;
  final String taskId;

  const DeleteTaskCommentEvent({
    required this.commentId,
    required this.taskId,
  });

  @override
  List<Object> get props => [commentId, taskId];
}

class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  const DeleteTaskEvent(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class GetCommentListEvent extends TaskEvent {

  final String id;

  const GetCommentListEvent(this.id);

  @override
  List<Object> get props => [id];
}
