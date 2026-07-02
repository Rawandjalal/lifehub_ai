import 'package:flutter/material.dart';
import '../../core/theme.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<Map<String, dynamic>> _tasks = [
    {'title': 'Complete Flutter architecture', 'completed': true},
    {'title': 'Prepare ASP.NET DB models', 'completed': true},
    {'title': 'Design dark glassmorphism theme', 'completed': false},
    {'title': 'Setup git pushes and remotes', 'completed': false},
  ];

  final TextEditingController _taskController = TextEditingController();

  void _addTask() {
    if (_taskController.text.trim().isEmpty) return;
    setState(() {
      _tasks.add({
        'title': _taskController.text.trim(),
        'completed': false,
      });
      _taskController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-do Lists ✅'),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Input
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: TextField(
                      controller: _taskController,
                      decoration: const InputDecoration(
                        hintText: 'Add a new task...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onSubmitted: (_) => _addTask(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentBlue,
                    minimumSize: const Size(50, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: _addTask,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),

          // Lists
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                final completed = task['completed'] as bool;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: completed
                          ? Colors.transparent
                          : Colors.white.withOpacity(0.04),
                    ),
                  ),
                  child: ListTile(
                    leading: Checkbox(
                      value: completed,
                      activeColor: AppTheme.accentGreen,
                      onChanged: (val) {
                        setState(() {
                          _tasks[index]['completed'] = val;
                        });
                      },
                    ),
                    title: Text(
                      task['title'],
                      style: TextStyle(
                        decoration: completed ? TextDecoration.lineThrough : null,
                        color: completed ? AppTheme.textSecondary : AppTheme.textPrimary,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: AppTheme.accentRed),
                      onPressed: () {
                        setState(() {
                          _tasks.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
