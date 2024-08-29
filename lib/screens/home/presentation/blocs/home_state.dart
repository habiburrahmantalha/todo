part of 'home_cubit.dart';

class HomeState {
  final int? selectedTab;

  const HomeState({this.selectedTab});

  HomeState copyWith({
    int? selectedTab,
  }) {
    return HomeState(
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}

