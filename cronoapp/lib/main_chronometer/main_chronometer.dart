import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cronoapp/providers.dart';

class MainChronometer extends ConsumerWidget {
  const MainChronometer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(mainMode);
    final diagonal = sqrt(pow(MediaQuery.of(context).size.height, 2) +
        pow(MediaQuery.of(context).size.width, 2));

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: SegmentedButton(
                onSelectionChanged: (p0) {
                  if (ref.watch(mainIsRunning) == false) {
                    ref.read(mainMode.notifier).state = !currentMode;
                    ref.read(mainHours.notifier).state = "00";
                    ref.read(mainMinutes.notifier).state = "00";
                    ref.read(mainSeconds.notifier).state = "00";
                    ref.read(mainmiliSeconds.notifier).state = "00";
                  }
                },
                segments: [
                  ButtonSegment(
                    label: Text(
                      "Cuenta atras",
                      style: TextStyle(fontSize: diagonal * 0.02),
                    ),
                    value: false,
                  ),
                  ButtonSegment(
                    label: Text(
                      "Cronometro",
                      style: TextStyle(fontSize: diagonal * 0.02),
                    ),
                    value: true,
                  )
                ],
                selected: {ref.watch(mainMode)},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
