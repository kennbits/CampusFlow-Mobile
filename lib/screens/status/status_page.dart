import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() =>
      _StatusPageState();
}

class _StatusPageState
    extends State<StatusPage> {
  List<Map<String, dynamic>> items = [
    {
      'title': 'Water Reading',
      'date': 'Apr 22, 2026',
      'status': 'Approved',
      'icon': Icons.water_drop,
    },
    {
      'title': 'Electric Reading',
      'date': 'Apr 22, 2026',
      'status': 'Pending',
      'icon': Icons.bolt,
    },
    {
      'title': 'Waste Submission',
      'date': 'Apr 21, 2026',
      'status': 'Rejected',
      'icon': Icons.delete,
    },
  ];

  Future<void> refreshData() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    setState(() {
      items = List.from(items);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Status')),
      body: items.isEmpty
          ? const _EmptyState(
              icon: Icons.pending_actions,
              title: 'No status records',
              subtitle:
                  'Your latest submissions will appear here.',
            )
          : RefreshIndicator(
              onRefresh: refreshData,
              child: ListView.separated(
                padding:
                    const EdgeInsets.all(16),
                itemCount: items.length,
                separatorBuilder:
                    (_, __) =>
                        const SizedBox(
                            height: 12),
                itemBuilder:
                    (context, i) {
                  final item = items[i];

                  return _StatusCard(
                    title: item['title'],
                    date: item['date'],
                    status: item['status'],
                    icon: item['icon'],
                  );
                },
              ),
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
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.redAccent,
          ),
          const SizedBox(width: 12),

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
                  ),
                ),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _EmptyState({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                color:
                    Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}