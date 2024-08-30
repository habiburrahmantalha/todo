import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/constants/enums.dart';
import 'package:todo/core/utils/utils.dart';
import 'package:todo/screens/home/task_list/domain/entities/task.dart';
import 'package:todo/screens/home/task_list/domain/repositories/repository_task_list.dart';
import 'package:todo/screens/task_create/data/models/request_task.dart';

part 'task_list_event.dart';
part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {

  final RepositoryTaskList repository;
  TaskListBloc({required this.repository}) : super(const TaskListState()) {
    on<TaskListEvent>((event, emit) async {
      switch(event){
        case GetTaskListEvent():
          if(true){
            emit(state.copyWith(status: LoadingStatus.loading));
            try{
              List<Task> response = await repository.getTaskList();
              List<Task> listTodo = [];
              List<Task> listInProgress = [];
              List<Task> listDone = [];

              for (var e in response) {
                if(e.status == TaskStatus.todo){
                  listTodo.add(e);
                }else if(e.status == TaskStatus.inProgress){
                  listInProgress.add(e);
                }else if(e.status == TaskStatus.done){
                  listDone.add(e);
                }
              }

              emit(state.copyWith(
                  listTodo: listTodo,
                  listInProgress: listInProgress,
                  listDone: listDone,
                  status: LoadingStatus.success,
                  currentTime: DateTime.now().millisecond
              ));
            }
            catch(error){
              printDebug("GetTaskListEvent - $error");
              emit(state.copyWith(status: LoadingStatus.failed));
            }
          }
        case UpdateTaskStatusEvent():
          RequestTask request = RequestTask(
              labels: [event.status.value]
          );
          await repository.updateTaskStatus(id: event.task.id, request: request);
          add(GetTaskListEvent());
      }
    });
  }
}
