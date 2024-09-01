
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/constants/enums.dart';
import 'package:todo/core/database/database_helper.dart';
import 'package:todo/core/database/task_db_model.dart';
import 'package:todo/core/utils/utils.dart';
import 'package:todo/screens/home/task_list/domain/entities/task.dart';
import 'package:todo/screens/home/task_list/domain/repositories/repository_task_progress.dart';
import 'package:todo/screens/task/data/models/request_task.dart';

part 'task_progress_event.dart';
part 'task_progress_state.dart';

class TaskProgressBloc extends Bloc<TaskProgressEvent, TaskProgressState> {
  final RepositoryTaskProgress repository;
  final Task task;

  TaskProgressBloc({required this.repository, required this.task}) : super(const TaskProgressState()) {
    on<TaskProgressEvent>((event, emit) async {
      switch(event){

        case UpdateTaskStatusEvent():
          emit(state.copyWith(statusUpdate: LoadingStatus.loading));
          if(event.status == TaskStatus.todo || event.status == TaskStatus.done) {
            _timer?.cancel();
            String startDate = state.taskDB?.startTime ?? "";
            int seconds = DateTime.now().difference(DateTime.tryParse(startDate) ??  DateTime.now()).inSeconds;
            TaskDB updatedTaskDb = TaskDB(taskId: task.id, startTime: "", duration: seconds + (state.taskDB?.duration ?? 0));
            await DatabaseHelper().updateTask(updatedTaskDb);
          }

          TaskDB? taskDB = await DatabaseHelper().getTaskById(task.id);
          String startDate = taskDB?.startTime ?? "";
          int seconds = DateTime.now().difference(DateTime.tryParse(startDate) ??  DateTime.now()).inSeconds;
          int duration = (taskDB?.duration ?? 0) + seconds;

          RequestTask request = RequestTask(
              labels: [event.status.value],
              duration: duration > 0 ? duration : null,
              durationUnit: duration > 0 ? "minute" : null,
              updatedAt: DateTime.now().toIso8601String(),
          );
          try {
            await repository.updateTaskStatus(id: task.id, request: request);
            emit(state.copyWith(statusUpdate: LoadingStatus.success));
          }
          catch(e){
            printDebug("UpdateTaskStatusEvent $e");
            emit(state.copyWith(statusUpdate: LoadingStatus.failed));
          }
        case DeleteTaskEvent():
          emit(state.copyWith(statusDelete: LoadingStatus.loading));
          try {
            await repository.deleteTask(task.id);
            emit(state.copyWith(statusDelete: LoadingStatus.success));
          }
          catch(e){
            printDebug("DeleteTaskEvent $e");
            emit(state.copyWith(statusDelete: LoadingStatus.failed));
          }
        case ResetTaskUpdateStatusEvent():
          emit(state.copyWith(statusDelete: LoadingStatus.initial, statusUpdate: LoadingStatus.initial));
        case GetLocalTaskEvent():
          try {
            TaskDB? taskDB = await DatabaseHelper().getTaskById(task.id);
            if (taskDB == null) {
              taskDB = TaskDB(taskId: task.id, duration: task.duration ?? 0, startTime: "");
              try {
                await DatabaseHelper().insertTask(taskDB);
              } catch (e) {
                printDebug("insertTask $e");
              }
            }
            printDebug(taskDB.toMap());
            emit(state.copyWith(taskDB: taskDB, isStarted: taskDB.startTime.isNotEmpty));
            if(taskDB.startTime.isNotEmpty){
              String startDate = taskDB.startTime;
              int seconds = DateTime.now().difference(DateTime.tryParse(startDate) ??  DateTime.now()).inSeconds;
              add(TimerStartEvent(seconds));
            }
          }catch(e){
            printDebug("getTaskById $e");
          }
        case StartTaskEvent():
          if(state.taskDB != null){
            TaskDB updatedTaskDb = TaskDB(startTime: DateTime.now().toIso8601String(), duration: state.taskDB?.duration ?? 0, taskId: task.id);
            try {
              await DatabaseHelper().updateTask(updatedTaskDb);
            }catch(e){
              printDebug("updateTask $e");
            }
            emit(state.copyWith(taskDB: updatedTaskDb, isStarted: true));
            add(const TimerStartEvent(0));
          }
        case StopTaskEvent():
          String startDate = state.taskDB?.startTime ?? "";
          int seconds = DateTime.now().difference(DateTime.tryParse(startDate) ??  DateTime.now()).inSeconds;
          TaskDB updatedTaskDb = TaskDB(taskId: task.id, startTime: "", duration: seconds + (state.taskDB?.duration ?? 0));
          try {
            await DatabaseHelper().updateTask(updatedTaskDb);
          }catch(e){
            printDebug("updateTask $e");
          }
          emit(state.copyWith(taskDB: updatedTaskDb, isStarted: false));
          add(const TimerStopEvent());
        case TimerStartEvent():
          _timer?.cancel(); // Cancel any existing timer
          _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
              if(!isClosed){
                add(TimerTickEvent(event.value + timer.tick + 1));
              }
            },
          );
        case TimerTickEvent():
          if (!isClosed) {
            emit(state.copyWith(duration: event.value));
          }
        case TimerStopEvent():
          _timer?.cancel();
          if (!isClosed) {
            emit(state.copyWith(duration: 0));
          }

      }
    });
  }

  Timer? _timer;

}
