part of 'task_bloc.dart';

class TaskState extends Equatable {

  final String? title;
  final String? description;
  //final DateTime? date;
  final TaskStatus? taskStatus;
  final LoadingStatus? statusTaskCreate;
  final LoadingStatus? statusTaskUpdate;
  final LoadingStatus? statusCommentList;
  final LoadingStatus? statusTaskDelete;
  final List<Comment>? commentList;
  final int? currentTime;

  @override
  List<Object?> get props =>
      [
        title,
        description,
        //date,
        taskStatus,
        statusTaskCreate,
        statusTaskUpdate,
        statusCommentList,
        statusTaskDelete,
        commentList,
        currentTime,
      ];

  const TaskState({
    this.title,
    this.description,
    //this.date,
    this.taskStatus,
    this.statusTaskCreate,
    this.statusTaskUpdate,
    this.statusCommentList,
    this.statusTaskDelete,
    this.commentList,
    this.currentTime,
  });

  TaskState copyWith({
    String? title,
    String? description,
    DateTime? date,
    TaskStatus? taskStatus,
    LoadingStatus? statusTaskCreate,
    LoadingStatus? statusTaskUpdate,
    LoadingStatus? statusCommentList,
    LoadingStatus? statusTaskDelete,
    List<Comment>? commentList,
    int? currentTime,
  }) {
    return TaskState(
      title: title ?? this.title,
      description: description ?? this.description,
      //date: date ?? this.date,
      taskStatus: taskStatus ?? this.taskStatus,
      statusTaskCreate: statusTaskCreate ?? this.statusTaskCreate,
      statusTaskUpdate: statusTaskUpdate ?? this.statusTaskUpdate,
      statusCommentList: statusCommentList ?? this.statusCommentList,
      statusTaskDelete: statusTaskDelete ?? this.statusTaskDelete,
      commentList: commentList ?? this.commentList,
      currentTime: currentTime ?? this.currentTime,
    );
  }
}


