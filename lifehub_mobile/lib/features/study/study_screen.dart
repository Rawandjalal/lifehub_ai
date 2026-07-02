import 'package:flutter/material.dart';
import '../../core/theme.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  final List<Map<String, dynamic>> _flashcards = [
    {'q': 'What is the purpose of EF Core migrations?', 'a': 'To update the database schema incrementally to keep it in sync with the EF Core models.'},
    {'q': 'What is glassmorphism?', 'a': 'A design style characterized by frosted-glass-like transparency, background blur, and fine borders.'},
    {'q': 'What is a StateNotifier in Flutter?', 'a': 'A state management class designed to store and update a single immutable state object.'},
  ];

  int _currentIndex = 0;
  bool _isFlipped = false;
  int _scoreCorrect = 0;
  int _scoreIncorrect = 0;

  void _nextCard(bool correct) {
    setState(() {
      if (correct) {
        _scoreCorrect++;
      } else {
        _scoreIncorrect++;
      }
      _isFlipped = false;
      _currentIndex = (_currentIndex + 1) % _flashcards.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final card = _flashcards[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Flashcards 📚'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Score Board
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Correct: $_scoreCorrect', style: const TextStyle(color: AppTheme.accentGreen, fontWeight: FontWeight.bold)),
                Text('Incorrect: $_scoreIncorrect', style: const TextStyle(color: AppTheme.accentRed, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 32),

            // Card Panel
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isFlipped = !_isFlipped;
                  });
                },
                child: GlassCard(
                  borderColor: _isFlipped ? AppTheme.accentGreen.withValues(alpha: 0.3) : AppTheme.accentBlue.withValues(alpha: 0.3),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _isFlipped ? Icons.menu_book : Icons.help_outline,
                            size: 48,
                            color: _isFlipped ? AppTheme.accentGreen : AppTheme.accentBlue,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            _isFlipped ? 'ANSWER' : 'QUESTION',
                            style: TextStyle(
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                              color: _isFlipped ? AppTheme.accentGreen : AppTheme.accentBlue,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _isFlipped ? card['a'] : card['q'],
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 20),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            _isFlipped ? 'Tap to view question' : 'Tap to view answer',
                            style: const TextStyle(color: AppTheme.textSecondary, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Correct/Incorrect Actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentRed.withValues(alpha: 0.2),
                      side: const BorderSide(color: AppTheme.accentRed),
                      minimumSize: const Size(0, 50),
                    ),
                    onPressed: () => _nextCard(false),
                    child: const Text('Incorrect ❌', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentGreen.withValues(alpha: 0.2),
                      side: const BorderSide(color: AppTheme.accentGreen),
                      minimumSize: const Size(0, 50),
                    ),
                    onPressed: () => _nextCard(true),
                    child: const Text('Correct   ', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
