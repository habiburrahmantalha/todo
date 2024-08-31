

import 'package:todo/screens/home/task_list/data/models/task_model.dart';
import 'package:todo/screens/task/data/models/comment.dart';
import 'package:todo/screens/task/data/models/request_comment.dart';
import 'package:todo/screens/task/data/models/request_task.dart';

abstract interface class RepositoryTask {
  Future<TaskModel> createTask(RequestTask request);
  Future<TaskModel> updateTask(String id, RequestTask request);
  Future<void> deleteTask(String id);

  Future<List<Comment>> getCommentListByTask(String? taskId);
  Future<Comment> createComment(RequestComment request);
  Future<void> deleteComment(String id);
}