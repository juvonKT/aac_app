import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class ApiService {
  // final String _baseUrl = 'http://10.0.2.2:5001';  // For Android emulator
  final String _baseUrl = 'http://192.168.0.170:5001';

  Future<String> testConnection() async {
    final url = Uri.parse('$_baseUrl/test');
    print("Testing connection to $url");
    try {
      final response = await http.get(url);
      print("Test response status code: ${response.statusCode}");
      print("Test response body: ${response.body}");
      if (response.statusCode == 200) {
        return json.decode(response.body)['message'];
      } else {
        throw Exception('Failed to connect: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in testConnection: $e');
      throw Exception('Connection test failed: $e');
    }
  }

  Future<List<String>> getSuggestions(List<String> selectedPhrases, String languageCode) async {
    final url = Uri.parse('$_baseUrl/suggest');
    print("Sending request to $url");
    print("Selected phrases: $selectedPhrases");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'selected_phrases': selectedPhrases,
          'language_code': languageCode,  // Include locale in the request
        }),
      );
      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        List<dynamic> suggestions = json.decode(response.body);
        return suggestions.cast<String>();
      } else {
        throw Exception('Failed to load suggestions: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getSuggestions: $e');
      throw Exception('Failed to connect to the server: $e');
    }
  }
}