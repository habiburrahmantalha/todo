import 'package:dio/dio.dart';
import 'package:todo/core/network/api_endpoint.dart';
import 'package:todo/core/network/dio_singleton.dart';
import 'package:todo/screens/home/task_list/data/models/task_model.dart';
import 'package:todo/screens/home/task_list/domain/repositories/repository_task_progress.dart';
import 'package:todo/screens/task/data/models/request_task.dart';


class RepositoryTaskProgressImplementation implements RepositoryTaskProgress {

  @override
  Future<TaskModel> updateTaskStatus( {required String id, required RequestTask request}) async {
    Response response = await postHttp(ApiEndpoint.editTask(id), data: request.toJson());
    return TaskModel.fromJson(response.data);
  }

  @override
  Future<void> deleteTask(String id) async {
    await deleteHttp(ApiEndpoint.editTask(id));
    return;
  }

}