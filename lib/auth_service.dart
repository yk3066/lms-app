import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const baseUrl = 'https://your-api-url.com'; // Replace with your API URL

  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['token'];
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> signup(
      String name,
      String email,
      String password,
      bool isStudent,
      bool isTeacher,
      ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'isStudent': isStudent,
        'isTeacher': isTeacher,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to signup');
    }
  }
}
