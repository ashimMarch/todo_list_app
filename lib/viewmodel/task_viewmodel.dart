import 'package:flutter/foundation.dart';
import '../data/models/task.dart';
import '../data/repositories/task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository _repository = TaskRepository();
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> getTasks() async {
    _tasks = await _repository.getTasks();
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    if (title.isEmpty) return;
    final task = Task(title: title);
    await _repository.insertTask(task);
    await getTasks();
  }

  Future<void> update(Task task, String title) async {
    if (title.isEmpty) return;
    await _repository.updateTask(task.copyWith(title: title));
    await getTasks();
  }

  Future<void> toggleTaskCompletion(Task task) async {
    task.isCompleted = !task.isCompleted;
    await _repository.updateTask(task);
    await getTasks();
  }

  Future<void> deleteTask(Task task) async {
    await _repository.deleteTask(task.id!);
    await getTasks();
  }
}
