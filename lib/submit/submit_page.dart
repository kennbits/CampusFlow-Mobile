import 'package:flutter/material.dart';
import '../screens/water/water_reading_page.dart';
import '../screens/electric/electric_reading_page.dart';
import '../screens/waste/waste_page.dart';

class SubmitPage extends StatelessWidget {
  const SubmitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    final bgColor =
        Theme.of(context).scaffoldBackgroundColor;

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
          'SUBMIT',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight:
                FontWeight.bold,
            fontSize: 28,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(16),
              color: cardColor,
              child: Center(
                child: Text(
                  'SELECT SUBMISSION TYPE',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight:
                        FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(18),
                children: [
                  SizedBox(
                    height: 110,
                    child: _SubmitMenuButton(
                      icon: Icons.water_drop,
                      iconColor: Colors.blue,
                      label: 'Water',
                      textColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const WaterReadingPage(),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    height: 110,
                    child: _SubmitMenuButton(
                      icon: Icons.flash_on,
                      iconColor: Colors.amber,
                      label: 'Electric',
                      textColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const ElectricReadingPage(),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    height: 110,
                    child: _SubmitMenuButton(
                      icon: Icons.delete,
                      iconColor: Colors.black,
                      label: 'Waste',
                      textColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const WastePage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubmitMenuButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final Color textColor;
  final VoidCallback onTap;

  const _SubmitMenuButton({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        elevation: 12,
        shadowColor: Colors.black38,
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(26),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor:
                Colors.white24,
            child: Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          const Icon(
            Icons.chevron_right,
            color: Colors.white,
            size: 30,
          ),
        ],
      ),
    );
  }
}