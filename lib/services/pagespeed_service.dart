import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/performance_result.dart';

class PageSpeedService {
  static const String baseUrl =
      'https://www.googleapis.com/pagespeedonline/v5/runPagespeed';
  
  static String? _apiKey;
  
  static Future<void> initialize() async {
    try {
      await dotenv.load(fileName: ".env");
      _apiKey = dotenv.env['GOOGLE_PAGESPEED_API_KEY'];
    } catch (e) {
      // Fallback to hardcoded key for demo purposes
      _apiKey = 'AIzaSyAmbZLUJGRVZT5MdTELt8c8MI_VlcwO9tU';
    }
  }

  Future<PerformanceResult> analyzeWebsite(String url) async {
    if (_apiKey == null) {
      await initialize();
    }
    
    if (_apiKey == null || _apiKey!.isEmpty) {
      throw Exception('API key not configured. Please check your .env file.');
    }

    // Ensure URL has protocol
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    try {
      final uri = Uri.parse(baseUrl).replace(queryParameters: {
        'url': url,
        'key': _apiKey!,
        'category': ['performance', 'accessibility', 'best-practices', 'seo'],
        'strategy': 'mobile',
      });

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'SiteGleam/1.0',
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Request timeout. Please try again.');
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        // Check if the response contains the expected data
        if (data['lighthouseResult'] == null) {
          throw Exception('Invalid response from PageSpeed API');
        }
        
        return PerformanceResult.fromJson(data);
      } else if (response.statusCode == 400) {
        final errorData = json.decode(response.body);
        final errorMessage = errorData['error']?['message'] ?? 'Invalid request';
        throw Exception('Bad request: $errorMessage');
      } else if (response.statusCode == 403) {
        throw Exception('API key is invalid or quota exceeded');
      } else if (response.statusCode == 429) {
        throw Exception('Rate limit exceeded. Please try again later.');
      } else {
        throw Exception('Failed to analyze website (${response.statusCode})');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.');
    } on FormatException {
      throw Exception('Invalid response format from server');
    } on Exception catch (e) {
      if (e.toString().contains('timeout')) {
        throw Exception('Request timeout. The website might be slow to respond.');
      }
      rethrow;
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
