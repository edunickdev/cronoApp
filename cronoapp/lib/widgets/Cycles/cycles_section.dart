import 'dart:math';

import 'package:cronoapp/config/helpers/Cycles/cycle_functions.dart';
import 'package:cronoapp/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Operations { minus, plus }

class CiclesSectionConfigWidget extends ConsumerWidget {
  
  final BoxConstraints myConstrains;

  const CiclesSectionConfigWidget({required this.myConstrains, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final totalCicles = ref.watch(cyclesAmount);

    final diagonal =
        sqrt(pow(myConstrains.maxHeight, 2) - pow(myConstrains.maxWidth, 2));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Cantidad de ciclos",
            style: TextStyle(fontSize: diagonal * 0.03),
          ),
          SizedBox(width: myConstrains.maxHeight * 0.02),
          Text(
            totalCicles >= 0 && totalCicles < 10
                ? "0$totalCicles"
                : "$totalCicles",
            style: const TextStyle(fontSize: 40),
          ),
          SizedBox(width: myConstrains.maxHeight * 0.02),
          IconButton.outlined(
              onPressed: () => configCycles(ref, Operations.plus),
              icon: const Icon(Icons.plus_one_outlined)),
          IconButton.outlined(
            onPressed: () => configCycles(ref, Operations.minus),
            icon: const Icon(Icons.exposure_minus_1_outlined),
          ),
        ],
      ),
    );
  }
}
