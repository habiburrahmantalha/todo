class Task {
  Task({
    this.id,
    this.content,
    this.description,
    this.isCompleted,
    this.labels,
    this.commentCount,
    this.createdAt,
    this.due,
    this.duration,
    this.deadline,});

  Task.fromJson(dynamic json) {
    id = json['id'];
    order = json['order'];
    content = json['content'];
    description = json['description'];
    isCompleted = json['is_completed'];
    labels = json['labels'] != null ? json['labels'].cast<String>() : [];
    priority = json['priority'];
    commentCount = json['comment_count'];
    createdAt = json['created_at'];
    due = json['due'] != null ? Due.fromJson(json['due']) : null;
    duration = json['duration'] != null ? Duration.fromJson(json['duration']) : null;
    deadline = json['deadline'];
  }
  String? id;
  int? order;
  String? content;
  String? description;
  bool? isCompleted;
  List<String>? labels;
  int? priority;
  int? commentCount;
  String? createdAt;
  Due? due;
  Duration? duration;
  dynamic deadline;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order'] = order;
    map['content'] = content;
    map['description'] = description;
    map['is_completed'] = isCompleted;
    map['labels'] = labels;
    map['priority'] = priority;
    map['comment_count'] = commentCount;
    map['created_at'] = createdAt;
    if (due != null) {
      map['due'] = due?.toJson();
    }
    if (duration != null) {
      map['duration'] = duration?.toJson();
    }
    map['deadline'] = deadline;
    return map;
  }

}

class Duration {
  Duration({
    this.amount,
    this.unit,});

  Duration.fromJson(dynamic json) {
    amount = json['amount'];
    unit = json['unit'];
  }
  int? amount;
  String? unit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['unit'] = unit;
    return map;
  }

}

class Due {
  Due({
    this.date,
    this.timezone,
    this.string,
    this.lang,
    this.isRecurring,
    this.datetime,});

  Due.fromJson(dynamic json) {
    date = json['date'];
    timezone = json['timezone'];
    string = json['string'];
    lang = json['lang'];
    isRecurring = json['is_recurring'];
    datetime = json['datetime'];
  }
  String? date;
  String? timezone;
  String? string;
  String? lang;
  bool? isRecurring;
  String? datetime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['timezone'] = timezone;
    map['string'] = string;
    map['lang'] = lang;
    map['is_recurring'] = isRecurring;
    map['datetime'] = datetime;
    return map;
  }

}