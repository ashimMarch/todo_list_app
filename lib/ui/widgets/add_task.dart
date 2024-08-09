import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/data/models/task.dart';
import 'package:todo_list_app/viewmodel/task_viewmodel.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key, this.task});
  final Task? task;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late final TextEditingController _controller;
  late final TaskViewModel taskViewModel;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.task?.title);
    taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(400, 280),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Add ToDo',
              style: TextStyle(
                color: Color(0xFF1565C0),
                fontSize: 20,
              ),
            ),
            TextField(
              controller: _controller,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Add a new task',
                fillColor: Color.fromRGBO(224, 224, 224, 1),
                filled: true,
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                border: outlineInputBorder,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (widget.task != null) {
                  taskViewModel.update(widget.task!, _controller.text);
                } else {
                  taskViewModel.addTask(_controller.text);
                }
                _controller.clear();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 40),
                backgroundColor: const Color(0xFF2196F3),
              ),
              child: const Text(
                'Create',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

const outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  borderSide: BorderSide.none,
);
