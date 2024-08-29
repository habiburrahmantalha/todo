

import 'package:todo/screens/home/task_list/data/models/task.dart';
import 'package:todo/screens/task_create/data/models/comment.dart';
import 'package:todo/screens/task_create/data/models/request_comment_create.dart';
import 'package:todo/screens/task_create/data/models/request_task_create.dart';

abstract interface class RepositoryTask {
  Future<Task> createTask(RequestTaskCreate request);
  Future<Task> updateTask(String id, RequestTaskCreate request);
  Future<void> deleteTask(String id);

  Future<List<Comment>> getCommentListByTask(String? taskId);
  Future<Comment> createComment(RequestCommentCreate request);
  Future<void> deleteComment(String id);
}