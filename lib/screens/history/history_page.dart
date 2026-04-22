import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('History')),
      body: ListView(
        padding:
            const EdgeInsets.all(16),
        children: const [
          _HistoryCard(
            title: 'Water Reading',
            location: 'Deep Well 1',
            date: 'Apr 22, 2026',
            value: '1250',
            icon: Icons.water_drop,
          ),
          SizedBox(height: 12),
          _HistoryCard(
            title: 'Electric Reading',
            location: 'SSC',
            date: 'Apr 22, 2026',
            value: '4200',
            icon: Icons.bolt,
          ),
          SizedBox(height: 12),
          _HistoryCard(
            title: 'Waste Submission',
            location: 'Residual',
            date: 'Apr 21, 2026',
            value: '8 Bags',
            icon: Icons.delete,
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final String title;
  final String location;
  final String date;
  final String value;
  final IconData icon;

  const _HistoryCard({
    required this.title,
    required this.location,
    required this.date,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            Theme.of(context).cardColor,
        borderRadius:
            BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black12,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.redAccent,
            size: 34,
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(location),
                Text(date),
              ],
            ),
          ),

          Text(
            value,
            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}