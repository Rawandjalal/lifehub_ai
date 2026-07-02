import 'package:flutter/material.dart';
import '../../core/theme.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<Map<String, String>> _notes = [
    {
      'title': 'Project Ideas',
      'content': '1. LifeHub AI - All-in-one personal ecosystem.\n2. Finance tracker - simple budget management.'
    },
    {
      'title': 'Shopping List',
      'content': 'Groceries: milk, eggs, bread, coffee beans, spinach, salmon.'
    },
    {
      'title': 'Study Notes (EF Core)',
      'content': 'Use UseSqlite to configure SQLite database. Run dotnet ef migrations add for DB management.'
    },
  ];

  void _addOrEditNote({int? index}) {
    final titleController = TextEditingController(text: index != null ? _notes[index]['title'] : '');
    final contentController = TextEditingController(text: index != null ? _notes[index]['content'] : '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.surface,
          title: Text(index == null ? 'New Note 📝' : 'Edit Note 📝'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: contentController,
                maxLines: 4,
                decoration: const InputDecoration(hintText: 'Content'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: AppTheme.textSecondary)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  final newNote = {
                    'title': titleController.text,
                    'content': contentController.text,
                  };
                  if (index == null) {
                    _notes.add(newNote);
                  } else {
                    _notes[index] = newNote;
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Save', style: TextStyle(color: AppTheme.accentBlue)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notion Notes 📝'),
        backgroundColor: Colors.transparent,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final note = _notes[index];
          return GestureDetector(
            onTap: () => _addOrEditNote(index: index),
            child: GlassCard(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note['title']!,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      note['content']!,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.accentBlue,
        onPressed: () => _addOrEditNote(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
