import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo/screens/home/presentation/blocs/home_cubit.dart';

void main() {
  group('HomeCubit', () {
    late HomeCubit homeCubit;

    setUp(() {
      homeCubit = HomeCubit();
    });

    tearDown(() {
      homeCubit.close();
    });

    test('initial state is HomeState with null selectedTab', () {
      expect(homeCubit.state, const HomeState());
    });

    blocTest<HomeCubit, HomeState>(
      'emits HomeState with selectedTab when setSelectedTab is called',
      build: () => homeCubit,
      act: (cubit) => cubit.setSelectedTab(0),
      expect: () => [const HomeState(selectedTab: 0)],
    );

    blocTest<HomeCubit, HomeState>(
      'emits HomeState with updated selectedTab when setSelectedTab is called with a different value',
      build: () => homeCubit,
      act: (cubit) {
        cubit.setSelectedTab(0);
        cubit.setSelectedTab(1);
      },
      expect: () => [
        const HomeState(selectedTab: 0),
        const HomeState(selectedTab: 1),
      ],
    );
  });
}
