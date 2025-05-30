import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/performance_result.dart';
import '../widgets/performance_card.dart';
import '../config/theme.dart';

class ResultsScreen extends StatelessWidget {
  final PerformanceResult result;

  const ResultsScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat('MMM d, yyyy • h:mm a');
    final isSmallScreen = AppTheme.isMobile(context);
    final isTablet = AppTheme.isTablet(context);
    final isDesktop = AppTheme.isDesktop(context);
    final responsivePadding = AppTheme.getResponsivePadding(context);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Analysis Results',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppTheme.getResponsiveFontSize(context, 20),
          ),
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
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 1200 : double.infinity,
              ),
              child: Padding(
                padding: EdgeInsets.all(responsivePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context, colorScheme, dateFormat),
                    _buildScoreOverview(context, colorScheme),
                    _buildScoreCards(context),
                    _buildDetailedMetrics(context, colorScheme),
                    const SizedBox(height: 80), // Bottom padding for FAB
                  ],
                ),
              ),
            ),
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
    final isSmallScreen = AppTheme.isMobile(context);
    
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
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(isSmallScreen ? 16.0 : 20.0),
      margin: const EdgeInsets.only(bottom: 24),
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
                        fontSize: AppTheme.getResponsiveFontSize(context, 14),
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
              style: TextStyle(
                fontSize: AppTheme.getResponsiveFontSize(context, 24),
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
                      fontSize: AppTheme.getResponsiveFontSize(context, 14),
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
  ) {
    final overallScore = result.overallScore;
    final isSmallScreen = AppTheme.isMobile(context);

    // Adapt circle size based on screen size
    final circleSize = isSmallScreen ? 100.0 : 120.0;
    final fontSize = AppTheme.getResponsiveFontSize(context, 36);

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: EdgeInsets.all(AppTheme.getResponsivePadding(context, 24)),
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
                      overallScore.toInt().toString(),
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: _getScoreColor(overallScore),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      result.scoreLabel,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 12 : 14,
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
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
                    fontSize: AppTheme.getResponsiveFontSize(context, 24),
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Average of all metrics',
                  style: TextStyle(
                    fontSize: AppTheme.getResponsiveFontSize(context, 16),
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
                    result.scoreDescription,
                    style: TextStyle(
                      fontSize: AppTheme.getResponsiveFontSize(context, 14),
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
  ) {
    final isSmallScreen = AppTheme.isMobile(context);
    final isTablet = AppTheme.isTablet(context);
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Performance Metrics',
          style: TextStyle(
            fontSize: AppTheme.getResponsiveFontSize(context, 22),
            fontWeight: FontWeight.bold,
          ),
        ),
          const SizedBox(height: 16),
          isSmallScreen
              ? Column(
                children:
                    metrics
                        .map(
                          (metric) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
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
  ) {
    final isSmallScreen = AppTheme.isMobile(context);
    final metrics = [
      {
        'name': 'First Contentful Paint',
        'value': result.detailedMetrics['First Contentful Paint'] ?? 'N/A',
        'impact': _getMetricImpact(result.detailedMetrics['First Contentful Paint']),
        'icon': Icons.flash_on_rounded,
      },
      {
        'name': 'Time to Interactive',
        'value': result.detailedMetrics['Time to Interactive'] ?? 'N/A',
        'impact': _getMetricImpact(result.detailedMetrics['Time to Interactive']),
        'icon': Icons.touch_app_rounded,
      },
      {
        'name': 'Largest Contentful Paint',
        'value': result.detailedMetrics['Largest Contentful Paint'] ?? 'N/A',
        'impact': _getMetricImpact(result.detailedMetrics['Largest Contentful Paint']),
        'icon': Icons.image_rounded,
      },
      {
        'name': 'Cumulative Layout Shift',
        'value': result.detailedMetrics['Cumulative Layout Shift'] ?? 'N/A',
        'impact': _getMetricImpact(result.detailedMetrics['Cumulative Layout Shift']),
        'icon': Icons.swap_vert_rounded,
      },
      {
        'name': 'Speed Index',
        'value': result.detailedMetrics['Speed Index'] ?? 'N/A',
        'impact': _getMetricImpact(result.detailedMetrics['Speed Index']),
        'icon': Icons.speed_rounded,
      },
      {
        'name': 'Total Blocking Time',
        'value': result.detailedMetrics['Total Blocking Time'] ?? 'N/A',
        'impact': _getMetricImpact(result.detailedMetrics['Total Blocking Time']),
        'icon': Icons.block_rounded,
      },
    ];

    return Container(
      margin: const EdgeInsets.only(top: 24),
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
            padding: EdgeInsets.all(AppTheme.getResponsivePadding(context, 20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Detailed Metrics',
                  style: TextStyle(
                    fontSize: AppTheme.getResponsiveFontSize(context, 22),
                    fontWeight: FontWeight.bold,
                  ),
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
            (metric) => _buildMetricItem(metric, colorScheme),
          ),
          Padding(
            padding: EdgeInsets.all(AppTheme.getResponsivePadding(context, 20)),
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
  ) {
    final isSmallScreen = AppTheme.isMobile(context);
    
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppTheme.getResponsivePadding(context, 16),
        vertical: AppTheme.getResponsivePadding(context, 6),
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
          size: AppTheme.getResponsiveFontSize(context, 20),
        ),
      ),
      title: Text(
        metric['name'] as String,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: AppTheme.getResponsiveFontSize(context, 16),
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
            fontSize: AppTheme.getResponsiveFontSize(context, 14),
            color: _getImpactColor(metric['impact'] as String),
          ),
        ),
      ),
    );
  }

  String _getMetricImpact(dynamic value) {
    if (value == null || value == 'N/A') return 'Unknown';
    
    final valueStr = value.toString().toLowerCase();
    
    // For time-based metrics (seconds)
    if (valueStr.contains('s') && !valueStr.contains('ms')) {
      final timeValue = double.tryParse(valueStr.replaceAll(RegExp(r'[^0-9.]'), ''));
      if (timeValue != null) {
        if (timeValue <= 1.5) return 'Low';
        if (timeValue <= 3.0) return 'Medium';
        return 'High';
      }
    }
    
    // For CLS (Cumulative Layout Shift)
    if (!valueStr.contains('s') && !valueStr.contains('ms')) {
      final clsValue = double.tryParse(valueStr.replaceAll(RegExp(r'[^0-9.]'), ''));
      if (clsValue != null) {
        if (clsValue <= 0.1) return 'Low';
        if (clsValue <= 0.25) return 'Medium';
        return 'High';
      }
    }
    
    return 'Medium'; // Default fallback
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
