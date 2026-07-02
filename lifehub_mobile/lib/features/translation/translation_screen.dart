import 'package:flutter/material.dart';
import '../../core/theme.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  String _sourceLanguage = 'English';
  String _targetLanguage = 'Spanish';
  final TextEditingController _inputController = TextEditingController();
  String _translatedText = '';

  final Map<String, String> _languages = {
    'English': 'en',
    'Spanish': 'es',
    'Arabic': 'ar',
    'French': 'fr',
    'German': 'de',
  };

  void _translate() {
    if (_inputController.text.trim().isEmpty) return;
    setState(() {
      final input = _inputController.text.trim();
      // Simple mockup translation rules
      if (_targetLanguage == 'Spanish') {
        _translatedText = 'Hola, esto es una traducción simulada de: "$input"';
      } else if (_targetLanguage == 'Arabic') {
        _translatedText = 'مرحباً، هذه ترجمة وهمية لـ: "$input"';
      } else {
        _translatedText = 'Bonjour/Hello, simulated translation of: "$input"';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translation 🌐'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Language Selectors
            GlassCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownButton<String>(
                    value: _sourceLanguage,
                    dropdownColor: AppTheme.surface,
                    style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold),
                    items: _languages.keys.map((lang) {
                      return DropdownMenuItem(value: lang, child: Text(lang));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _sourceLanguage = val;
                        });
                      }
                    },
                  ),
                  const Icon(Icons.arrow_forward, color: AppTheme.accentBlue),
                  DropdownButton<String>(
                    value: _targetLanguage,
                    dropdownColor: AppTheme.surface,
                    style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold),
                    items: _languages.keys.map((lang) {
                      return DropdownMenuItem(value: lang, child: Text(lang));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _targetLanguage = val;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Input Card
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Enter Text', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _inputController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Type something to translate...',
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentBlue,
                      minimumSize: const Size(double.infinity, 45),
                    ),
                    onPressed: _translate,
                    child: const Text('Translate', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Output Card
            if (_translatedText.isNotEmpty)
              GlassCard(
                borderColor: AppTheme.accentGreen.withValues(alpha: 0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Translation Output', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.accentGreen, fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.copy, size: 20, color: AppTheme.textSecondary),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _translatedText,
                      style: const TextStyle(fontSize: 16, height: 1.4),
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
