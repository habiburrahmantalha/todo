import 'package:todo/screens/home/task_list/data/models/task_model.dart';
import 'package:todo/screens/task/data/models/request_task.dart';

abstract interface class RepositoryTaskProgress {
  Future<TaskModel> updateTaskStatus({required String id, required RequestTask request});
  Future<void> deleteTask(String id);
}