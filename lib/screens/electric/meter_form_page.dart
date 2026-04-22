import 'package:flutter/material.dart';

class MeterFormPage extends StatefulWidget {
  final String title;

  const MeterFormPage({
    super.key,
    required this.title,
  });

  @override
  State<MeterFormPage> createState() => _MeterFormPageState();
}

class _MeterFormPageState extends State<MeterFormPage> {
  final readingController = TextEditingController();
  final remarksController = TextEditingController();

  void submit() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.title} submitted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: readingController,
              decoration: const InputDecoration(
                labelText: 'Reading',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: remarksController,
              decoration: const InputDecoration(
                labelText: 'Remarks',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: submit,
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}