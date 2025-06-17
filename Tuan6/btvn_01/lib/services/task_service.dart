import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';

class TaskService {
  static const baseUrl = 'https://amock.io/api/researchUTH';

  Future<List<Task>> fetchTasks() async {
  try {
    final res = await http.get(Uri.parse('$baseUrl/tasks'));

    if (res.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(res.body);
      final List<dynamic> taskList = jsonData['data']; // ⚠️ Lấy từ key "data"

      return taskList.map((e) => Task.fromJson(e)).toList();
    } else {
      print('Failed: ${res.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}


  Future<Task> fetchTaskDetail(int id) async {
    final res = await http.get(Uri.parse('$baseUrl/task/$id'));
    if (res.statusCode == 200) {
      return Task.fromJson(json.decode(res.body));
    } else {
      throw Exception('Failed to load task detail');
    }
  }

  Future<void> deleteTask(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/task/$id'));
    if (res.statusCode != 200) {
      throw Exception('Failed to delete');
    }
  }
}
