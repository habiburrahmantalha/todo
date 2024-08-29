import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/constants/enums.dart';
import 'package:todo/core/utils/utils.dart';
import 'package:todo/screens/home/task_list/data/models/task.dart';
import 'package:todo/screens/home/task_list/data/repositories/repository_task_list.dart';

part 'task_list_event.dart';
part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {

  final RepositoryTaskList repository;
  TaskListBloc({required this.repository}) : super(TaskInitial()) {
    on<TaskListEvent>((event, emit) async {
      switch(event){
        case GetTaskListEvent():
          if(true){
            emit(TaskLoading());
            try{
              List<Task> response = await repository.getTaskList();
              List<Task> listTodo = [];
              List<Task> listInProgress = [];
              List<Task> listDone = [];

              for (var e in response) {
                if(e.labels?.first == TaskStatus.todo.value){
                  listTodo.add(e);
                }else if(e.labels?.first == TaskStatus.todo.value){
                  listInProgress.add(e);
                }else if(e.labels?.first == TaskStatus.todo.value){
                  listDone.add(e);
                }
              }

              emit(TaskLoaded(listTodo: listTodo, listInProgress: listInProgress, listDone: listDone));
            }
            catch(error){
              printDebug("GetTaskListEvent - $error");
              emit(TaskError());
            }
          }
      }
    });
  }
}
