import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/performance_result.dart';
import '../widgets/performance_card.dart';

class ResultsScreen extends StatelessWidget {
  final PerformanceResult result;

  const ResultsScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat('MMM d, yyyy • h:mm a');
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // More nuanced responsiveness breakpoints
    final isSmallScreen = screenWidth < 360;
    final isMediumScreen = screenWidth >= 360 && screenWidth < 600;
    final isLargeScreen = screenWidth >= 600;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Analysis Results',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded),
            tooltip: 'Share results',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Share functionality coming soon'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Implement refresh functionality here
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, colorScheme, dateFormat),
              _buildScoreOverview(context, colorScheme, isSmallScreen),
              _buildScoreCards(context, isSmallScreen, isMediumScreen),
              _buildDetailedMetrics(context, colorScheme, isSmallScreen),
              // Add bottom padding to ensure FAB doesn't cover content
              SizedBox(height: screenHeight * 0.08),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Reanalyze functionality coming soon'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        icon: const Icon(Icons.refresh_rounded),
        label: const Text('Reanalyze'),
        tooltip: 'Reanalyze website',
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    ColorScheme colorScheme,
    DateFormat dateFormat,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primaryContainer,
            colorScheme.primaryContainer.withOpacity(0.8),
          ],
        ),
      ),
      padding: const EdgeInsets.all(20.0),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.public_rounded,
                    size: 16,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      result.url,
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Website Analysis Results',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
              semanticsLabel: 'Website Analysis Results',
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 16,
                  color: colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    dateFormat.format(result.analyzedAt),
                    style: TextStyle(
                      color: colorScheme.secondary,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreOverview(
    BuildContext context,
    ColorScheme colorScheme,
    bool isSmallScreen,
  ) {
    final overallScore =
        (result.performanceScore +
            result.accessibilityScore +
            result.bestPracticesScore +
            result.seoScore) /
        4;

    // Adapt circle size based on screen size
    final circleSize = isSmallScreen ? 100.0 : 120.0;
    final fontSize = isSmallScreen ? 30.0 : 36.0;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 32, 16, 16),
      padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            height: circleSize,
            width: circleSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: overallScore / 100,
                  strokeWidth: isSmallScreen ? 8 : 5,
                  backgroundColor: colorScheme.surfaceVariant,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getScoreColor(overallScore),
                  ),

                  semanticsLabel: 'Overall score $overallScore out of 100',
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "",

                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: _getScoreColor(overallScore),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _getScoreLabel(overallScore),
                      style: TextStyle(
                        fontSize: isSmallScreen ? 12 : 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: isSmallScreen ? 16 : 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overall Score',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 20 : 24,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Average of all metrics',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getScoreColor(overallScore).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getScoreDescription(overallScore),
                    style: TextStyle(
                      fontSize: isSmallScreen ? 12 : 14,
                      color: _getScoreColor(overallScore),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCards(
    BuildContext context,
    bool isSmallScreen,
    bool isMediumScreen,
  ) {
    final metrics = [
      {
        'title': 'Performance',
        'score': result.performanceScore,
        'icon': Icons.speed_rounded,
      },
      {
        'title': 'Accessibility',
        'score': result.accessibilityScore,
        'icon': Icons.accessibility_new_rounded,
      },
      {
        'title': 'Best Practices',
        'score': result.bestPracticesScore,
        'icon': Icons.check_circle_rounded,
      },
      {
        'title': 'SEO',
        'score': result.seoScore,
        'icon': Icons.trending_up_rounded,
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Metrics',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: isSmallScreen ? 12 : 16),
          isSmallScreen
              ? Column(
                children:
                    metrics
                        .map(
                          (metric) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: PerformanceCard(
                              title: metric['title'] as String,
                              score: metric['score'] as double,
                              color: _getScoreColor(metric['score'] as double),
                              icon: metric['icon'] as IconData,
                            ),
                          ),
                        )
                        .toList(),
              )
              : Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: PerformanceCard(
                          title: metrics[0]['title'] as String,
                          score: metrics[0]['score'] as double,
                          color: _getScoreColor(metrics[0]['score'] as double),
                          icon: metrics[0]['icon'] as IconData,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: PerformanceCard(
                          title: metrics[1]['title'] as String,
                          score: metrics[1]['score'] as double,
                          color: _getScoreColor(metrics[1]['score'] as double),
                          icon: metrics[1]['icon'] as IconData,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: PerformanceCard(
                          title: metrics[2]['title'] as String,
                          score: metrics[2]['score'] as double,
                          color: _getScoreColor(metrics[2]['score'] as double),
                          icon: metrics[2]['icon'] as IconData,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: PerformanceCard(
                          title: metrics[3]['title'] as String,
                          score: metrics[3]['score'] as double,
                          color: _getScoreColor(metrics[3]['score'] as double),
                          icon: metrics[3]['icon'] as IconData,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
        ],
      ),
    );
  }

  Widget _buildDetailedMetrics(
    BuildContext context,
    ColorScheme colorScheme,
    bool isSmallScreen,
  ) {
    final metrics = [
      {
        'name': 'First Contentful Paint',
        'value': '1.8s',
        'impact': 'Low',
        'icon': Icons.flash_on_rounded,
      },
      {
        'name': 'Time to Interactive',
        'value': '3.2s',
        'impact': 'Medium',
        'icon': Icons.touch_app_rounded,
      },
      {
        'name': 'Largest Contentful Paint',
        'value': '2.4s',
        'impact': 'High',
        'icon': Icons.image_rounded,
      },
      {
        'name': 'Cumulative Layout Shift',
        'value': '0.05',
        'impact': 'Low',
        'icon': Icons.swap_vert_rounded,
      },
    ];

    return Container(
      margin: EdgeInsets.fromLTRB(
        isSmallScreen ? 12 : 16,
        24,
        isSmallScreen ? 12 : 16,
        32,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Detailed Metrics',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: () {
                    // Implement view all metrics
                  },
                  icon: const Icon(Icons.analytics_rounded),
                  label: const Text('View All'),
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...metrics.map(
            (metric) => _buildMetricItem(metric, colorScheme, isSmallScreen),
          ),
          Padding(
            padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
            child: OutlinedButton.icon(
              onPressed: () {
                // Implement download report
              },
              icon: const Icon(Icons.download_rounded),
              label: const Text('Download Full Report'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                foregroundColor: colorScheme.primary,
                side: BorderSide(color: colorScheme.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(
    Map<String, dynamic> metric,
    ColorScheme colorScheme,
    bool isSmallScreen,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12 : 16,
        vertical: isSmallScreen ? 4 : 6,
      ),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _getImpactColor(metric['impact'] as String).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          metric['icon'] as IconData,
          color: _getImpactColor(metric['impact'] as String),
          size: isSmallScreen ? 18 : 20,
        ),
      ),
      title: Text(
        metric['name'] as String,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: isSmallScreen ? 14 : 16,
          color: colorScheme.onSurface,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _getImpactColor(metric['impact'] as String).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          metric['value'] as String,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: isSmallScreen ? 13 : 14,
            color: _getImpactColor(metric['impact'] as String),
          ),
        ),
      ),
    );
  }

  String _getScoreLabel(double score) {
    if (score >= 90) return 'Excellent';
    if (score >= 70) return 'Good';
    if (score >= 50) return 'Fair';
    return 'Poor';
  }

  String _getScoreDescription(double score) {
    if (score >= 90) return 'Your site is performing exceptionally well!';
    if (score >= 70) return 'Good performance with room for improvement';
    if (score >= 50) return 'Several issues need addressing';
    return 'Major performance problems detected';
  }

  Color _getScoreColor(double score) {
    if (score >= 90) return Colors.green;
    if (score >= 70) return Colors.lightGreen;
    if (score >= 50) return Colors.orange;
    return Colors.red;
  }

  Color _getImpactColor(String impact) {
    switch (impact) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }
}
