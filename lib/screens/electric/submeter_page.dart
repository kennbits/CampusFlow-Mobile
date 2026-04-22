import 'package:flutter/material.dart';
import 'meter_form_page.dart';

class SubmeterPage extends StatelessWidget {
  const SubmeterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bgColor =
        Theme.of(context)
            .scaffoldBackgroundColor;

    final cardColor =
        Theme.of(context).cardColor;

    final textColor =
        Theme.of(context)
            .textTheme
            .bodyLarge
            ?.color ??
        Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: Padding(
          padding:
              const EdgeInsets.all(8),
          child: Container(
            decoration:
                const BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () =>
                  Navigator.pop(context),
            ),
          ),
        ),
        title: const Text(
          'SUBMETER',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight:
                FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.all(18),
          child: ListView(
            children: [
              const SizedBox(height: 8),

              Container(
                padding:
                    const EdgeInsets.all(
                        14),
                decoration:
                    BoxDecoration(
                  color: cardColor,
                  borderRadius:
                      BorderRadius.circular(
                          14),
                ),
                child: Center(
                  child: Text(
                    'SELECT LOCATION',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                          FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              _LocationButton(
                label: 'STEERHUB',
                page:
                    const MeterFormPage(
                  title: 'STEERHUB',
                ),
              ),

              const SizedBox(height: 14),

              _LocationButton(
                label:
                    'ALBERT EINSTEIN',
                page:
                    const MeterFormPage(
                  title:
                      'ALBERT EINSTEIN',
                ),
              ),

              const SizedBox(height: 14),

              _LocationButton(
                label: 'AUTOMOTIVE',
                page:
                    const MeterFormPage(
                  title:
                      'AUTOMOTIVE',
                ),
              ),

              const SizedBox(height: 14),

              _LocationButton(
                label: 'CET',
                page:
                    const MeterFormPage(
                  title: 'CET',
                ),
              ),

              const SizedBox(height: 14),

              _LocationButton(
                label: 'RGR',
                page:
                    const MeterFormPage(
                  title: 'RGR',
                ),
              ),

              const SizedBox(height: 14),

              _LocationButton(
                label: 'SSC',
                page:
                    const MeterFormPage(
                  title: 'SSC',
                ),
              ),

              const SizedBox(height: 14),

              _LocationButton(
                label: 'FDC',
                page:
                    const MeterFormPage(
                  title: 'FDC',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocationButton extends StatelessWidget {
  final String label;
  final Widget page;

  const _LocationButton({required this.label, required this.page, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => page,
            ),
          );
        },
        style:
            ElevatedButton.styleFrom(
          backgroundColor:
              Colors.redAccent,
          elevation: 10,
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
                    22),
          ),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor:
                  Colors.white24,
              child: Icon(
                Icons.bolt,
                color: Colors.white,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                label,
                style:
                    const TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                  color:
                      Colors.white,
                ),
              ),
            ),

            const Icon(
              Icons.chevron_right,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}