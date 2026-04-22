import 'package:flutter/material.dart';

class HazardWastePage extends StatefulWidget {
  const HazardWastePage({super.key});

  @override
  State<HazardWastePage> createState() =>
      _HazardWastePageState();
}

class _HazardWastePageState
    extends State<HazardWastePage> {
  final _wasteController =
      TextEditingController();

  final _remarksController =
      TextEditingController();

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

  void _submit() {
    final waste =
        _wasteController.text.trim();

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          'Hazard Waste submitted: $waste kg',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgColor =
        Theme.of(context)
            .scaffoldBackgroundColor;

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
              color:
                  Colors.redAccent,
              shape:
                  BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color:
                    Colors.white,
              ),
              onPressed: () =>
                  Navigator.pop(
                      context),
            ),
          ),
        ),
        title: const Text(
          'HAZARD WASTE',
          style: TextStyle(
            color:
                Colors.redAccent,
            fontWeight:
                FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),

      body: ListView(
        padding:
            const EdgeInsets.all(18),
        children: [
          _SectionCard(
            title:
                'Waste Generated',
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller:
                        _wasteController,
                    keyboardType:
                        const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration:
                        InputDecoration(
                      hintText:
                          'Enter weight',
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                                12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                    width: 10),
                const Text('kg'),
              ],
            ),
          ),

          const SizedBox(
              height: 16),

          _SectionCard(
            title: 'Photo',
            child: Center(
              child: SizedBox(
                height: 46,
                child:
                    ElevatedButton.icon(
                  onPressed:
                      _pickPhoto,
                  icon:
                      const Icon(
                    Icons.camera_alt,
                    color:
                        Colors.white,
                  ),
                  label:
                      const Text(
                    'Upload Photo',
                    style:
                        TextStyle(
                      color: Colors
                          .white,
                    ),
                  ),
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.redAccent,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(
              height: 16),

          _SectionCard(
            title: 'Remarks',
            child: TextField(
              controller:
                  _remarksController,
              minLines: 5,
              maxLines: 7,
              decoration:
                  InputDecoration(
                hintText:
                    'Enter remarks',
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                          12),
                ),
              ),
            ),
          ),

          const SizedBox(
              height: 24),

          SizedBox(
            height: 56,
            child:
                ElevatedButton(
              onPressed: _submit,
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.redAccent,
                elevation: 10,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                          18),
                ),
              ),
              child:
                  const Text(
                'Submit',
                style:
                    TextStyle(
                  color:
                      Colors.white,
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
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
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            Theme.of(context)
                .cardColor,
        borderRadius:
            BorderRadius.circular(
                18),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color:
                Colors.black12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                const TextStyle(
              color:
                  Colors.redAccent,
              fontWeight:
                  FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(
              height: 12),
          child,
        ],
      ),
    );
  }
}