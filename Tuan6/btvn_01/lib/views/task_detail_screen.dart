import 'package:btvn_01/models/task_model.dart';
import 'package:btvn_01/viewmodels/task_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Delete Task?'),
                  content: const Text('Are you sure you want to delete this task?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                    TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
                  ],
                ),
              );

              if (confirm == true) {
                final vm = Provider.of<TaskViewModel>(context, listen: false);
                await vm.deleteTask(task.id);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              task.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(task.description),
            const SizedBox(height: 16),


            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildLabelWithIcon(Icons.category, 'Category', task.category),
                  _buildLabelWithIcon(Icons.list_alt, 'Status', task.status),
                  _buildLabelWithIcon(Icons.priority_high, 'Priority', task.priority),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Subtasks',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Column(
              children: task.subtasks.map((s) =>
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CheckboxListTile(
                      value: false,
                      onChanged: (_) {},
                      title: Text(s),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),
                  )
              ).toList(),
            ),


            const SizedBox(height: 24),
            const Text(
              'Attachments',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Column(
              children: task.attachments.map((file) =>
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.attach_file),
                      title: Text(file),
                      contentPadding: EdgeInsets.zero,
                    ),
                  )
              ).toList(),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildLabelWithIcon(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 30,),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

}
