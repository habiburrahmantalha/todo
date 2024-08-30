import 'package:dio/dio.dart';
import 'package:todo/core/network/api_endpoint.dart';
import 'package:todo/core/network/dio_singleton.dart';
import 'package:todo/screens/home/task_list/data/models/task_model.dart';
import 'package:todo/screens/home/task_list/domain/entities/task.dart';
import 'package:todo/screens/home/task_list/domain/repositories/repository_task_list.dart';
import 'package:todo/screens/task_create/data/models/request_task.dart';


class RepositoryTaskListImplementation implements RepositoryTaskList {

  @override
  Future<List<Task>> getTaskList() async {
    Response response = await getHttp(ApiEndpoint.task);
    List<Task> list = [];
    if (response.data != null) {
      response.data.forEach((v) {
        list.add(TaskModel.fromJson(v).toEntity());
      });
    }
    return list;
  }

  @override
  Future<TaskModel> updateTaskStatus( {required String id, required RequestTask request}) async {
    Response response = await postHttp(ApiEndpoint.editTask(id), data: request.toJson());
    return TaskModel.fromJson(response.data);
  }

}