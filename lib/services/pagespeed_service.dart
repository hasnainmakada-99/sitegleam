import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/performance_result.dart';

class PageSpeedService {
  // You should replace this with your actual API key
  static const String apiKey = 'AIzaSyAmbZLUJGRVZT5MdTELt8c8MI_VlcwO9tU';
  static const String baseUrl =
      'https://www.googleapis.com/pagespeedonline/v5/runPagespeed';

  Future<PerformanceResult> analyzeWebsite(String url) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl?url=$url&key=$apiKey&category=performance&category=accessibility&category=best-practices&category=seo',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return PerformanceResult.fromJson(data);
      } else {
        throw Exception('Failed to analyze website: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error analyzing website: $e');
    }
  }
}
