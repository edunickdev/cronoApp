import 'dart:math';

import 'package:cronoapp/domain/entities/person_model.dart';
import 'package:cronoapp/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomNavBarWidget extends ConsumerWidget {
  const CustomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentIndex = ref.watch(selectScreen);
    final diagonal = sqrt(pow(MediaQuery.of(context).size.height, 2) -
        pow(MediaQuery.of(context).size.width, 2));

    void resetValues(WidgetRef ref) {
      ref.read(showButton.notifier).state = false;
      final current = PersonConfig(
        id: 0,
        title: "00:00",
        exerciseDurationTime: "00:00",
        breakDurationTime: "00:00",
        cycles: 0,
      );
      ref.read(currentConfig.notifier).state = current;
      ref.read(secsBreak.notifier).state =
          current.breakDurationTime.split(":")[1];
      ref.read(minsBreak.notifier).state =
          current.breakDurationTime.split(":")[0];
      ref.read(secsExercise.notifier).state =
          current.exerciseDurationTime.split(":")[1];
      ref.read(minsExercise.notifier).state =
          current.exerciseDurationTime.split(":")[0];
      ref.read(cyclesAmount.notifier).state = current.cycles;
    }

    return NavigationBar(
      height: diagonal * 0.13,
      selectedIndex: currentIndex,
      onDestinationSelected: (value) {
        if (ref.watch(mainIsRunning.notifier).state) {
          return;
        }
        ref.read(selectScreen.notifier).state = value;
        ref.watch(selectScreen) == 0 ? resetValues(ref) : null;
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: "General"),
        NavigationDestination(
            icon: Icon(Icons.dashboard_customize), label: "Personal"),
      ],
    );
  }
}
