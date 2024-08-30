
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/constants/enums.dart';
import 'package:todo/core/utils/utils.dart';
import 'package:todo/screens/task_create/data/models/comment.dart';
import 'package:todo/screens/task_create/data/models/request_comment.dart';
import 'package:todo/screens/task_create/data/models/request_task.dart';
import 'package:todo/screens/task_create/data/repositories/repository_task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {

  final RepositoryTask repository;
  TaskBloc({required this.repository}) : super(const TaskState()) {
    on<TaskEvent>((event, emit) async {
      switch(event){
        case SetTitleEvent():
          emit(state.copyWith(title: event.value));
        case SetDescriptionEvent():
          emit(state.copyWith(description: event.value));
        case SetDateEvent():
          emit(state.copyWith(date: event.value));
        case SetStatusEvent():
          emit(state.copyWith(taskStatus: event.value));
        case CreateTaskEvent():
          emit(state.copyWith(statusTaskCreate: LoadingStatus.loading));
          try {
            await repository.createTask(RequestTask(
              content: state.title,
              description: state.description,
              dueDatetime: state.date?.toIso8601String(),
              labels: [state.taskStatus?.value ?? TaskStatus.todo.value]
            ));
            emit(state.copyWith(statusTaskCreate: LoadingStatus.success));
          }
          catch(e){
            printDebug("CreateTaskEvent $e");
            emit(state.copyWith(statusTaskCreate: LoadingStatus.failed));
          }

        case UpdateTaskEvent():
          emit(state.copyWith(statusTaskCreate: LoadingStatus.loading));
          try {
            await repository.createTask(RequestTask(
              content: state.title,
              description: state.description,
              dueDatetime: state.date?.toIso8601String(),
              labels: [state.taskStatus?.value ?? TaskStatus.todo.value]
            ));
            emit(state.copyWith(statusTaskCreate: LoadingStatus.success));
          }
          catch(e){
            printDebug("UpdateTaskEvent $e");
            emit(state.copyWith(statusTaskCreate: LoadingStatus.failed));
          }
        case AddTaskCommentEvent():
          try {
            await repository.createComment(RequestComment(
              taskId: event.id,
              content: event.value,
            ));
            add(GetCommentListEvent(event.id));
          }
          catch(e){
            printDebug("AddTaskCommentEvent $e");
          }
        case DeleteTaskCommentEvent():
          try {
            await repository.deleteComment(event.commentId);
            add(GetCommentListEvent(event.taskId));
          }
          catch(e){
            printDebug("DeleteTaskCommentEvent $e");
          }
        case DeleteTaskEvent():
          emit(state.copyWith(statusTaskDelete: LoadingStatus.loading));
          try {
            await repository.deleteTask(event.taskId);
            emit(state.copyWith(statusTaskDelete: LoadingStatus.success));
          }
          catch(e){
            printDebug("DeleteTaskEvent $e");
            emit(state.copyWith(statusTaskDelete: LoadingStatus.failed));
          }
        case GetCommentListEvent():
          emit(state.copyWith(statusCommentList: LoadingStatus.loading));
          try {
            List<Comment> list = await repository.getCommentListByTask(event.id);
            emit(state.copyWith(commentList: list, currentTime: DateTime.now().millisecond, statusCommentList: LoadingStatus.success));
          }
          catch(e){
            printDebug("GetCommentListEvent $e");
            emit(state.copyWith(statusCommentList: LoadingStatus.failed));
          }
      }
    });
  }
}
