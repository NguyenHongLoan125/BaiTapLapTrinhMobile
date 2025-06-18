import 'package:btvn_02/models/task_model.dart';
import 'package:flutter/material.dart';

class TaskViewModel extends ChangeNotifier {
  List<Task> tasks = [];

  void addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  void deleteTask(String id) {
    tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}
