import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/ai/ai_chat_screen.dart';
import 'features/finance/finance_screen.dart';
import 'features/notes/notes_screen.dart';
import 'features/tasks/tasks_screen.dart';
import 'features/habits/habits_screen.dart';
import 'features/fitness/fitness_screen.dart';
import 'features/menu/all_modules_screen.dart';

void main() {
  runApp(const LifeHubApp());
}

class LifeHubApp extends StatelessWidget {
  const LifeHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeHub AI',
      theme: AppTheme.darkTheme,
      home: const MainHubScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainHubScreen extends StatefulWidget {
  const MainHubScreen({super.key});

  @override
  State<MainHubScreen> createState() => _MainHubScreenState();
}

class _MainHubScreenState extends State<MainHubScreen> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      DashboardScreen(
        onNavigateToAi: () => _setPage(1),
        onNavigateToTasks: () => _setPage(3),
        onNavigateToFinance: () => _setPage(2),
      ),
      const AiChatScreen(),
      const FinanceScreen(),
      const TasksScreen(),
      const NotesScreen(),
      const HabitsScreen(),
      const FitnessScreen(),
      AllModulesScreen(),
    ];
  }

  void _setPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex > 4 ? 4 : _currentIndex,
        onDestinationSelected: (index) {
          if (index == 4) {
            // Show modular grid or selection sheet
            _setPage(7); // Jump to All Modules screen
          } else {
            _setPage(index);
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.smart_toy_outlined),
            selectedIcon: Icon(Icons.smart_toy),
            label: 'AI Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Finance',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_box_outlined),
            selectedIcon: Icon(Icons.check_box),
            label: 'Tasks',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Modules',
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppTheme.background,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppTheme.surface,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'LifeHub AI',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppTheme.accentBlue,
                        ),
                  ),
                  const SizedBox(height: 4),
                  const Text('Personal Operating System', style: TextStyle(color: AppTheme.textSecondary)),
                ],
              ),
            ),
            _buildDrawerItem(Icons.dashboard, 'Home', 0),
            _buildDrawerItem(Icons.smart_toy, 'AI Assistant', 1),
            _buildDrawerItem(Icons.account_balance_wallet, 'Finance', 2),
            _buildDrawerItem(Icons.check_box, 'Tasks', 3),
            _buildDrawerItem(Icons.note, 'Notes', 4),
            _buildDrawerItem(Icons.trending_up, 'Habits', 5),
            _buildDrawerItem(Icons.directions_run, 'Fitness', 6),
            _buildDrawerItem(Icons.grid_view, 'All Modules', 7),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    final active = _currentIndex == index;
    return ListTile(
      leading: Icon(icon, color: active ? AppTheme.accentBlue : AppTheme.textSecondary),
      title: Text(
        title,
        style: TextStyle(
          color: active ? AppTheme.textPrimary : AppTheme.textSecondary,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: active,
      selectedTileColor: AppTheme.surface,
      onTap: () {
        Navigator.pop(context); // Close Drawer
        _setPage(index);
      },
    );
  }
}
