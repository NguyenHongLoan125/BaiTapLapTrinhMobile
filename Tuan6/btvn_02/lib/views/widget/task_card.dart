import 'package:btvn_02/models/task_model.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final int index;
  const TaskCard({super.key, required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    final bgColor = Colors.primaries[index % Colors.primaries.length].shade100;

    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              task.description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
