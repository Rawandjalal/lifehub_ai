import 'package:flutter/material.dart';
import '../../core/theme.dart';

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  bool _isListening = false;
  String _transcript = 'Tap the microphone to start speaking...';
  String _assistantReply = '';

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
      if (_isListening) {
        _pulseController.repeat(reverse: true);
        _transcript = 'Listening...';
        _assistantReply = '';

        // Simulate hearing voice command after 3 seconds
        Future.delayed(const Duration(seconds: 3), () {
          if (!mounted || !_isListening) return;
          setState(() {
            _pulseController.stop();
            _isListening = false;
            _transcript = '"What is my budget for this month?"';
            _assistantReply = 'Analyzing your LifeHub Wallet... You have spent \$42.50 today. Your remaining monthly allowance is \$2,307.50.';
          });
        });
      } else {
        _pulseController.stop();
        _transcript = 'Tap to speak...';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Assistant 🎙️'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Voice Wave Sphere
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer Pulsing Ring
                  ScaleTransition(
                    scale: Tween<double>(begin: 1.0, end: 1.6).animate(
                      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
                    ),
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.accentBlue.withValues(alpha: 0.15),
                      ),
                    ),
                  ),
                  // Inner Pulsing Ring
                  ScaleTransition(
                    scale: Tween<double>(begin: 1.0, end: 1.3).animate(
                      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
                    ),
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.accentBlue.withValues(alpha: 0.25),
                      ),
                    ),
                  ),
                  // Main Button Orb
                  GestureDetector(
                    onTap: _toggleListening,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [AppTheme.accentBlue, Colors.indigo],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.accentBlue.withValues(alpha: 0.4),
                            blurRadius: 20,
                            spreadRadius: 4,
                          )
                        ],
                      ),
                      child: Icon(
                        _isListening ? Icons.mic : Icons.mic_none,
                        size: 64,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),

            // Transcript Box
            GlassCard(
              width: double.infinity,
              borderColor: _isListening ? AppTheme.accentBlue.withValues(alpha: 0.4) : null,
              child: Column(
                children: [
                  Text(
                    _isListening ? 'ASSISTANT LISTENING' : 'TRANSCRIPT',
                    style: TextStyle(
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      color: _isListening ? AppTheme.accentBlue : AppTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _transcript,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: _isListening ? FontWeight.normal : FontWeight.bold,
                      color: _isListening ? AppTheme.textSecondary : AppTheme.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // AI Reply Box
            if (_assistantReply.isNotEmpty)
              GlassCard(
                width: double.infinity,
                borderColor: AppTheme.accentGreen.withValues(alpha: 0.3),
                child: Column(
                  children: [
                    const Text(
                      'ASSISTANT RESPONSE',
                      style: TextStyle(
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.accentGreen,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _assistantReply,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
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
