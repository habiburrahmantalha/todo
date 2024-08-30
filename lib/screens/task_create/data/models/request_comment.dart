class RequestComment {
  RequestComment({
      this.taskId, 
      this.content,});

  RequestComment.fromJson(dynamic json) {
    taskId = json['task_id'];
    content = json['content'];
  }
  String? taskId;
  String? content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['task_id'] = taskId;
    map['content'] = content;
    return map;
  }

}