import 'package:flutter/material.dart';

import '../../models/resource_meter.dart';
import '../../services/api_service.dart';
import 'prime_water.dart';

class WaterReadingPage extends StatefulWidget {
  const WaterReadingPage({super.key});

  @override
  State<WaterReadingPage> createState() =>
      _WaterReadingPageState();
}

class _WaterReadingPageState
    extends State<WaterReadingPage> {

  bool isSubmitting = false;
  
  late Future<List<ResourceMeter>>
      metersFuture;

  @override
  void initState() {
    super.initState();

    metersFuture =
        ApiService.getResourceMeters(
      'water',
    );
  }

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
                child: FutureBuilder<
                    List<ResourceMeter>>(
                  future: metersFuture,
                  builder: (
                    context,
                    snapshot,
                  ) {
                    if (snapshot
                            .connectionState ==
                        ConnectionState
                            .waiting) {
                      return const Center(
                        child:
                            CircularProgressIndicator(),
                      );
                    }

                    if (snapshot
                            .hasError ||
                        !snapshot
                            .hasData) {
                      return const Center(
                        child: Text(
                          'Failed to load water sources',
                        ),
                      );
                    }

                    final meters =
                        snapshot.data!;

                    if (meters
                        .isEmpty) {
                      return const Center(
                        child: Text(
                          'No water sources found',
                        ),
                      );
                    }

                    return ListView
                        .builder(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      itemCount:
                          meters.length,
                      itemBuilder:
                          (
                            context,
                            index,
                          ) {
                            final meter =
                                meters[index];

                            return Padding(
                              padding:
                                  const EdgeInsets.only(
                                bottom:
                                    16,
                              ),
                              child:
                                  _WaterCard(
                                title:
                                    meter.location,
                                onTap:
                                    () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) =>
                                              PrimeWaterPage(
                                        meterId:
                                            meter.id,
                                        title:
                                            meter.location,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                    );
                  },
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