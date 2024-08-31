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

  Task copyWith({
    String? id,
    String? content,
    String? description,
    TaskStatus? status,
    int? commentCount,
    DateTime? createdAt,
    DateTime? dueDate,
    int? duration,
  }) {
    return Task(
      id: id ?? this.id,
      content: content ?? this.content,
      description: description ?? this.description,
      status: status ?? this.status,
      commentCount: commentCount ?? this.commentCount,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      duration: duration ?? this.duration,
    );
  }
}