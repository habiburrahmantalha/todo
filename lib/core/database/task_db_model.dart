class TaskDB {
  final String taskId;
  final int duration;
  final String startTime;

  TaskDB({
    required this.taskId,
    required this.duration,
    required this.startTime,
  });

  // Convert a Task object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'task_id': taskId,
      'duration': duration,
      'start_time': startTime,
    };
  }

  // Extract a Task object from a Map object
  factory TaskDB.fromMap(Map<String, dynamic> map) {
    return TaskDB(
      taskId: map['task_id'],
      duration: map['duration'],
      startTime: map['start_time'],
    );
  }
}
