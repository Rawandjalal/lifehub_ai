import 'package:flutter/material.dart';
import '../../core/theme.dart';

class DashboardScreen extends StatelessWidget {
  final VoidCallback onNavigateToAi;
  final VoidCallback onNavigateToTasks;
  final VoidCallback onNavigateToFinance;

  const DashboardScreen({
    super.key,
    required this.onNavigateToAi,
    required this.onNavigateToTasks,
    required this.onNavigateToFinance,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning,',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rawand 👋',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppTheme.accentBlue.withOpacity(0.2),
                    child: const Icon(Icons.person, color: AppTheme.accentBlue),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // AI Quote Card
              GlassCard(
                borderColor: AppTheme.accentBlue.withOpacity(0.3),
                child: Row(
                  children: [
                    const Icon(Icons.bolt, color: AppTheme.accentYellow, size: 32),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daily AI Insight',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppTheme.accentYellow,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '"Focus on progress, not perfection. Today is a great day to build your goals."',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Stats Row
              Row(
                children: [
                  Expanded(
                    child: GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.directions_walk, color: AppTheme.accentGreen),
                          const SizedBox(height: 12),
                          Text('Steps', style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 4),
                          Text('6,420 / 10k', style: Theme.of(context).textTheme.titleLarge),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.account_balance_wallet, color: AppTheme.accentBlue),
                          const SizedBox(height: 12),
                          Text('Today\'s Spend', style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 4),
                          Text('\$42.50', style: Theme.of(context).textTheme.titleLarge),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Habit Quick Streak
              Text(
                'Habits Streak',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              GlassCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(7, (index) {
                    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                    final done = index < 4; // Mock status
                    return Column(
                      children: [
                        Text(days[index], style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: 8),
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: done ? AppTheme.accentGreen : Colors.transparent,
                            border: Border.all(
                              color: done ? AppTheme.accentGreen : AppTheme.textSecondary.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: done
                              ? const Icon(Icons.check, size: 16, color: Colors.white)
                              : null,
                        ),
                      ],
                    );
                  }),
                ),
              ),
              const SizedBox(height: 24),

              // Tasks Overview
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Today\'s Tasks', style: Theme.of(context).textTheme.titleLarge),
                  TextButton(
                    onPressed: onNavigateToTasks,
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GlassCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _buildTaskItem(context, 'Complete Flutter architecture', true),
                    const Divider(height: 1, color: Colors.white10),
                    _buildTaskItem(context, 'Prepare ASP.NET DB models', true),
                    const Divider(height: 1, color: Colors.white10),
                    _buildTaskItem(context, 'Design dark glassmorphism theme', false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, String title, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isCompleted ? AppTheme.accentGreen : AppTheme.textSecondary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                decoration: isCompleted ? TextDecoration.lineThrough : null,
                color: isCompleted ? AppTheme.textSecondary : AppTheme.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
