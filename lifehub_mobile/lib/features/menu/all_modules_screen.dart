import 'package:flutter/material.dart';
import '../../core/theme.dart';

class AllModulesScreen extends StatelessWidget {
  final Function(int) onModuleSelected;

  final List<Map<String, dynamic>> modules = [
    {'name': 'AI Assistant', 'icon': Icons.smart_toy, 'status': 'Active', 'color': AppTheme.accentBlue, 'pageIndex': 1},
    {'name': 'Finance', 'icon': Icons.account_balance_wallet, 'status': 'Active', 'color': AppTheme.accentGreen, 'pageIndex': 2},
    {'name': 'Calendar', 'icon': Icons.calendar_month, 'status': 'Active', 'color': AppTheme.accentYellow, 'pageIndex': 8},
    {'name': 'Notes', 'icon': Icons.note, 'status': 'Active', 'color': Colors.purple, 'pageIndex': 4},
    {'name': 'To-do lists', 'icon': Icons.check_box, 'status': 'Active', 'color': Colors.orange, 'pageIndex': 3},
    {'name': 'Habits', 'icon': Icons.trending_up, 'status': 'Active', 'color': Colors.teal, 'pageIndex': 5},
    {'name': 'Fitness', 'icon': Icons.directions_run, 'status': 'Active', 'color': Colors.pink, 'pageIndex': 6},
    {'name': 'Study tools', 'icon': Icons.menu_book, 'status': 'Active', 'color': Colors.blueGrey, 'pageIndex': 9},
    {'name': 'Chat Room', 'icon': Icons.chat, 'status': 'Active', 'color': Colors.cyan, 'pageIndex': 13},
    {'name': 'Password Safe', 'icon': Icons.lock, 'status': 'Active', 'color': AppTheme.accentRed, 'pageIndex': 10},
    {'name': 'Translation', 'icon': Icons.translate, 'status': 'Active', 'color': Colors.lime, 'pageIndex': 11},
    {'name': 'AI Camera', 'icon': Icons.photo_camera, 'status': 'Active', 'color': Colors.redAccent, 'pageIndex': 12},
    {'name': 'Cloud Storage', 'icon': Icons.cloud, 'status': 'Active', 'color': Colors.indigo, 'pageIndex': 14},
    {'name': 'Voice Assist', 'icon': Icons.mic, 'status': 'Active', 'color': Colors.amber, 'pageIndex': 15},
    {'name': 'PDF Scanner', 'icon': Icons.document_scanner, 'status': 'Active', 'color': Colors.deepOrange, 'pageIndex': 16},
  ];

  AllModulesScreen({super.key, required this.onModuleSelected});

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
              border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: isReady ? () => onModuleSelected(mod['pageIndex'] as int) : null,
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
