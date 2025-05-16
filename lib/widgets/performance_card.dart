import 'package:flutter/material.dart';

class PerformanceCard extends StatelessWidget {
  final String title;
  final double score;
  final Color color;
  final IconData icon;

  const PerformanceCard({
    super.key,
    required this.title,
    required this.score,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Adapt to dark theme better
    final cardColor = isDarkMode ? colorScheme.surface : colorScheme.surface;

    final textColor =
        isDarkMode ? colorScheme.onSurface : colorScheme.onSurface;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 14 : 18,
        vertical: isSmallScreen ? 12 : 16,
      ),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow:
            isDarkMode
                ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
                : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: isSmallScreen ? 16 : 20),
              ),
              SizedBox(width: isSmallScreen ? 8 : 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: score / 100,
                    backgroundColor:
                        isDarkMode
                            ? Colors.grey.shade800
                            : colorScheme.surfaceVariant,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 5, // Thinner progress bar to match design
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                score.toInt().toString(),
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                semanticsLabel: '$title score $score out of 100',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
