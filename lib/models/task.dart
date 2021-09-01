import 'package:flutter/foundation.dart';

class Task with ChangeNotifier {
  int stepId;
  int taskId;
  int period;
  String taskName;
  String taskContent;
  bool checked;

  Task(
      {this.stepId,
      this.taskId,
      this.period,
      this.taskName,
      this.taskContent,
      this.checked});

  toggleCheck() {
    this.checked = !this.checked;
  }

  Task.fromJson(Map<String, dynamic> json) {
    stepId = json['stepId'];
    taskId = json['taskId'];
    period = json['period'];
    taskName = json['taskName'];
    taskContent = json['taskContent'];
  }

  factory Task.convertToTask(Map<String, dynamic> json) {
    return Task(
      stepId: json['step_id'],
      taskId: json['task_id'],
      period: json['periode'],
      taskName: json['task_name'],
      taskContent: json['task_content'],
      checked: false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stepId'] = this.stepId;
    data['taskId'] = this.taskId;
    data['period'] = this.period;
    data['taskName'] = this.taskName;
    data['taskContent'] = this.taskContent;
    return data;
  }
}
