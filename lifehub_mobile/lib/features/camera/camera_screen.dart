import 'package:flutter/material.dart';
import '../../core/theme.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with SingleTickerProviderStateMixin {
  late AnimationController _scannerController;
  bool _isScanning = true;

  @override
  void initState() {
    super.initState();
    _scannerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Viewfinder Background Mock
          Container(
            color: Colors.black87,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.photo_camera_outlined, size: 80, color: Colors.white.withValues(alpha: 0.1)),
                  const SizedBox(height: 16),
                  Text('AI Camera Viewfinder Active', style: TextStyle(color: Colors.white.withValues(alpha: 0.3))),
                ],
              ),
            ),
          ),

          // Focus Target Frames
          Center(
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white24, width: 2),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),

          // Animated Scanner Line
          if (_isScanning)
            AnimatedBuilder(
              animation: _scannerController,
              builder: (context, child) {
                final topOffset = MediaQuery.of(context).size.height * 0.3 + 
                    (_scannerController.value * 280);
                return Positioned(
                  top: topOffset,
                  left: MediaQuery.of(context).size.width * 0.15,
                  right: MediaQuery.of(context).size.width * 0.15,
                  child: Container(
                    height: 3,
                    decoration: BoxDecoration(
                      color: AppTheme.accentBlue,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.accentBlue.withValues(alpha: 0.8),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

          // Mock Detection Overlays
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            left: MediaQuery.of(context).size.width * 0.22,
            child: _buildDetectionLabel('Person (Rawand)', '98%', AppTheme.accentGreen),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.52,
            left: MediaQuery.of(context).size.width * 0.45,
            child: _buildDetectionLabel('Coffee Mug', '91%', AppTheme.accentYellow),
          ),

          // Top Header Info
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'AI OBJECT DETECTION',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                  IconButton(
                    icon: Icon(
                      _isScanning ? Icons.pause_circle_outline : Icons.play_circle_outline,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isScanning = !_isScanning;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          // Bottom Control Deck
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: GlassCard(
              borderColor: Colors.white10,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildModeButton(Icons.document_scanner, 'OCR Text', false),
                      _buildModeButton(Icons.remove_red_eye, 'Objects', true),
                      _buildModeButton(Icons.qr_code_scanner, 'QR Code', false),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.black, size: 28),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('AI Camera Analysis Captured!'),
                            backgroundColor: AppTheme.accentBlue,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetectionLabel(String name, String confidence, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text('$name ($confidence)', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildModeButton(IconData icon, String label, bool active) {
    return Column(
      children: [
        Icon(icon, color: active ? AppTheme.accentBlue : AppTheme.textSecondary),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
            color: active ? AppTheme.textPrimary : AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}
