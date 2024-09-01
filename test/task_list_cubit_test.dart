import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/core/constants/enums.dart';
import 'package:todo/screens/home/task_list/domain/entities/task.dart';
import 'package:todo/screens/home/task_list/domain/repositories/repository_task_list.dart';
import 'package:todo/screens/home/task_list/presentation/blocs/task_list_cubit.dart';


class MockRepositoryTaskList extends Mock implements RepositoryTaskList {}

void main() {
  late MockRepositoryTaskList mockRepositoryTaskList;
  late TaskListCubit taskListCubit;

  setUp(() {
    mockRepositoryTaskList = MockRepositoryTaskList();
    taskListCubit = TaskListCubit(repository: mockRepositoryTaskList);
  });

  tearDown(() {
    taskListCubit.close();
  });

  group('TaskListCubit', () {
    final List<Task> mockTasks = [
      const Task(id: '1', content: 'Task 1', status: TaskStatus.todo),
      const Task(id: '2', content: 'Task 2', status: TaskStatus.inProgress),
      const Task(id: '3', content: 'Task 3', status: TaskStatus.done),
    ];

    blocTest<TaskListCubit, TaskListState>(
      'emits [loading, success] when getTaskList is successful',
      build: () {
        when(() => mockRepositoryTaskList.getTaskList())
            .thenAnswer((_) async => mockTasks);
        return taskListCubit;
      },
      act: (cubit) => cubit.getTaskList(),
      expect: () => [
        const TaskListState(status: LoadingStatus.loading),
        TaskListState(
          listTodo: [mockTasks[0]],
          listInProgress: [mockTasks[1]],
          listDone: [mockTasks[2]],
          status: LoadingStatus.success,
        ),
      ],
    );

    blocTest<TaskListCubit, TaskListState>(
      'emits [loading, failed] when getTaskList fails',
      build: () {
        when(() => mockRepositoryTaskList.getTaskList())
            .thenThrow(Exception('Failed to load tasks'));
        return taskListCubit;
      },
      act: (cubit) => cubit.getTaskList(),
      expect: () => [
        const TaskListState(status: LoadingStatus.loading),
        const TaskListState(status: LoadingStatus.failed),
      ],
    );
  });
}
