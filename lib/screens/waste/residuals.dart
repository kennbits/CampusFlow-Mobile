import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class ResidualsPage extends StatefulWidget {
  const ResidualsPage({super.key});

  @override
  State<ResidualsPage> createState() =>
      _ResidualsPageState();
}

class _ResidualsPageState
    extends State<ResidualsPage> {
  final _wasteController =
      TextEditingController();

  final _remarksController =
      TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    _wasteController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  void _pickPhoto() {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          'Upload photo coming soon',
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final waste =
        _wasteController.text.trim();

    final remarks =
        _remarksController.text.trim();

    if (waste.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text('Enter weight'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await ApiService.storeReading(
        module: 'waste',
        sourceName: 'Residuals',
        reading: waste,
        remarks: remarks,
      );

      if (!mounted) return;

      _wasteController.clear();
      _remarksController.clear();

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Submitted successfully',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text('Submit failed'),
        ),
      );
    }

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
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
            begin:
                Alignment.topCenter,
            end: Alignment
                .bottomCenter,
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
                          'RESIDUALS',
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

              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets
                          .all(20),
                  children: [
                    _SectionCard(
                      title:
                          'Waste Generated',
                      child: Row(
                        children: [
                          Expanded(
                            child:
                                TextField(
                              controller:
                                  _wasteController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal:
                                    true,
                              ),
                              decoration:
                                  const InputDecoration(
                                hintText:
                                    'Enter weight',
                              ),
                            ),
                          ),
                          const SizedBox(
                              width:
                                  10),
                          const Text(
                            'kg',
                            style:
                                TextStyle(
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                        height: 16),

                    _SectionCard(
                      title:
                          'Photo',
                      child: SizedBox(
                        width: double
                            .infinity,
                        height: 52,
                        child:
                            ElevatedButton.icon(
                          onPressed:
                              _pickPhoto,
                          icon:
                              const Icon(
                            Icons
                                .camera_alt,
                            color: Colors
                                .white,
                          ),
                          label:
                              const Text(
                            'Upload Photo',
                            style:
                                TextStyle(
                              color: Colors
                                  .white,
                              fontWeight:
                                  FontWeight.w700,
                            ),
                          ),
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(
                              0xFFED1B2F,
                            ),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      16),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                        height: 16),

                    _SectionCard(
                      title:
                          'Remarks',
                      child:
                          TextField(
                        controller:
                            _remarksController,
                        minLines: 5,
                        maxLines: 7,
                        decoration:
                            const InputDecoration(
                          hintText:
                              'Enter remarks',
                        ),
                      ),
                    ),

                    const SizedBox(
                        height: 24),

                    SizedBox(
                      height: 58,
                      child:
                          ElevatedButton(
                        onPressed:
                            isLoading
                                ? null
                                : _submit,
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(
                            0xFFED1B2F,
                          ),
                          elevation:
                              8,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    18),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Submit',
                                style:
                                    TextStyle(
                                  fontSize:
                                      18,
                                  fontWeight:
                                      FontWeight.w700,
                                  color:
                                      Colors.white,
                                ),
                              ),
                      ),
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

class _SectionCard
    extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(
              18),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
                24),
        boxShadow: const [
          BoxShadow(
            color:
                Colors.black12,
            blurRadius: 18,
            offset:
                Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment
                .start,
        children: [
          Text(
            title,
            style:
                const TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight
                      .w700,
              color: Color(
                0xFFED1B2F,
              ),
            ),
          ),
          const SizedBox(
              height: 14),
          child,
        ],
      ),
    );
  }
}