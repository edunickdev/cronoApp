import 'dart:math';
import 'package:cronoapp/main_chronometer/main_chronometer.dart';
import 'package:cronoapp/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimersWidget extends ConsumerWidget {
  const TimersWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myHeight = MediaQuery.of(context).size.height;
    final myWidth = MediaQuery.of(context).size.width;
    final currentDiagonal = sqrt(pow(myWidth, 2) + pow(myHeight, 2));
    final currentMode = ref.watch(mainMode);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      String hours = ref.watch(mainHours);
                      return currentMode == false
                          ? CustomField(
                              text: "Horas",
                              value: hours,
                              diagonal: currentDiagonal,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("HH"),
                                Text(
                                  hours,
                                  style: TextStyle(
                                      fontSize: currentDiagonal * 0.1),
                                ),
                              ],
                            );
                    },
                  ),
                  Text(":", style: TextStyle(fontSize: currentDiagonal * 0.05)),
                  Consumer(builder: (context, ref, child) {
                    String minutes = ref.watch(mainMinutes);
                    return ref.read(mainMode.notifier).state == false
                        ? CustomField(
                            text: "Minutos",
                            value: minutes,
                            diagonal: currentDiagonal)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("MM"),
                              Text(minutes,
                                  style: TextStyle(
                                      fontSize: currentDiagonal * 0.1)),
                            ],
                          );
                  }),
                  Text(":", style: TextStyle(fontSize: currentDiagonal * 0.05)),
                  Consumer(builder: (context, ref, child) {
                    String seconds = ref.watch(mainSeconds);
                    return ref.read(mainMode.notifier).state == false
                        ? CustomField(
                            text: "Segundos",
                            value: seconds,
                            diagonal: currentDiagonal)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("SS"),
                              Text(seconds,
                                  style: TextStyle(
                                      fontSize: currentDiagonal * 0.1)),
                            ],
                          );
                  }),
                ],
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                String miliseconds = ref.watch(mainmiliSeconds);
                return Text(
                  miliseconds.length == 1 ? "0$miliseconds" : miliseconds,
                  style: const TextStyle(fontSize: 90),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
