import 'package:flutter/material.dart';
import '../../core/theme.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  final List<Map<String, dynamic>> _transactions = [
    {'title': 'Subway Lunch', 'category': 'Food', 'amount': -12.50, 'date': 'Today'},
    {'title': 'Monthly Salary', 'category': 'Income', 'amount': 3200.00, 'date': 'Yesterday'},
    {'title': 'Gym Membership', 'category': 'Fitness', 'amount': -45.00, 'date': 'June 28'},
    {'title': 'Coffee Shop', 'category': 'Food', 'amount': -5.80, 'date': 'June 27'},
  ];

  double get _totalExpenses => _transactions
      .where((t) => t['amount'] < 0)
      .fold(0.0, (sum, item) => sum + (item['amount'] as double).abs());

  double get _totalIncome => _transactions
      .where((t) => t['amount'] > 0)
      .fold(0.0, (sum, item) => sum + (item['amount'] as double));

  void _addTransaction() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        String title = '';
        double amount = 0.0;
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 24,
            left: 24,
            right: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Transaction 💰', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) => title = val,
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Amount (negative for expense)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) => amount = double.tryParse(val) ?? 0.0,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentBlue,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  if (title.isNotEmpty && amount != 0.0) {
                    setState(() {
                      _transactions.insert(0, {
                        'title': title,
                        'category': amount < 0 ? 'Expense' : 'Income',
                        'amount': amount,
                        'date': 'Just Now',
                      });
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Transaction', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Tracker 💰'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Net Balance Ring / Summary
            GlassCard(
              child: Column(
                children: [
                  Text('Net Balance', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 4),
                  Text(
                    '\$${(_totalIncome - _totalExpenses).toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: AppTheme.accentGreen,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryStat('Income', '\$${_totalIncome.toStringAsFixed(0)}', AppTheme.accentGreen),
                      _buildSummaryStat('Expenses', '\$${_totalExpenses.toStringAsFixed(0)}', AppTheme.accentRed),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Transactions Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Transactions', style: Theme.of(context).textTheme.titleLarge),
                IconButton(
                  icon: const Icon(Icons.add, color: AppTheme.accentBlue),
                  onPressed: _addTransaction,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Transaction list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final tx = _transactions[index];
                final isIncome = tx['amount'] > 0;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.03)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tx['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('${tx['category']} • ${tx['date']}', style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      Text(
                        '${isIncome ? '+' : '-'}\$${(tx['amount'] as double).abs().toStringAsFixed(2)}',
                        style: TextStyle(
                          color: isIncome ? AppTheme.accentGreen : AppTheme.accentRed,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18)),
      ],
    );
  }
}
