import 'package:dio/dio.dart';
import 'package:todo/core/network/api_endpoint.dart';
import 'package:todo/core/network/dio_singleton.dart';
import 'package:todo/screens/home/task_list/data/models/task_model.dart';
import 'package:todo/screens/task/data/models/comment.dart';
import 'package:todo/screens/task/data/models/request_comment.dart';
import 'package:todo/screens/task/data/models/request_task.dart';

import '../../domain/repositories/repository_task.dart';

class RepositoryTaskImplementation implements RepositoryTask {

  @override
  Future<TaskModel> createTask(RequestTask request) async {
    Response response = await postHttp(ApiEndpoint.task, data: request.toJson());
    return TaskModel.fromJson(response.data);
  }

  @override
  Future<TaskModel> updateTask(String id, RequestTask request) async {
    Response response = await postHttp(ApiEndpoint.editTask(id), data: request.toJson());
    return TaskModel.fromJson(response.data);
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
  Future<Comment> createComment(RequestComment request) async {
    Response response = await postHttp(ApiEndpoint.createComment, data: request.toJson());
    return Comment.fromJson(response.data);
  }

  @override
  Future<void> deleteComment(String id) async {
    await deleteHttp(ApiEndpoint.editComment(id));
    return;
  }
}