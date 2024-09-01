import 'package:equatable/equatable.dart';

class EntityComment extends Equatable {
  final String id;
  final String taskId;
  final String content;

  const EntityComment({
    required this.id,
    required this.taskId,
    required this.content,
  });

  @override
  List<Object> get props => [];
}