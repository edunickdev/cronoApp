import 'dart:async';

import 'package:cronoapp/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void startTimeCountDown(WidgetRef ref) {
  if (ref.watch(mainMode) == false &&
      ref.watch(mainHours) == "00" &&
      ref.watch(mainMinutes) == "00" &&
      ref.watch(mainSeconds) == "00" &&
      ref.watch(mainmiliSeconds) == "00") {
    return;
  }

  if (ref.watch(mainIsRunning.notifier).state) {
    return;
  }
  ref.read(mainIsRunning.notifier).state = true;

  Timer.periodic(
    const Duration(seconds: 1),
    (timer) {
      int miliseconds = int.parse(ref.read(mainmiliSeconds.notifier).state);
      int seconds = int.parse(ref.read(mainSeconds.notifier).state);
      int minutes = int.parse(ref.read(mainMinutes.notifier).state);
      int hours = int.parse(ref.read(mainHours.notifier).state);

      if (hours == 0 && minutes == 0 && seconds == 0 && miliseconds == 0) {
        timer.cancel();
        ref.read(mainIsRunning.notifier).state = false;
      } else {
        if (miliseconds == 0) {
          if (seconds == 0) {
            if (minutes == 0) {
              hours--;
              minutes = 59;
              seconds = 59;
            } else {
              minutes--;
              seconds = 59;
            }
          } else {
            seconds--;
          }
          miliseconds = 99;
        } else {
          miliseconds--;
        }

        ref.read(mainmiliSeconds.notifier).state =
            miliseconds.toString().padLeft(2, '0');
        ref.read(mainSeconds.notifier).state =
            seconds.toString().padLeft(2, '0');
        ref.read(mainMinutes.notifier).state =
            minutes.toString().padLeft(2, '0');
        ref.read(mainHours.notifier).state = hours.toString().padLeft(2, '0');
      }
    },
  );
}
