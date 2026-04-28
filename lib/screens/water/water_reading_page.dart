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
    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? const [
                    Color(0xFF111111),
                    Color(0xFF1A1A1A),
                  ]
                : const [
                    Color(0xFFF6F7FB),
                    Colors.white,
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding:
                    const EdgeInsets.all(
                        18),
                child: Row(
                  children: [
                    InkWell(
                      borderRadius:
                          BorderRadius
                              .circular(
                                  50),
                      onTap: () =>
                          Navigator.pop(
                              context),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration:
                            const BoxDecoration(
                          color: Color(
                            0xFFED1B2F,
                          ),
                          shape: BoxShape
                              .circle,
                        ),
                        child:
                            const Icon(
                          Icons
                              .arrow_back,
                          color: Colors
                              .white,
                        ),
                      ),
                    ),

                    const Expanded(
                      child: Center(
                        child: Text(
                          'WATER',
                          style:
                              TextStyle(
                            fontSize:
                                28,
                            fontWeight:
                                FontWeight
                                    .w700,
                            color: Color(
                              0xFFED1B2F,
                            ),
                            letterSpacing:
                                1,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                        width: 48),
                  ],
                ),
              ),

              const SizedBox(
                  height: 6),

              const Text(
                'Choose Water Source',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  fontWeight:
                      FontWeight.w500,
                ),
              ),

              const SizedBox(
                  height: 22),

              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 20,
                  ),
                  children: [
                    _WaterCard(
                      title:
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

                    const SizedBox(
                        height: 16),

                    _WaterCard(
                      title:
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

                    const SizedBox(
                        height: 16),

                    _WaterCard(
                      title:
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

                    const SizedBox(
                        height: 16),

                    _WaterCard(
                      title:
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

                    const SizedBox(
                        height: 16),

                    _WaterCard(
                      title:
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

                    const SizedBox(
                        height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WaterCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _WaterCard({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius:
          BorderRadius.circular(
              24),
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.all(
                18),
        decoration:
            BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius
                  .circular(24),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 18,
              offset:
                  Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 62,
              height: 62,
              decoration:
                  const BoxDecoration(
                color: Color(
                  0xFFEAF3FF,
                ),
                shape:
                    BoxShape.circle,
              ),
              child: const Icon(
                Icons.water_drop,
                color: Colors.blue,
                size: 30,
              ),
            ),

            const SizedBox(
                width: 16),

            Expanded(
              child: Text(
                title,
                style:
                    const TextStyle(
                  fontSize: 23,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),
            ),

            const Icon(
              Icons
                  .arrow_forward_ios,
              size: 18,
              color: Color(
                0xFFED1B2F,
              ),
            ),
          ],
        ),
      ),
    );
  }
}