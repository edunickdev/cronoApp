import 'package:cronoapp/config/helpers/Cycles/cycle_functions.dart';
import 'package:cronoapp/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MyOptions { exercise, breaks, all }

class SectionCyclesWidget extends ConsumerWidget {
  final BoxConstraints myConstrains;
  final MyOptions title;

  const SectionCyclesWidget({
    super.key,
    required this.myConstrains,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentEMinutes = ref.watch(minsExercise);
    final currentESeconds = ref.watch(secsExercise);
    final currentBMinutes = ref.watch(minsBreak);
    final currentBSeconds = ref.watch(secsBreak);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              width: myConstrains.maxWidth * 0.5,
              height: myConstrains.maxHeight * 0.25,
              // color: Colors.blue[200],
              padding: const EdgeInsets.all(5),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title == MyOptions.exercise ? "Ejercicio" : "Descanso",
                      style: const TextStyle(fontSize: 30),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          title == MyOptions.exercise
                              ? currentEMinutes.length == 1
                                  ? "0$currentEMinutes"
                                  : currentEMinutes
                              : currentBMinutes.length == 1
                                  ? "0$currentBMinutes"
                                  : currentBMinutes,
                          style:
                              TextStyle(fontSize: myConstrains.maxHeight * 0.08),
                        ),
                        Text(
                          ":",
                          style:
                              TextStyle(fontSize: myConstrains.maxHeight * 0.08),
                        ),
                        Text(
                          title == MyOptions.exercise
                              ? currentESeconds.length == 1
                                  ? "0$currentESeconds"
                                  : currentESeconds
                              : currentBSeconds.length == 1
                                  ? "0$currentBSeconds"
                                  : currentBSeconds,
                          style:
                              TextStyle(fontSize: myConstrains.maxHeight * 0.08),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                          onPressed: () => title == MyOptions.exercise
                              ? moreSecondsExercise(ref)
                              : moreSecondsBreak(ref),
                          child: const Icon(Icons.plus_one),
                        ),
                        const SizedBox(width: 5),
                        FilledButton(
                          onPressed: () => title == MyOptions.exercise
                              ? lessSecondsExercise(ref)
                              : lessSecondsBreak(ref),
                          child: const Icon(Icons.exposure_minus_1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
            width: myConstrains.maxWidth * 0.3,
            height: myConstrains.maxHeight * 0.25,
            // color: Colors.red[200],
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () => title == MyOptions.exercise
                          ? resetTimers(ref, MyOptions.exercise)
                          : resetTimers(ref, MyOptions.breaks),
                      child: const Icon(Icons.refresh_rounded)),
                  FilledButton.tonal(
                      onPressed: () => title == MyOptions.exercise
                          ? plusTenExercise(ref)
                          : plusTenBreak(ref),
                      child: const Text("+10")),
                  FilledButton.tonal(
                      onPressed: () => title == MyOptions.exercise
                          ? plusFifteenExercise(ref)
                          : plusFifteenBreak(ref),
                      child: const Text("+15")),
                  FilledButton.tonal(
                      onPressed: () => title == MyOptions.exercise
                          ? plusThirtyExercise(ref)
                          : plusThirtyBreak(ref),
                      child: const Text("+30")),
                ],
              ),
            ))
      ],
    );
  }
}
