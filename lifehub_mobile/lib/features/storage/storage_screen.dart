import 'package:flutter/material.dart';
import '../../core/theme.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  final List<Map<String, String>> _files = [
    {'name': 'Resume_2026.pdf', 'size': '1.2 MB', 'type': 'PDF'},
    {'name': 'ProfilePicture.png', 'size': '3.4 MB', 'type': 'Image'},
    {'name': 'StudyNotes_EFCore.docx', 'size': '520 KB', 'type': 'Doc'},
    {'name': 'WorkoutSession.mp4', 'size': '45.1 MB', 'type': 'Video'},
  ];

  double get _usedStorage => 4.2; // in GB
  final double _maxStorage = 15.0; // in GB

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Storage ☁️'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quota Card
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Storage Used', style: Theme.of(context).textTheme.titleLarge),
                      Text(
                        '${_usedStorage.toStringAsFixed(1)} GB / $_maxStorage GB',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.accentBlue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: _usedStorage / _maxStorage,
                    backgroundColor: Colors.white10,
                    color: AppTheme.accentBlue,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 12),
                  const Text('Upgrade to Pro for 200 GB Storage', style: TextStyle(color: AppTheme.accentYellow, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // File categories grid
            Row(
              children: [
                Expanded(child: _buildCategoryCard(Icons.insert_drive_file, 'Docs', '124 files', Colors.orange)),
                const SizedBox(width: 16),
                Expanded(child: _buildCategoryCard(Icons.image, 'Images', '432 files', Colors.teal)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildCategoryCard(Icons.video_library, 'Videos', '18 files', Colors.pink)),
                const SizedBox(width: 16),
                Expanded(child: _buildCategoryCard(Icons.backup, 'Backups', '2 archives', Colors.indigo)),
              ],
            ),
            const SizedBox(height: 24),

            // Recent Files
            Text('Recent Files', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _files.length,
              itemBuilder: (context, index) {
                final file = _files[index];
                IconData icon;
                Color iconColor;

                switch (file['type']) {
                  case 'PDF':
                    icon = Icons.picture_as_pdf;
                    iconColor = AppTheme.accentRed;
                    break;
                  case 'Image':
                    icon = Icons.image;
                    iconColor = AppTheme.accentGreen;
                    break;
                  case 'Video':
                    icon = Icons.video_library;
                    iconColor = Colors.pink;
                    break;
                  default:
                    icon = Icons.insert_drive_file;
                    iconColor = AppTheme.accentBlue;
                }

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
                      Row(
                        children: [
                          Icon(icon, color: iconColor, size: 28),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(file['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(file['size']!, style: Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: AppTheme.textSecondary),
                        onPressed: () {},
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.accentBlue,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('File picker initiated...'),
              backgroundColor: AppTheme.accentBlue,
            ),
          );
        },
        child: const Icon(Icons.cloud_upload, color: Colors.white),
      ),
    );
  }

  Widget _buildCategoryCard(IconData icon, String label, String count, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.15),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(count, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
