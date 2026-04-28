import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class MainMeterPage extends StatefulWidget {
  const MainMeterPage({Key? key}) : super(key: key);

  @override
  State<MainMeterPage> createState() => _MainMeterPageState();
}

class _MainMeterPageState extends State<MainMeterPage> {
  final TextEditingController _consumptionController =
      TextEditingController();

  final TextEditingController _remarksController =
      TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    _consumptionController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  void _pickPhoto() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pick photo (not implemented)'),
      ),
    );
  }

  Future<void> _submit() async {
    final reading =
        _consumptionController.text.trim();

    final remarks =
        _remarksController.text.trim();

    if (reading.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter reading'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await ApiService.storeReading(
        module: 'electric',
        sourceName: 'Main Meter',
        reading: reading,
        remarks: remarks,
      );

      if (!mounted) return;

      _consumptionController.clear();
      _remarksController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Submitted successfully'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Submit failed'),
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
              shape: BoxShape.circle,
              color: Color(0xFFE63946),
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
          'MAIN METER',
          style: TextStyle(
            color: Color(0xFFE63946),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding:
              const EdgeInsets.all(18),
          children: [
            _SectionCard(
              title: 'Reading',
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller:
                          _consumptionController,
                      keyboardType:
                          const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration:
                          InputDecoration(
                        hintText:
                            'Enter reading',
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                                  12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text('kW'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _SectionCard(
              title: 'Photo',
              child: Center(
                child: SizedBox(
                  height: 46,
                  child:
                      ElevatedButton.icon(
                    onPressed: _pickPhoto,
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Upload Photo',
                      style: TextStyle(
                        color:
                            Colors.white,
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

            const SizedBox(height: 16),

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

            const SizedBox(height: 24),

            SizedBox(
              height: 56,
              child:
                  ElevatedButton(
                onPressed:
                    isLoading
                        ? null
                        : _submit,
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
                    isLoading
                        ? const CircularProgressIndicator(
                          color:
                              Colors.white,
                        )
                        : const Text(
                          'Submit',
                          style: TextStyle(
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
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
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
            Theme.of(context).cardColor,
        borderRadius:
            BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color:
                  Colors.redAccent,
              fontWeight:
                  FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}