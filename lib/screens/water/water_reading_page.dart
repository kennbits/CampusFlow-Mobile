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
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.arrow_back, color: Colors.white, size: 24),
            ),
          ),
        ),
        title: const Text(
          'WATER',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Faded background with bsu.jpg
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/bsu.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.65),
                    BlendMode.modulate,
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'SELECT WATER SOURCE',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: ListView(
                      children: [
                        _WaterMenuButton(
                          label: 'Prime Water',
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

                        const SizedBox(height: 14),

                        _WaterMenuButton(
                          label: 'Deep Well 1',
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

                        const SizedBox(height: 14),

                        _WaterMenuButton(
                          label: 'Deep Well 2',
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

                        const SizedBox(height: 14),

                        _WaterMenuButton(
                          label: 'Deep Well 3',
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

                        const SizedBox(height: 14),

                        _WaterMenuButton(
                          label: 'Deep Well 4',
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WaterMenuButton extends StatelessWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const _WaterMenuButton({
    required this.label,
    required this.onTap,
    this.isPrimary = false,
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
                  fontSize: 22,
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