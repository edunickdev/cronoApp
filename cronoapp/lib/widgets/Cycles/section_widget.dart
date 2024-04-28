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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title == MyOptions.exercise ? "Ejercicio" : "Descanso",
              style: TextStyle(fontSize: myConstrains.maxHeight * 0.03),
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
                  style: TextStyle(fontSize: myConstrains.maxHeight * 0.07),
                ),
                Text(
                  ":",
                  style: TextStyle(fontSize: myConstrains.maxHeight * 0.07),
                ),
                Text(
                  title == MyOptions.exercise
                      ? currentESeconds.length == 1
                          ? "0$currentESeconds"
                          : currentESeconds
                      : currentBSeconds.length == 1
                          ? "0$currentBSeconds"
                          : currentBSeconds,
                  style: TextStyle(fontSize: myConstrains.maxHeight * 0.07),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(
                      Size(
                        myConstrains.maxWidth * 0.02,
                        myConstrains.maxHeight * 0.01,
                      ),
                    ),
                  ),
                  onPressed: () => title == MyOptions.exercise
                      ? moreSecondsExercise(ref)
                      : moreSecondsBreak(ref),
                  child: const Icon(Icons.plus_one),
                ),
                SizedBox(width: myConstrains.maxWidth * 0.012),
                FilledButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(
                      Size(
                        myConstrains.maxWidth * 0.02,
                        myConstrains.maxHeight * 0.01,
                      ),
                    ),
                  ),
                  onPressed: () => title == MyOptions.exercise
                      ? lessSecondsExercise(ref)
                      : lessSecondsBreak(ref),
                  child: const Icon(Icons.exposure_minus_1),
                ),
              ],
            ),
          ],
        ),
        SizedBox(width: myConstrains.maxWidth * 0.04),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => title == MyOptions.exercise
                      ? resetTimers(ref, MyOptions.exercise)
                      : resetTimers(ref, MyOptions.breaks),
                  child: Icon(
                    Icons.refresh_rounded,
                    size: myConstrains.maxHeight * 0.04,
                  ),
                ),
                FilledButton.tonal(
                    onPressed: () => title == MyOptions.exercise
                        ? plusTenExercise(ref)
                        : plusTenBreak(ref),
                    child: Text(
                      "+10",
                      style: TextStyle(fontSize: myConstrains.maxHeight * 0.02),
                    )),
              ],
            ),
            SizedBox(width: myConstrains.maxWidth * 0.01),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton.tonal(
                    onPressed: () => title == MyOptions.exercise
                        ? plusFifteenExercise(ref)
                        : plusFifteenBreak(ref),
                    child: Text(
                      "+15",
                      style: TextStyle(fontSize: myConstrains.maxHeight * 0.02),
                    )),
                FilledButton.tonal(
                    onPressed: () => title == MyOptions.exercise
                        ? plusThirtyExercise(ref)
                        : plusThirtyBreak(ref),
                    child: Text(
                      "+30",
                      style: TextStyle(fontSize: myConstrains.maxHeight * 0.02),
                    ))
              ],
            )
          ],
        )
      ],
    );
  }
}
