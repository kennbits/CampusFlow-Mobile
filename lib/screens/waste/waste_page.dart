import 'package:flutter/material.dart';
import 'residuals.dart';
import 'recyclables.dart';
import 'hazard_waste.dart';

class WastePage extends StatelessWidget {
  const WastePage({super.key});

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
                          'WASTE',
                          style:
                              TextStyle(
                            fontSize:
                                26,
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
                'Choose Waste Type',
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
                    _WasteCard(
                      title:
                          'Residuals',
                      icon:
                          Icons.delete,
                      iconColor:
                          Colors.red,
                      iconBg:
                          const Color(
                        0xFFFFEBEE,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const ResidualsPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                        height: 16),

                    _WasteCard(
                      title:
                          'Recyclables',
                      icon:
                          Icons.recycling,
                      iconColor:
                          Colors.green,
                      iconBg:
                          const Color(
                        0xFFEAF8EC,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const RecyclablesPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                        height: 16),

                    _WasteCard(
                      title:
                          'Hazard Waste',
                      icon:
                          Icons.warning_amber,
                      iconColor:
                          Colors.orange,
                      iconBg:
                          const Color(
                        0xFFFFF4E5,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const HazardWastePage(),
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

class _WasteCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final VoidCallback onTap;

  const _WasteCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
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
                shape:
                    BoxShape.circle,
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