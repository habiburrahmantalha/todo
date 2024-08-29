class RequestCommentCreate {
  RequestCommentCreate({
      this.taskId, 
      this.content,});

  RequestCommentCreate.fromJson(dynamic json) {
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