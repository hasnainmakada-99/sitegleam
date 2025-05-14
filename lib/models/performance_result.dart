// filepath: d:\Flutter Projects\sitegleam\lib\models\performance_result.dart
class PerformanceResult {
  final String url;
  final double performanceScore;
  final double accessibilityScore;
  final double bestPracticesScore;
  final double seoScore;
  final Map<String, dynamic> metrics;
  final DateTime analyzedAt;

  PerformanceResult({
    required this.url,
    required this.performanceScore,
    required this.accessibilityScore,
    required this.bestPracticesScore,
    required this.seoScore,
    required this.metrics,
    required this.analyzedAt,
  });

  factory PerformanceResult.fromJson(Map<String, dynamic> json) {
    final categories = json['lighthouseResult']['categories'];

    return PerformanceResult(
      url: json['id'] ?? '',
      performanceScore: categories['performance']['score'] * 100,
      accessibilityScore: categories['accessibility']['score'] * 100,
      bestPracticesScore: categories['best-practices']['score'] * 100,
      seoScore: categories['seo']['score'] * 100,
      metrics: json['lighthouseResult']['audits'] ?? {},
      analyzedAt: DateTime.now(),
    );
  }
}
