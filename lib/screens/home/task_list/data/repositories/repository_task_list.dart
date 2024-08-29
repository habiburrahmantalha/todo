import 'package:todo/screens/home/task_list/data/models/task.dart';

abstract interface class RepositoryTaskList {
  Future<List<Task>> getTaskList();
}