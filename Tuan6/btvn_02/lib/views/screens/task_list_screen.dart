import 'package:btvn_02/viewmodels/task_viewmodel.dart';
import 'package:btvn_02/views/widget/task_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List',style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blue,),
          onPressed: (){},
        ),
      ),
      body: Consumer<TaskViewModel>(
        builder: (context, vm, child) {
          if (vm.tasks.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.book_outlined,
                            size: 100,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "No Tasks Yet!",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Stay productive—add something to do",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return ListView.builder(
            itemCount: vm.tasks.length,
            itemBuilder: (context, index) {
              final task = vm.tasks[index];
              return TaskCard(task: task, index: index);
            },
          );

        },
      ),

    );
  }
}
