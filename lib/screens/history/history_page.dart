import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<dynamic> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    try {
      final data = await ApiService.getHistory();

      if (!mounted) return;

      setState(() {
        items = data;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> refreshData() async {
    await loadHistory();
  }

  IconData getIcon(String action) {
    final text = action.toLowerCase();

    if (text.contains('water')) {
      return Icons.water_drop;
    }

    if (text.contains('electric')) {
      return Icons.bolt;
    }

    if (text.contains('waste')) {
      return Icons.delete;
    }

    return Icons.history;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : items.isEmpty
              ? const Center(
                  child: Text('No history found'),
                )
              : RefreshIndicator(
                  onRefresh: refreshData,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final item = items[i];

                      return _HistoryCard(
                        title:
                            item['action'] ?? '',
                        location:
                            item['details'] ?? '',
                        date:
                            item['created_at'] ?? '',
                        value:
                            '#${item['id']}',
                        icon: getIcon(
                          item['action'] ?? '',
                        ),
                      );
                    },
                  ),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
                Text(
                  date,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                ),
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