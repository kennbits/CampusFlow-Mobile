import 'package:flutter/material.dart';
import 'prime_water.dart';

class DeepWell1Page extends StatelessWidget {
  const DeepWell1Page({Key? key}) : super(key: key);

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
          'DEEP WELL 1',
          style: TextStyle(
            color: Color(0xFFE63946),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: const WaterSourceBody(),
    );
  }
}