import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/core/constants/enums.dart';
import 'package:todo/screens/home/task_list/data/models/task_model.dart';
import 'package:todo/screens/task/data/models/request_comment.dart';
import 'package:todo/screens/task/data/models/request_task.dart';
import 'package:todo/screens/task/domain/entities/entity_comment.dart';
import 'package:todo/screens/task/domain/repositories/repository_task.dart';
import 'package:todo/screens/task/presentation/blocs/task_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


// Mock classes
class MockRepositoryTask extends Mock implements RepositoryTask {}

// Create dummy instances for fallback registration
class FakeRequestTask extends Fake implements RequestTask {}

class FakeRequestComment extends Fake implements RequestComment {}

void main() {
  late TaskBloc taskBloc;
  late MockRepositoryTask mockRepository;

  // Register fallback values for custom types
  setUpAll(() {
    // Initialize FFI
    sqfliteFfiInit();

    // Set the global database factory to use FFI (important for testing with sqflite_common_ffi)
    databaseFactory = databaseFactoryFfi;
    registerFallbackValue(FakeRequestTask());
    registerFallbackValue(FakeRequestComment());
  });

  setUp(() {
    mockRepository = MockRepositoryTask();
    taskBloc = TaskBloc(repository: mockRepository);
  });

  tearDown(() {
    taskBloc.close();
  });

  group('TaskBloc Tests', () {
    test('initial state is TaskState', () {
      expect(taskBloc.state, equals(const TaskState()));
    });

    blocTest<TaskBloc, TaskState>(
      'emits [TaskState] with updated title when SetTitleEvent is added',
      build: () => taskBloc,
      act: (bloc) => bloc.add(const SetTitleEvent('New Title')),
      expect: () => [const TaskState(title: 'New Title')],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [TaskState] with updated description when SetDescriptionEvent is added',
      build: () => taskBloc,
      act: (bloc) => bloc.add(const SetDescriptionEvent('New Description')),
      expect: () => [const TaskState(description: 'New Description')],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [LoadingStatus.loading, LoadingStatus.success] when CreateTaskEvent is added',
      build: () {
        when(() => mockRepository.createTask(any())).thenAnswer((_) async => TaskModel());
        return taskBloc;
      },
      act: (bloc) => bloc.add(const CreateTaskEvent()),
      expect: () => [
        const TaskState(statusTaskCreate: LoadingStatus.loading),
        const TaskState(statusTaskCreate: LoadingStatus.success),
      ],
      verify: (_) {
        verify(() => mockRepository.createTask(any())).called(1);
      },
    );

    blocTest<TaskBloc, TaskState>(
      'emits [LoadingStatus.loading, LoadingStatus.failed] when CreateTaskEvent fails',
      build: () {
        when(() => mockRepository.createTask(any())).thenThrow(Exception('Failed to create task'));
        return taskBloc;
      },
      act: (bloc) => bloc.add(const CreateTaskEvent()),
      expect: () => [
        const TaskState(statusTaskCreate: LoadingStatus.loading),
        const TaskState(statusTaskCreate: LoadingStatus.failed),
      ],
    );

    // blocTest<TaskBloc, TaskState>(
    //   'emits [LoadingStatus.loading, LoadingStatus.success] when UpdateTaskEvent is added',
    //   build: () {
    //     when(() => mockRepository.updateTask(any(), any())).thenAnswer((_) async => TaskModel());
    //     return taskBloc;
    //   },
    //   act: (bloc) => bloc.add(const UpdateTaskEvent('task-id')),
    //   expect: () => [
    //     const TaskState(statusTaskUpdate: LoadingStatus.loading),
    //     const TaskState(statusTaskUpdate: LoadingStatus.success),
    //   ],
    //   verify: (_) {
    //     verify(() => mockRepository.updateTask(any(), any())).called(1);
    //   },
    // );

    blocTest<TaskBloc, TaskState>(
      'emits [LoadingStatus.loading, LoadingStatus.success] when DeleteTaskEvent is added',
      build: () {
        when(() => mockRepository.deleteTask(any())).thenAnswer((_) async => {});
        return taskBloc;
      },
      act: (bloc) => bloc.add(const DeleteTaskEvent('task-id')),
      expect: () => [
        const TaskState(statusTaskDelete: LoadingStatus.loading),
        const TaskState(statusTaskDelete: LoadingStatus.success),
      ],
      verify: (_) {
        verify(() => mockRepository.deleteTask(any())).called(1);
      },
    );

    blocTest<TaskBloc, TaskState>(
      'emits [LoadingStatus.loading, LoadingStatus.success] when GetCommentListEvent is added',
      build: () {
        when(() => mockRepository.getCommentListByTask(any()))
            .thenAnswer((_) async => [const EntityComment(id: '1', content: 'Sample Comment', taskId: '1')]);
        return taskBloc;
      },
      act: (bloc) => bloc.add(const GetCommentListEvent('task-id')),
      expect: () => [
        const TaskState(statusCommentList: LoadingStatus.loading),
        const TaskState(
          commentList: [EntityComment(id: '1', content: 'Sample Comment', taskId: '1')],
          statusCommentList: LoadingStatus.success,
        ),
      ],
      verify: (_) {
        verify(() => mockRepository.getCommentListByTask(any())).called(1);
      },
    );
  });
}
