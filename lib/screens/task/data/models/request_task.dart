class RequestTask {
  RequestTask({
      this.content, 
      this.dueDatetime, 
      this.description, 
      this.labels, 
      this.duration, 
      this.durationUnit,});

  RequestTask.fromJson(dynamic json) {
    content = json['content'];
    dueDatetime = json['due_datetime'];
    description = json['description'];
    labels = json['labels'] != null ? json['labels'].cast<String>() : [];
    duration = json['duration'];
    durationUnit = json['duration_unit'];
  }
  String? content;
  String? dueDatetime;
  String? description;
  List<String>? labels;
  int? duration;
  String? durationUnit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['content'] = content;
    map['due_datetime'] = dueDatetime;
    map['description'] = description;
    map['labels'] = labels;
    map['duration'] = duration;
    map['duration_unit'] = durationUnit;

    map.removeWhere((key, value) => value == null);
    return map;
  }

}