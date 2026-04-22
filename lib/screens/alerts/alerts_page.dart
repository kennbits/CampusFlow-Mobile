import 'package:flutter/material.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Alerts')),
      body: ListView(
        padding:
            const EdgeInsets.all(16),
        children: const [
          _AlertCard(
            title: 'Water reading due today',
            message:
                'Please submit Deep Well readings before 5:00 PM.',
            icon: Icons.water_drop,
            color: Colors.blue,
          ),
          SizedBox(height: 12),
          _AlertCard(
            title: 'Electric reading pending',
            message:
                'SSC electric reading is still pending review.',
            icon: Icons.bolt,
            color: Colors.orange,
          ),
          SizedBox(height: 12),
          _AlertCard(
            title: 'Waste report rejected',
            message:
                'Residual waste submission needs correction.',
            icon: Icons.delete,
            color: Colors.red,
          ),
          SizedBox(height: 12),
          _AlertCard(
            title: 'System Notice',
            message:
                'CampusFlow maintenance scheduled this weekend.',
            icon: Icons.info,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color color;

  const _AlertCard({
    required this.title,
    required this.message,
    required this.icon,
    required this.color,
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
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
                const SizedBox(height: 6),
                Text(message),
              ],
            ),
          ),
        ],
      ),
    );
  }
}