import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkService {
  // Use 10.0.2.2 for Android Emulator, localhost for iOS simulator/desktop
  static const String baseUrl = 'http://localhost:5253/api'; 

  static Future<Map<String, dynamic>?> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (e) {
      // Network/Server error log
      print('NetworkService Error: $e');
    }
    return null;
  }
}
