import 'package:flutter/material.dart';
import '../../core/theme.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final List<Map<String, String>> _scannedDocs = [
    {'title': 'University_Timetable.pdf', 'date': 'July 1, 2026', 'pages': '1 page'},
    {'title': 'Supermarket_Receipt.pdf', 'date': 'June 29, 2026', 'pages': '2 pages'},
  ];

  void _startScan() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Scanner Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Document Scanner 📄', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
              const SizedBox(height: 32),

              // Viewfinder Mock
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppTheme.accentBlue, width: 2),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.document_scanner, size: 64, color: AppTheme.accentBlue.withValues(alpha: 0.8)),
                          const SizedBox(height: 12),
                          const Text('Position document within frame', style: TextStyle(color: AppTheme.textSecondary)),
                        ],
                      ),
                      // Mock corners
                      Positioned(
                        top: 20, left: 20,
                        child: Container(width: 20, height: 20, decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white70, width: 3), left: BorderSide(color: Colors.white70, width: 3)))),
                      ),
                      Positioned(
                        top: 20, right: 20,
                        child: Container(width: 20, height: 20, decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white70, width: 3), right: BorderSide(color: Colors.white70, width: 3)))),
                      ),
                      Positioned(
                        bottom: 20, left: 20,
                        child: Container(width: 20, height: 20, decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white70, width: 3), left: BorderSide(color: Colors.white70, width: 3)))),
                      ),
                      Positioned(
                        bottom: 20, right: 20,
                        child: Container(width: 20, height: 20, decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white70, width: 3), right: BorderSide(color: Colors.white70, width: 3)))),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Scanner Trigger Button
              CircleAvatar(
                radius: 36,
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.black, size: 28),
                  onPressed: () {
                    setState(() {
                      _scannedDocs.insert(0, {
                        'title': 'NewScan_${DateTime.now().millisecondsSinceEpoch}.pdf',
                        'date': 'Just Now',
                        'pages': '1 page',
                      });
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Document processed and OCR completed!'),
                        backgroundColor: AppTheme.accentGreen,
                      ),
                    );
                  },
                ),
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
        title: const Text('PDF scanner 📄'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // OCR Feature Promo
            GlassCard(
              borderColor: AppTheme.accentBlue.withValues(alpha: 0.3),
              child: Row(
                children: [
                  const Icon(Icons.bolt, color: AppTheme.accentYellow, size: 28),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('AI OCR Active', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.accentYellow, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        const Text('Scanned receipts, notes, or homework will automatically be converted to text and indexed in your notes.', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Scanned Documents Grid / List
            Text('Scanned Documents', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _scannedDocs.length,
              itemBuilder: (context, index) {
                final doc = _scannedDocs[index];
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
                          const Icon(Icons.picture_as_pdf, color: AppTheme.accentRed, size: 28),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(doc['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text('${doc['date']} • ${doc['pages']}', style: Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.search, color: AppTheme.accentBlue),
                            onPressed: () {
                              // OCR View Dialogue Mock
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: AppTheme.surface,
                                    title: const Text('OCR Text Preview'),
                                    content: const SingleChildScrollView(
                                      child: Text(
                                        'Extracted text from Document:\n\n[LifeHub AI Project Architecture Specification]\n- Frontend: Flutter\n- Backend: ASP.NET Core 9\n- Database: PostgreSQL\n- Cache: Redis\n- Cloud storage: AWS S3',
                                        style: TextStyle(fontFamily: 'monospace'),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(icon: const Icon(Icons.more_vert, color: AppTheme.textSecondary), onPressed: () {}),
                        ],
                      )
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
        onPressed: _startScan,
        child: const Icon(Icons.document_scanner, color: Colors.white),
      ),
    );
  }
}
