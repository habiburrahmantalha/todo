import 'package:dio/dio.dart';
import 'package:todo/core/network/api_endpoint.dart';
import 'package:todo/core/network/dio_singleton.dart';
import 'package:todo/screens/home/task_list/data/models/task.dart';
import 'package:todo/screens/home/task_list/data/repositories/repository_task_list.dart';


class RepositoryTaskListImplementation implements RepositoryTaskList {

  @override
  Future<List<Task>> getTaskList() async {
    Response response = await getHttp(ApiEndpoint.task);
    List<Task> list = [];
    if (response.data != null) {
      response.data.forEach((v) {
        list.add(Task.fromJson(v));
      });
    }
    return list;
  }
}