class ApiEndpoint{
  static String task = "tasks";
  static String editTask(String? id) => "tasks/$id";

  static String createComment = "comments";
  static String editComment(String? id) => "comments/$id";
  static String getCommentListByTask(String? id) => "comments?task_id=$id";
}