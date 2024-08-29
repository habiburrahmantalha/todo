part of 'task_bloc.dart';

class TaskState extends Equatable {

  final String? title;
  final String? description;
  final DateTime? date;
  final LoadingStatus? statusTaskCreate;
  final LoadingStatus? statusCommentList;
  final LoadingStatus? statusTaskDelete;
  final List<Comment>? commentList;
  final int? currentTime;

  @override
  List<Object?> get props =>
      [
        title,
        description,
        date,
        statusTaskCreate,
        statusCommentList,
        statusTaskDelete,
        commentList,
        currentTime,
      ];

  const TaskState({
    this.title,
    this.description,
    this.date,
    this.statusTaskCreate,
    this.statusCommentList,
    this.statusTaskDelete,
    this.commentList,
    this.currentTime,
  });

  TaskState copyWith({
    String? title,
    String? description,
    DateTime? date,
    LoadingStatus? statusTaskCreate,
    LoadingStatus? statusCommentList,
    LoadingStatus? statusTaskDelete,
    List<Comment>? commentList,
    int? currentTime,
  }) {
    return TaskState(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      statusTaskCreate: statusTaskCreate ?? this.statusTaskCreate,
      statusCommentList: statusCommentList ?? this.statusCommentList,
      statusTaskDelete: statusTaskDelete ?? this.statusTaskDelete,
      commentList: commentList ?? this.commentList,
      currentTime: currentTime ?? this.currentTime,
    );
  }
}


