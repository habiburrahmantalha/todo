import 'package:equatable/equatable.dart';
import 'package:todo/core/constants/enums.dart';

class Task extends Equatable {
  final String id;
  final String content;
  final String? description;
  final TaskStatus status;
  final int? commentCount;
  final DateTime? createdAt;
  final DateTime? dueDate;
  final int? duration;

  const Task({
    required this.id,
    required this.content,
    this.description,
    required this.status,
    this.commentCount,
    this.createdAt,
    this.dueDate,
    this.duration,
  });

  @override
  List<Object?> get props =>
      [
        id,
        content,
        description,
        status,
        commentCount,
        createdAt,
        dueDate,
        duration,
      ];
}