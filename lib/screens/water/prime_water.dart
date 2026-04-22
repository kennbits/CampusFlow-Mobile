import 'package:flutter/material.dart';

class PrimeWaterPage extends StatelessWidget {
  const PrimeWaterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'PRIME WATER',
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
      body: const WaterSourceBody(),
    );
  }
}

class WaterSourceBody extends StatelessWidget {
  const WaterSourceBody({super.key});

  @override
  Widget build(BuildContext context) {

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        _SectionCard(
          title: 'Reading',
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType:
                      const TextInputType
                          .numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter reading',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text('m³'),
            ],
          ),
        ),

        const SizedBox(height: 16),

        _SectionCard(
          title: 'Photo',
          child: Center(
            child: SizedBox(
              height: 46,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                label: const Text(
                  'Upload Photo',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.redAccent,
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            14),
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        _SectionCard(
          title: 'Remarks',
          child: TextField(
            minLines: 5,
            maxLines: 7,
            decoration: InputDecoration(
              hintText: 'Enter remarks',
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12),
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        SizedBox(
          height: 56,
          child: ElevatedButton(
            style:
                ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.redAccent,
              elevation: 10,
              shadowColor:
                  Colors.black26,
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                        18),
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(
                      context)
                  .showSnackBar(
                const SnackBar(
                  content: Text(
                    'Submitted',
                  ),
                ),
              );
            },
            child: const Text(
              'Submit',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
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
              fontSize: 16,
              fontWeight:
                  FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}