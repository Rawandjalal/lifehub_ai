import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/network_service.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      'role': 'ai',
      'text': 'Hi Rawand! I\'m your LifeHub AI Assistant. I can help you summarize notes, analyze your budgets, structure task lists, or plan workouts. Ask me anything!'
    }
  ];

  Future<void> _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final userPrompt = _controller.text.trim();
    setState(() {
      _messages.add({
        'role': 'user',
        'text': userPrompt,
      });
      _controller.clear();
    });

    // Make API Call
    final result = await NetworkService.post('/Chat/message', {
      'UserId': 1,
      'Message': userPrompt,
    });

    setState(() {
      if (result != null && result.containsKey('response')) {
        _messages.add({
          'role': 'ai',
          'text': result['response'] as String,
        });
      } else {
        // Fallback mock response if server offline
        _messages.add({
          'role': 'ai',
          'text': 'Offline Fallback: I processed your request: "$userPrompt". Start the ASP.NET Core API backend to connect live!',
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Assistant 🤖'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Predefined chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildPromptChip('Generate today\'s fitness plan'),
                const SizedBox(width: 8),
                _buildPromptChip('Analyze my finance budget'),
                const SizedBox(width: 8),
                _buildPromptChip('Draft a study note for EF Core'),
              ],
            ),
          ),

          // Message history
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isAi = msg['role'] == 'ai';
                return Align(
                  alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: isAi
                          ? AppTheme.surface
                          : AppTheme.accentBlue.withOpacity(0.8),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: isAi ? const Radius.circular(0) : const Radius.circular(16),
                        bottomRight: isAi ? const Radius.circular(16) : const Radius.circular(0),
                      ),
                      border: isAi
                          ? Border.all(color: Colors.white.withOpacity(0.05))
                          : null,
                    ),
                    child: Text(
                      msg['text']!,
                      style: const TextStyle(color: AppTheme.textPrimary),
                    ),
                  ),
                );
              },
            ),
          ),

          // Input field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Ask LifeHub anything...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppTheme.accentBlue,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromptChip(String label) {
    return ActionChip(
      label: Text(label),
      backgroundColor: AppTheme.surface,
      labelStyle: const TextStyle(color: AppTheme.textSecondary),
      side: const BorderSide(color: Colors.white10),
      onPressed: () {
        _controller.text = label;
      },
    );
  }
}
