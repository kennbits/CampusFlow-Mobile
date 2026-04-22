import 'package:flutter/material.dart';
import 'prime_water.dart';
import 'deep_well_1.dart';
import 'deep_well_2.dart';
import 'deep_well_3.dart';
import 'deep_well_4.dart';

class WaterReadingPage extends StatelessWidget {
  const WaterReadingPage({super.key});

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
          'WATER',
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
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(16),
              color: cardColor,
              child: Center(
                child: Text(
                  'SELECT WATER SOURCE',
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
                padding:
                    const EdgeInsets.all(
                        18),
                children: [
                  SizedBox(
                    height: 95,
                    child:
                        _WaterMenuButton(
                      label:
                          'Prime Water',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const PrimeWaterPage(),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(
                      height: 14),

                  SizedBox(
                    height: 95,
                    child:
                        _WaterMenuButton(
                      label:
                          'Deep Well 1',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const DeepWell1Page(),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(
                      height: 14),

                  SizedBox(
                    height: 95,
                    child:
                        _WaterMenuButton(
                      label:
                          'Deep Well 2',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const DeepWell2Page(),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(
                      height: 14),

                  SizedBox(
                    height: 95,
                    child:
                        _WaterMenuButton(
                      label:
                          'Deep Well 3',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const DeepWell3Page(),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(
                      height: 14),

                  SizedBox(
                    height: 95,
                    child:
                        _WaterMenuButton(
                      label:
                          'Deep Well 4',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const DeepWell4Page(),
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

class _WaterMenuButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _WaterMenuButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 74,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(24),
          ),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 22,
              backgroundColor:
                  Colors.white24,
              child: Icon(
                Icons.water_drop,
                color: Colors.white,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight:
                      FontWeight.bold,
                  color: Colors.white,
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