import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/data/models/task.dart';
import 'package:todo_list_app/ui/widgets/add_task.dart';
import 'package:todo_list_app/viewmodel/task_viewmodel.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);
    taskViewModel.getTasks();
    return ListenableBuilder(
      listenable: taskViewModel,
      builder: (context, _) {
        return ListView.separated(
          padding: const EdgeInsets.all(10),
          itemCount: taskViewModel.tasks.length,
          itemBuilder: (context, index) {
            final task = taskViewModel.tasks[index];
            return ListTile(
              tileColor:
                  task.isCompleted ? Colors.grey.shade200 : Colors.blue.shade50,
              title: Row(
                children: [
                  Checkbox(
                    value: task.isCompleted,
                    onChanged: (_) => taskViewModel.toggleTaskCompletion(task),
                    shape: const CircleBorder(),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    splashRadius: 15,
                    side: const BorderSide(color: Color(0xFF9E9E9E)),
                  ),
                  Flexible(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 18,
                        color: task.isCompleted
                            ? Colors.grey : Colors.black,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),
                ],
              ),

              minLeadingWidth: 0,
              shape: _outlineInputBorder,
              contentPadding: const EdgeInsets.only(right: 5),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Btn(
                    onTap: () {
                      taskViewModel.deleteTask(task);
                    },
                    icon: Icons.delete,
                  ),
                  Btn(
                    onTap: () {
                      dialogBuilder(
                        context: context,
                        task: task,
                      );
                    },
                    icon: Icons.edit,
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 5),
        );
      },
    );
  }
}

class Btn extends StatelessWidget {
  const Btn({
    super.key,
    this.onTap,
    this.icon,
  });
  final VoidCallback? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        maximumSize: const Size(30, 30),
        minimumSize: const Size(30, 30),
      ),
      iconSize: 23,
      icon: Icon(icon, color: const Color(0xFF9E9E9E)),
    );
  }
}

Future<void> dialogBuilder({
  required BuildContext context,
  Task? task,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        alignment: Alignment.center,
        backgroundColor: Colors.white,
        child: AddTask(task: task),
      );
    },
  );
}

const _outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  borderSide: BorderSide.none,
);
