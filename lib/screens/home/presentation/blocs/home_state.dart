part of 'home_cubit.dart';

class HomeState extends Equatable {
  final int? selectedTab;

  const HomeState({this.selectedTab});

  HomeState copyWith({
    int? selectedTab,
  }) {
    return HomeState(
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }

  @override
  List<Object?> get props => [selectedTab];
}

