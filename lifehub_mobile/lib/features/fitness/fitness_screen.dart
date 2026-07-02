import 'package:flutter/material.dart';
import '../../core/theme.dart';

class FitnessScreen extends StatefulWidget {
  const FitnessScreen({super.key});

  @override
  State<FitnessScreen> createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> {
  int _waterCups = 3;
  int _calories = 1420;
  final int _calorieGoal = 2000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness & Diet 💪'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Calorie tracker Card
            GlassCard(
              child: Column(
                children: [
                  Text('Calorie Intake', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 140,
                        height: 140,
                        child: CircularProgressIndicator(
                          value: _calories / _calorieGoal,
                          strokeWidth: 12,
                          backgroundColor: Colors.white10,
                          color: AppTheme.accentYellow,
                        ),
                      ),
                      Column(
                        children: [
                          Text('$_calories', style: Theme.of(context).textTheme.headlineMedium),
                          Text('/ $_calorieGoal kcal', style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.surface),
                        onPressed: () {
                          setState(() {
                            _calories = (_calories - 100).clamp(0, 5000);
                          });
                        },
                        child: const Text('- 100 kcal'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accentBlue),
                        onPressed: () {
                          setState(() {
                            _calories = (_calories + 200).clamp(0, 5000);
                          });
                        },
                        child: const Text('+ 200 kcal', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Water Tracker Card
            GlassCard(
              child: Column(
                children: [
                  Text('Water Tracker 💧', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text('Goal: 8 cups (250ml each)', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(8, (index) {
                      final active = index < _waterCups;
                      return Icon(
                        Icons.local_drink,
                        size: 32,
                        color: active ? AppTheme.accentBlue : Colors.white10,
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: AppTheme.accentRed, size: 28),
                        onPressed: () {
                          setState(() {
                            _waterCups = (_waterCups - 1).clamp(0, 8);
                          });
                        },
                      ),
                      Text('$_waterCups / 8 Cups', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline, color: AppTheme.accentGreen, size: 28),
                        onPressed: () {
                          setState(() {
                            _waterCups = (_waterCups + 1).clamp(0, 8);
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
