class Task {
  final int id;
  final String title;
  final String description;
  final String status;
  final String time;
  final String category;
  final String priority;
  final List<String> subtasks;
  final List<String> attachments;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.time,
    required this.category,
    required this.priority,
    required this.subtasks,
    required this.attachments,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      priority: json['priority'],
      category: json['category'],
      time: json['dueDate'], // hoặc parse lại định dạng nếu cần

      // Lấy title của từng subtask
      subtasks: (json['subtasks'] as List<dynamic>?)
          ?.map((e) => e['title'] as String)
          .toList() ?? [],

      // Lấy fileName của từng attachment
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => e['fileName'] as String)
          .toList() ?? [],
    );
  }

}
