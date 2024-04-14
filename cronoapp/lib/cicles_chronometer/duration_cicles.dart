import 'package:cronoapp/cicles_chronometer/cicles_chronometer.dart';
import 'package:cronoapp/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class DurationWidget extends ConsumerWidget {
  const DurationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final secondsBreak = int.parse(ref.read(secsBreak.notifier).state);
    final secondsExercise = int.parse(ref.read(secsExercise.notifier).state);
    final minutesBreak = int.parse(ref.read(minsBreak.notifier).state);
    final minutesExercise = int.parse(ref.read(minsExercise.notifier).state);

    void moreSecondsExercise() {
      if (secondsExercise < 59) {
        ref.read(secsExercise.notifier).state = (secondsExercise + 1).toString();
      }
      if (secondsExercise >= 59) {
        ref.read(minsExercise.notifier).state = (minutesExercise + 1).toString();
        ref.read(secsExercise.notifier).state = "00";
      }
    }

    void lessSecondsExercise() {
      if (minutesExercise > 0) {
        ref.read(minsExercise.notifier).state = (minutesExercise - 1).toString();
      }
      if (secondsExercise < 59 && secondsExercise > 0) {
        ref.read(secsExercise.notifier).state = (secondsExercise - 1).toString();
        if (ref.watch(secsExercise) == "00") {
          return;
        }
      }
    }

    void moreSecondsBreak() {
      if (secondsBreak < 59) {
        ref.read(secsBreak.notifier).state = (secondsBreak + 1).toString();
      }
      if (secondsBreak >= 59) {
        ref.read(minsBreak.notifier).state = (minutesBreak + 1).toString();
        ref.read(secsBreak.notifier).state = "00";
      }
    }

    void lessSecondsBreak() {
      if (minutesBreak > 0) {
        ref.read(minsBreak.notifier).state = (minutesBreak - 1).toString();
      }
      if (secondsBreak < 59 && secondsBreak > 0) {
        ref.read(secsBreak.notifier).state = (secondsBreak - 1).toString();
        if (ref.watch(secsBreak) == "00") {
          return;
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: width / 0.5,
        height: height / 2.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height / 25),
            const CicleChronometers(),
            SizedBox(height: height / 25),
            const Text("Duración ejercicios", style: TextStyle(fontSize: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ref.watch(minsExercise).length == 1
                      ? "0${ref.watch(minsExercise)}"
                      : ref.watch(minsExercise),
                  style: const TextStyle(fontSize: 45),
                ),
                const Text(
                  ":",
                  style: TextStyle(fontSize: 45),
                ),
                Text(
                  ref.watch(secsExercise).length == 1
                      ? "0${ref.watch(secsExercise)}"
                      : ref.watch(secsExercise),
                  style: const TextStyle(fontSize: 45),
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    SizedBox(
                      width: width * 0.18,
                      height: height * 0.03,
                      child: FilledButton(
                          onPressed: moreSecondsExercise,
                          child: const Icon(Icons.arrow_drop_up_rounded)),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: width * 0.18,
                      height: height * 0.03,
                      child: FilledButton(
                          onPressed: lessSecondsExercise,
                          child: const Icon(Icons.arrow_drop_down_rounded)),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            const Text("Duración descansos", style: TextStyle(fontSize: 30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ref.watch(minsBreak).length == 1
                      ? "0${ref.watch(minsBreak)}"
                      : ref.watch(minsBreak),
                  style: const TextStyle(fontSize: 45),
                ),
                const Text(
                  ":",
                  style: TextStyle(fontSize: 45),
                ),
                Text(
                  ref.watch(secsBreak).length == 1
                      ? "0${ref.watch(secsBreak)}"
                      : ref.watch(secsBreak),
                  style: const TextStyle(fontSize: 45),
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    SizedBox(
                      width: width * 0.18,
                      height: height * 0.03,
                      child: FilledButton(
                          onPressed: moreSecondsBreak,
                          child: const Icon(Icons.arrow_drop_up_rounded)),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: width * 0.18,
                      height: height * 0.03,
                      child: FilledButton(
                          onPressed: lessSecondsBreak,
                          child: const Icon(Icons.arrow_drop_down_rounded)),
                    ),
                  ],
                )
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
