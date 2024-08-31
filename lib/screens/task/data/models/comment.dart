class Comment {
  Comment({
      this.id, 
      this.taskId,
      this.content, 
      this.postedAt});

  Comment.fromJson(dynamic json) {
    id = json['id'];
    taskId = json['task_id'];
    content = json['content'];
    postedAt = json['posted_at'];
  }
  String? id;
  String? taskId;
  String? content;
  String? postedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['task_id'] = taskId;
    map['content'] = content;
    map['posted_at'] = postedAt;
    return map;
  }

}