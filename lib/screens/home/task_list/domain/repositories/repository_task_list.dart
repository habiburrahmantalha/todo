import 'package:todo/screens/home/task_list/data/models/task_model.dart';
import 'package:todo/screens/home/task_list/domain/entities/task.dart';
import 'package:todo/screens/task_create/data/models/request_task.dart';

abstract interface class RepositoryTaskList {
  Future<List<Task>> getTaskList();
  Future<TaskModel> updateTaskStatus({required String id, required RequestTask request});
}