import 'package:flutter/material.dart';
import '../../core/theme.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  final Map<int, List<String>> _events = {
    3: ['Sprint planning meeting at 10 AM', 'Gym session - legs'],
    5: ['Submit LifeHub architecture review'],
    12: ['Dinner with friends'],
    15: ['Doctor appointment at 3 PM'],
  };

  void _addEvent() {
    String text = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.surface,
          title: const Text('Add Event 📅'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Event description'),
            onChanged: (val) => text = val,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: AppTheme.textSecondary)),
            ),
            TextButton(
              onPressed: () {
                if (text.isNotEmpty) {
                  setState(() {
                    final day = _selectedDate.day;
                    if (_events[day] == null) {
                      _events[day] = [text];
                    } else {
                      _events[day]!.add(text);
                    }
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Add', style: TextStyle(color: AppTheme.accentBlue)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateUtils.getDaysInMonth(_selectedDate.year, _selectedDate.month);
    final firstDayOffset = DateTime(_selectedDate.year, _selectedDate.month, 1).weekday - 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar & Schedule 📅'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Month Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_monthName(_selectedDate.month)} ${_selectedDate.year}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () {
                        setState(() {
                          _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1);
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () {
                        setState(() {
                          _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1);
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),

            // Weekdays
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                  .map((d) => SizedBox(
                        width: 40,
                        child: Text(d, textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 8),

            // Grid Calendar
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: daysInMonth + firstDayOffset,
              itemBuilder: (context, index) {
                if (index < firstDayOffset) {
                  return const SizedBox();
                }
                final day = index - firstDayOffset + 1;
                final isSelected = day == _selectedDate.day;
                final hasEvents = _events[day]?.isNotEmpty ?? false;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month, day);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.accentBlue
                          : hasEvents
                              ? AppTheme.accentBlue.withValues(alpha: 0.15)
                              : AppTheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.accentBlue
                            : Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          '$day',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : AppTheme.textPrimary,
                          ),
                        ),
                        if (hasEvents && !isSelected)
                          Positioned(
                            bottom: 6,
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppTheme.accentYellow,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Events List Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Events for ${_monthName(_selectedDate.month)} ${_selectedDate.day}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: AppTheme.accentBlue),
                  onPressed: _addEvent,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Events list
            if (_events[_selectedDate.day]?.isEmpty ?? true)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text('No events scheduled for this day.', style: TextStyle(color: AppTheme.textSecondary)),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _events[_selectedDate.day]!.length,
                itemBuilder: (context, index) {
                  final ev = _events[_selectedDate.day]![index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 24,
                          color: AppTheme.accentYellow,
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(ev)),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: AppTheme.accentRed, size: 20),
                          onPressed: () {
                            setState(() {
                              _events[_selectedDate.day]!.removeAt(index);
                            });
                          },
                        ),
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

  String _monthName(int month) {
    const names = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return names[month - 1];
  }
}
