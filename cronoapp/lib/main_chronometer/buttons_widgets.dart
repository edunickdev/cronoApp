import 'dart:async';
import 'package:cronoapp/config/helpers/shared/shared_functions.dart';
import 'package:cronoapp/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class MainCronometerButtonsWidget extends ConsumerWidget {
  Timer timer;
  MainCronometerButtonsWidget({super.key, required this.timer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void startTimeCountDown() {
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

      timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
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
      });
    }

    void startTimeChronometer() {
      if (ref.watch(mainIsRunning.notifier).state) {
        return;
      }
      ref.read(mainIsRunning.notifier).state = true;

      timer = Timer.periodic(
        const Duration(milliseconds: 10),
        (timer) {
          int miliseconds = int.parse(ref.read(mainmiliSeconds.notifier).state);
          int seconds = int.parse(ref.read(mainSeconds.notifier).state);
          int minutes = int.parse(ref.read(mainMinutes.notifier).state);
          int hours = int.parse(ref.read(mainHours.notifier).state);
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
          ref.read(mainSeconds.notifier).state =
              seconds.toString().padLeft(2, '0');
          ref.read(mainMinutes.notifier).state =
              minutes.toString().padLeft(2, '0');
          ref.read(mainHours.notifier).state = hours.toString().padLeft(2, '0');
        },
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilledButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.green),
          ),
          onPressed: () {
            if (ref.watch(mainIsRunning) == false) {
              if (ref.watch(mainMode) == false) {
                startTimeCountDown();
              } else {
                startTimeChronometer();
              }
            } else {
              pauseTime(ref, timer);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(
              ref.watch(mainIsRunning) == false
                  ? Icons.play_arrow_rounded
                  : Icons.pause_rounded,
              size: 45,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        FilledButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.blue),
          ),
          onPressed: () => resetTime(ref, timer),
          child: const Padding(
            padding: EdgeInsets.all(5),
            child: Icon(
              Icons.replay_rounded,
              size: 45,
            ),
          ),
        ),
      ],
    );
  }
}
