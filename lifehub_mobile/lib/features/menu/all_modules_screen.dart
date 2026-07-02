import 'package:flutter/material.dart';
import '../../core/theme.dart';

class AllModulesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> modules = [
    {'name': 'AI Assistant', 'icon': Icons.smart_toy, 'status': 'Active', 'color': AppTheme.accentBlue},
    {'name': 'Finance', 'icon': Icons.account_balance_wallet, 'status': 'Active', 'color': AppTheme.accentGreen},
    {'name': 'Calendar', 'icon': Icons.calendar_month, 'status': 'Beta', 'color': AppTheme.accentYellow},
    {'name': 'Notes', 'icon': Icons.note, 'status': 'Active', 'color': Colors.purple},
    {'name': 'To-do lists', 'icon': Icons.check_box, 'status': 'Active', 'color': Colors.orange},
    {'name': 'Habits', 'icon': Icons.trending_up, 'status': 'Active', 'color': Colors.teal},
    {'name': 'Fitness', 'icon': Icons.directions_run, 'status': 'Active', 'color': Colors.pink},
    {'name': 'Study tools', 'icon': Icons.menu_book, 'status': 'Coming Soon', 'color': Colors.blueGrey},
    {'name': 'Chat Room', 'icon': Icons.chat, 'status': 'Coming Soon', 'color': Colors.cyan},
    {'name': 'Cloud Storage', 'icon': Icons.cloud, 'status': 'Coming Soon', 'color': Colors.indigo},
    {'name': 'Password Safe', 'icon': Icons.lock, 'status': 'Coming Soon', 'color': AppTheme.accentRed},
    {'name': 'Translation', 'icon': Icons.translate, 'status': 'Coming Soon', 'color': Colors.lime},
    {'name': 'PDF Scanner', 'icon': Icons.document_scanner, 'status': 'Coming Soon', 'color': Colors.deepOrange},
    {'name': 'Voice Assist', 'icon': Icons.mic, 'status': 'Coming Soon', 'color': Colors.amber},
    {'name': 'AI Camera', 'icon': Icons.photo_camera, 'status': 'Coming Soon', 'color': Colors.redAccent},
  ];

  AllModulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Modules 🌐'),
        backgroundColor: Colors.transparent,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.9,
        ),
        itemCount: modules.length,
        itemBuilder: (context, index) {
          final mod = modules[index];
          final isReady = mod['status'] == 'Active' || mod['status'] == 'Beta';
          return Container(
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.04)),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: isReady
                  ? () {
                      // Handled by parent controller
                    }
                  : null,
              child: Opacity(
                opacity: isReady ? 1.0 : 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(mod['icon'], color: mod['color'], size: 32),
                    const SizedBox(height: 8),
                    Text(
                      mod['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      mod['status'],
                      style: TextStyle(
                        fontSize: 10,
                        color: mod['status'] == 'Active'
                            ? AppTheme.accentGreen
                            : mod['status'] == 'Beta'
                                ? AppTheme.accentYellow
                                : AppTheme.textSecondary,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
