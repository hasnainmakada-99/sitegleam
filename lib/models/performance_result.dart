class PerformanceResult {
  final String url;
  final double performanceScore;
  final double accessibilityScore;
  final double bestPracticesScore;
  final double seoScore;
  final Map<String, dynamic> metrics;
  final DateTime analyzedAt;
  final Map<String, dynamic> detailedMetrics;

  PerformanceResult({
    required this.url,
    required this.performanceScore,
    required this.accessibilityScore,
    required this.bestPracticesScore,
    required this.seoScore,
    required this.metrics,
    required this.analyzedAt,
    required this.detailedMetrics,
  });

  factory PerformanceResult.fromJson(Map<String, dynamic> json) {
    try {
      final lighthouseResult = json['lighthouseResult'] as Map<String, dynamic>?;
      if (lighthouseResult == null) {
        throw Exception('Invalid lighthouse result');
      }

      final categories = lighthouseResult['categories'] as Map<String, dynamic>?;
      if (categories == null) {
        throw Exception('Invalid categories data');
      }

      final audits = lighthouseResult['audits'] as Map<String, dynamic>? ?? {};

      // Extract detailed metrics with null safety
      final detailedMetrics = <String, dynamic>{};
      
      // First Contentful Paint
      final fcp = audits['first-contentful-paint']?['displayValue'] ?? 'N/A';
      detailedMetrics['First Contentful Paint'] = fcp;
      
      // Time to Interactive
      final tti = audits['interactive']?['displayValue'] ?? 'N/A';
      detailedMetrics['Time to Interactive'] = tti;
      
      // Largest Contentful Paint
      final lcp = audits['largest-contentful-paint']?['displayValue'] ?? 'N/A';
      detailedMetrics['Largest Contentful Paint'] = lcp;
      
      // Cumulative Layout Shift
      final cls = audits['cumulative-layout-shift']?['displayValue'] ?? 'N/A';
      detailedMetrics['Cumulative Layout Shift'] = cls;
      
      // Speed Index
      final si = audits['speed-index']?['displayValue'] ?? 'N/A';
      detailedMetrics['Speed Index'] = si;
      
      // Total Blocking Time
      final tbt = audits['total-blocking-time']?['displayValue'] ?? 'N/A';
      detailedMetrics['Total Blocking Time'] = tbt;

      return PerformanceResult(
        url: json['id'] as String? ?? '',
        performanceScore: _extractScore(categories['performance']),
        accessibilityScore: _extractScore(categories['accessibility']),
        bestPracticesScore: _extractScore(categories['best-practices']),
        seoScore: _extractScore(categories['seo']),
        metrics: audits,
        analyzedAt: DateTime.now(),
        detailedMetrics: detailedMetrics,
      );
    } catch (e) {
      throw Exception('Failed to parse performance result: $e');
    }
  }

  static double _extractScore(dynamic category) {
    if (category == null) return 0.0;
    final score = category['score'];
    if (score == null) return 0.0;
    if (score is num) {
      return (score * 100).toDouble();
    }
    return 0.0;
  }

  double get overallScore {
    return (performanceScore + accessibilityScore + bestPracticesScore + seoScore) / 4;
  }

  String get scoreLabel {
    final score = overallScore;
    if (score >= 90) return 'Excellent';
    if (score >= 70) return 'Good';
    if (score >= 50) return 'Fair';
    return 'Poor';
  }

  String get scoreDescription {
    final score = overallScore;
    if (score >= 90) return 'Your site is performing exceptionally well!';
    if (score >= 70) return 'Good performance with room for improvement';
    if (score >= 50) return 'Several issues need addressing';
    return 'Major performance problems detected';
  }
}
