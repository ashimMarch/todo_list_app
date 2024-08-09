import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/widgets/task_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My To-Dos'),
        backgroundColor: Colors.blue.shade50,
        centerTitle: true,
      ),
      body: const TaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await dialogBuilder(context: context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  
}
