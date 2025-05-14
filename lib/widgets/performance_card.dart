import 'package:flutter/material.dart';

class PerformanceCard extends StatelessWidget {
  final String title;
  final double score;
  final Color color;

  const PerformanceCard({
    super.key,
    required this.title,
    required this.score,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              radius: 24,
              child: Text(
                '${score.toInt()}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Icon(
              score >= 90
                  ? Icons.check_circle
                  : score >= 50
                  ? Icons.warning
                  : Icons.error,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
