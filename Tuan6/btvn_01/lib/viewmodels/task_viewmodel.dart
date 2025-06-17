import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskService _service = TaskService();

  List<Task> tasks = [];
  bool isLoading = false;

  Future<void> loadTasks() async {
    isLoading = true;
    notifyListeners();
    tasks = await _service.fetchTasks();
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    await _service.deleteTask(id);
    tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}
