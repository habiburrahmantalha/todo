import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/constants/enums.dart';
import 'package:todo/core/utils/utils.dart';
import 'package:todo/screens/home/task_list/domain/entities/task.dart';
import 'package:todo/screens/home/task_list/domain/repositories/repository_task_list.dart';

part 'task_list_state.dart';


class TaskListCubit extends Cubit<TaskListState> {
  TaskListCubit({required this.repository}) : super(const TaskListState());
  final RepositoryTaskList repository;
  getTaskList() async {

      emit(state.copyWith(status: LoadingStatus.loading));
      try{
        List<Task> list = await repository.getTaskList();
        List<Task> listTodo = [];
        List<Task> listInProgress = [];
        List<Task> listDone = [];

        for (Task e in list) {
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
          //currentTime: DateTime.now().millisecond
        ));
      }
      catch(error){
        printDebug("GetTaskListEvent - $error");
        emit(state.copyWith(status: LoadingStatus.failed));
      }

  }
}
