import 'dart:async';
import 'package:cronoapp/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void startTimeChronometer(WidgetRef ref) {
  if (ref.watch(mainIsRunning.notifier).state) {
    return;
  }

  ref.read(mainIsRunning.notifier).state = true;

  int miliseconds = int.parse(ref.read(mainmiliSeconds.notifier).state);
  int seconds = int.parse(ref.read(mainSeconds.notifier).state);
  int minutes = int.parse(ref.read(mainMinutes.notifier).state);
  int hours = int.parse(ref.read(mainHours.notifier).state);

  Timer.periodic(
    const Duration(milliseconds: 10),
    (timer) {
      miliseconds++;
      if (miliseconds >= 99) {
        miliseconds = 0;
        seconds++;
        if (seconds >= 59) {
          seconds = 0;
          minutes++;
          if (minutes >= 59) {
            minutes = 0;
            hours++;
          }
        }
      }
      ref.read(mainmiliSeconds.notifier).state =
          miliseconds.toString().padLeft(2, '0');
      ref.read(mainSeconds.notifier).state = seconds.toString().padLeft(2, '0');
      ref.read(mainMinutes.notifier).state = minutes.toString().padLeft(2, '0');
      ref.read(mainHours.notifier).state = hours.toString().padLeft(2, '0');
    },
  );
}
