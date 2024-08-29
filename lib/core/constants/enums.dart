enum TaskStatus{
  todo(title: "To Do", value: "todo"),
  inProgress(title: "In Progress", value: "in_progress"),
  done(title: "Done", value: "done");

  const TaskStatus({required this.title, required this.value});
  final String title;
  final String value;
}

enum LoadingStatus {
  initial,
  loading,
  success,
  failed;

  bool get isLoading => this == LoadingStatus.loading;

  bool get isSuccess => this == LoadingStatus.success;

  bool get isFailed => this == LoadingStatus.failed;
}