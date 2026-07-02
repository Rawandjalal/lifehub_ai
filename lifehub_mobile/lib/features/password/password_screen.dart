import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final List<Map<String, String>> _vault = [
    {'service': 'Google Account', 'username': 'rawand@gmail.com', 'password': '••••••••••••'},
    {'service': 'GitHub Profile', 'username': 'Rawandjalal', 'password': '••••••••••••'},
    {'service': 'Bank Account', 'username': 'RAWAND_BANK_12', 'password': '••••••••••••'},
  ];

  int _generatedLength = 12;
  String _generatedPassword = '';

  void _generate() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()';
    final password = List.generate(_generatedLength, (index) {
      return chars[index % chars.length];
    }).join();
    setState(() {
      _generatedPassword = password;
    });
  }

  void _copy(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard!'),
        backgroundColor: AppTheme.accentGreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Safe 🔒'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Safe Entries List
            Text('Saved Accounts', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _vault.length,
              itemBuilder: (context, index) {
                final item = _vault[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['service']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 4),
                          Text(item['username']!, style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.copy, color: AppTheme.accentBlue),
                            onPressed: () => _copy('P@ssword123!', item['service']!), // Mock decrypted copy
                          ),
                          IconButton(
                            icon: const Icon(Icons.visibility_outlined, color: AppTheme.textSecondary),
                            onPressed: () {},
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Password Generator Card
            Text('Password Generator', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            GlassCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Password Length: $_generatedLength', style: const TextStyle(fontWeight: FontWeight.bold)),
                      const Text('Strong', style: TextStyle(color: AppTheme.accentGreen, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Slider(
                    value: _generatedLength.toDouble(),
                    min: 8,
                    max: 24,
                    divisions: 16,
                    activeColor: AppTheme.accentBlue,
                    onChanged: (val) {
                      setState(() {
                        _generatedLength = val.toInt();
                        _generate();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppTheme.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            _generatedPassword.isEmpty ? 'Tap generate below...' : _generatedPassword,
                            style: const TextStyle(fontFamily: 'monospace', fontSize: 16, color: AppTheme.accentYellow),
                          ),
                        ),
                        if (_generatedPassword.isNotEmpty)
                          IconButton(
                            icon: const Icon(Icons.copy, color: AppTheme.textSecondary, size: 20),
                            onPressed: () => _copy(_generatedPassword, 'Generated Password'),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentBlue,
                      minimumSize: const Size(double.infinity, 45),
                    ),
                    onPressed: _generate,
                    child: const Text('Generate Password', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
