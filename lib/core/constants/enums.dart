import 'package:flutter/material.dart';

enum TaskStatus{
  todo(title: "To Do", value: "todo", icon: Icons.pending_actions),
  inProgress(title: "In Progress", value: "in_progress", icon: Icons.play_arrow_outlined),
  done(title: "Done", value: "done", icon: Icons.check);

  const TaskStatus({required this.title, required this.value, required this.icon});
  final String title;
  final String value;
  final IconData icon;
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