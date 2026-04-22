import 'package:flutter/material.dart';
import 'residuals.dart';
import 'recyclables.dart';
import 'hazard_waste.dart';

class WastePage extends StatelessWidget {
  const WastePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor =
        Theme.of(context)
            .scaffoldBackgroundColor;

    final cardColor =
        Theme.of(context).cardColor;

    final textColor =
        Theme.of(context)
            .textTheme
            .bodyLarge
            ?.color ??
        Colors.black;

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
              color: Colors.redAccent,
              shape: BoxShape.circle,
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
          'WASTE',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight:
                FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(16),
              color: cardColor,
              child: Center(
                child: Text(
                  'SELECT WASTE TYPE',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight:
                        FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
            ),

            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.all(
                        18),
                children: [
                  SizedBox(
                    height: 110,
                    child:
                        _WasteButton(
                      label:
                          'Residuals',
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
                  ),

                  const SizedBox(
                      height: 16),

                  SizedBox(
                    height: 110,
                    child:
                        _WasteButton(
                      label:
                          'Recyclables',
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
                  ),

                  const SizedBox(
                      height: 16),

                  SizedBox(
                    height: 110,
                    child:
                        _WasteButton(
                      label:
                          'Hazard Waste',
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WasteButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _WasteButton({
    required this.label,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        elevation: 10,
        shadowColor: Colors.black38,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(24),
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundColor:
                Colors.white24,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          const Icon(
            Icons.chevron_right,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}