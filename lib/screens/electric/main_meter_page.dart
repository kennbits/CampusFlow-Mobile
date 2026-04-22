import 'package:flutter/material.dart';

class MainMeterPage extends StatefulWidget {
  const MainMeterPage({Key? key}) : super(key: key);

  @override
  State<MainMeterPage> createState() => _MainMeterPageState();
}

class _MainMeterPageState extends State<MainMeterPage> {
  final TextEditingController _consumptionController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  @override
  void dispose() {
    _consumptionController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  void _pickPhoto() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pick photo (not implemented)')),
    );
  }

  void _submit() {
    final reading =
        _consumptionController.text.trim();

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          'Submitted: $reading kW',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context)
              .scaffoldBackgroundColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: const BoxDecoration(
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
        backgroundColor:
            Theme.of(context)
                .scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            _SectionCard(
              title: 'Consumption',
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller:
                          _consumptionController,
                      keyboardType:
                          const TextInputType
                              .numberWithOptions(
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
                        ElevatedButton
                            .styleFrom(
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
              child: ElevatedButton(
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
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
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