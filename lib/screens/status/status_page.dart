import 'package:flutter/material.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Status')),
      body: ListView(
        padding:
            const EdgeInsets.all(16),
        children: const [
          _StatusCard(
            title: 'Water Reading',
            date: 'Apr 22, 2026',
            status: 'Approved',
            icon: Icons.water_drop,
          ),
          SizedBox(height: 12),
          _StatusCard(
            title: 'Electric Reading',
            date: 'Apr 22, 2026',
            status: 'Pending',
            icon: Icons.bolt,
          ),
          SizedBox(height: 12),
          _StatusCard(
            title: 'Waste Submission',
            date: 'Apr 21, 2026',
            status: 'Rejected',
            icon: Icons.delete,
          ),
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final String title;
  final String date;
  final String status;
  final IconData icon;

  const _StatusCard({
    required this.title,
    required this.date,
    required this.status,
    required this.icon,
  });

  Color get badgeColor {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

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
                Text(date),
              ],
            ),
          ),

          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius:
                  BorderRadius.circular(
                      20),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: Colors.white,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}