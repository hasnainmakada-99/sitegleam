import 'package:flutter/material.dart';
import '../models/performance_result.dart';
import '../widgets/performance_card.dart';

class ResultsScreen extends StatelessWidget {
  final PerformanceResult result;

  const ResultsScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analysis Results')),
      body: RefreshIndicator(
        onRefresh: () async {
          // Implement refresh functionality here
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Results for ${result.url}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Analyzed at: ${result.analyzedAt.toString()}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 24),
                PerformanceCard(
                  title: 'Performance',
                  score: result.performanceScore,
                  color: _getScoreColor(result.performanceScore),
                ),
                const SizedBox(height: 16),
                PerformanceCard(
                  title: 'Accessibility',
                  score: result.accessibilityScore,
                  color: _getScoreColor(result.accessibilityScore),
                ),
                const SizedBox(height: 16),
                PerformanceCard(
                  title: 'Best Practices',
                  score: result.bestPracticesScore,
                  color: _getScoreColor(result.bestPracticesScore),
                ),
                const SizedBox(height: 16),
                PerformanceCard(
                  title: 'SEO',
                  score: result.seoScore,
                  color: _getScoreColor(result.seoScore),
                ),
                const SizedBox(height: 32),
                // Add more detailed metrics here
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 90) return Colors.green;
    if (score >= 50) return Colors.orange;
    return Colors.red;
  }
}
