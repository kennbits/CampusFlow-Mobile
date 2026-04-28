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
                          'SUBMIT',
                          style:
                              TextStyle(
                            fontSize:
                                30,
                            fontWeight:
                                FontWeight
                                    .w700,
                            letterSpacing:
                                1,
                            color: Color(
                              0xFFED1B2F,
                            ),
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
                  height: 8),

              const Text(
                'Choose Submission Type',
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
                    _SubmitCard(
                      title: 'Water',
                      subtitle:
                          'Submit water reading',
                      icon: Icons
                          .water_drop,
                      iconBg:
                          const Color(
                        0xFFEAF3FF,
                      ),
                      iconColor:
                          Colors.blue,
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

                    const SizedBox(
                        height: 16),

                    _SubmitCard(
                      title:
                          'Electric',
                      subtitle:
                          'Submit electric reading',
                      icon: Icons
                          .bolt,
                      iconBg:
                          const Color(
                        0xFFFFF4E5,
                      ),
                      iconColor:
                          Colors.orange,
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

                    const SizedBox(
                        height: 16),

                    _SubmitCard(
                      title: 'Waste',
                      subtitle:
                          'Submit waste report',
                      icon: Icons
                          .delete_outline,
                      iconBg:
                          const Color(
                        0xFFEAF8EC,
                      ),
                      iconColor:
                          Colors.green,
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

class _SubmitCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final VoidCallback onTap;

  const _SubmitCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
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
                  BoxDecoration(
                color: iconBg,
                shape: BoxShape
                    .circle,
              ),
              child: Icon(
                icon,
                color:
                    iconColor,
                size: 30,
              ),
            ),

            const SizedBox(
                width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Text(
                    title,
                    style:
                        const TextStyle(
                      fontSize:
                          24,
                      fontWeight:
                          FontWeight
                              .w700,
                    ),
                  ),
                  const SizedBox(
                      height:
                          4),
                  Text(
                    subtitle,
                    style:
                        const TextStyle(
                      fontSize:
                          13,
                      color: Colors
                          .black54,
                    ),
                  ),
                ],
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