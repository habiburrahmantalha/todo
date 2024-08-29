import 'package:dio/dio.dart';
import 'package:todo/core/network/api_endpoint.dart';
import 'package:todo/core/network/dio_singleton.dart';
import 'package:todo/screens/home/task_list/data/models/task.dart';
import 'package:todo/screens/task_create/data/models/comment.dart';
import 'package:todo/screens/task_create/data/models/request_comment_create.dart';
import 'package:todo/screens/task_create/data/models/request_task_create.dart';

import 'repository_task.dart';

class RepositoryTaskImplementation implements RepositoryTask {

  @override
  Future<Task> createTask(RequestTaskCreate request) async {
    Response response = await postHttp(ApiEndpoint.task, data: request.toJson());
    return Task.fromJson(response.data);
  }

  @override
  Future<Task> updateTask(String id, RequestTaskCreate request) async {
    Response response = await postHttp(ApiEndpoint.editTask(id), data: request.toJson());
    return Task.fromJson(response.data);
  }

  @override
  Future<void> deleteTask(String id) async {
    await deleteHttp(ApiEndpoint.editTask(id));
    return;
  }

  @override
  Future<List<Comment>> getCommentListByTask(String? taskId) async {
    Response response = await getHttp(ApiEndpoint.getCommentListByTask(taskId));
    List<Comment> list = [];
    if (response.data != null) {
      response.data.forEach((v) {
        list.add(Comment.fromJson(v));
      });
    }
    return list;
  }

  @override
  Future<Comment> createComment(RequestCommentCreate request) async {
    Response response = await postHttp(ApiEndpoint.createComment, data: request.toJson());
    return Comment.fromJson(response.data);
  }

  @override
  Future<void> deleteComment(String id) async {
    await deleteHttp(ApiEndpoint.editComment(id));
    return;
  }
}