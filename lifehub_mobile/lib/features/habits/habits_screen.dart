import 'package:flutter/material.dart';
import '../../core/theme.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  final List<Map<String, dynamic>> _habits = [
    {'title': 'Read 10 pages', 'streak': 5, 'completed': true},
    {'title': 'Code for 1 hour', 'streak': 12, 'completed': true},
    {'title': 'Drink 3L Water', 'streak': 2, 'completed': false},
    {'title': 'Morning Meditation', 'streak': 8, 'completed': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habits Streak 📈'),
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _habits.length,
        itemBuilder: (context, index) {
          final habit = _habits[index];
          final done = habit['completed'] as bool;
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.04)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.local_fire_department, color: AppTheme.accentYellow, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            '${habit['streak']} Day Streak',
                            style: const TextStyle(color: AppTheme.accentYellow, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _habits[index]['completed'] = !done;
                      _habits[index]['streak'] += !done ? 1 : -1;
                    });
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: done ? AppTheme.accentGreen.withOpacity(0.2) : Colors.transparent,
                      border: Border.all(
                        color: done ? AppTheme.accentGreen : AppTheme.textSecondary.withOpacity(0.3),
                        width: 2.5,
                      ),
                    ),
                    child: done
                        ? const Icon(Icons.check, color: AppTheme.accentGreen, size: 24)
                        : null,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
