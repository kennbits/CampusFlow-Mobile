import 'package:flutter/material.dart';
import 'meter_form_page.dart';

class SubmeterPage extends StatelessWidget {
  const SubmeterPage({super.key});

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
                          'SUBMETER',
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
                'Choose Location',
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
                    _LocationCard(
                      title:
                          'STEERHUB',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const MeterFormPage(
                              title:
                                  'STEERHUB',
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                        height: 16),

                    _LocationCard(
                      title:
                          'ALBERT EINSTEIN',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const MeterFormPage(
                              title:
                                  'ALBERT EINSTEIN',
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                        height: 16),

                    _LocationCard(
                      title:
                          'AUTOMOTIVE',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const MeterFormPage(
                              title:
                                  'AUTOMOTIVE',
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                        height: 16),

                    _LocationCard(
                      title: 'CET',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const MeterFormPage(
                              title:
                                  'CET',
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                        height: 16),

                    _LocationCard(
                      title: 'RGR',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const MeterFormPage(
                              title:
                                  'RGR',
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                        height: 16),

                    _LocationCard(
                      title: 'SSC',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const MeterFormPage(
                              title:
                                  'SSC',
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                        height: 16),

                    _LocationCard(
                      title: 'FDC',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const MeterFormPage(
                              title:
                                  'FDC',
                            ),
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

class _LocationCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _LocationCard({
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
                  0xFFFFF4E5,
                ),
                shape:
                    BoxShape.circle,
              ),
              child: const Icon(
                Icons.bolt,
                color:
                    Colors.orange,
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
                  fontSize: 20,
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