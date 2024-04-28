import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cronoapp/providers.dart';
import 'package:cronoapp/widgets/home/custom_field.dart';

class TimersWidget extends ConsumerWidget {
  const TimersWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myHeight = MediaQuery.of(context).size.height;
    final myWidth = MediaQuery.of(context).size.width;
    final currentDiagonal = sqrt(pow(myWidth, 2) + pow(myHeight, 2));
    final currentMode = ref.watch(mainMode);
    final theme = Theme.of(context).colorScheme;

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
                                Text("HH",
                                    style:
                                        TextStyle(color: theme.inversePrimary)),
                                Text(
                                  hours,
                                  style: TextStyle(
                                      fontSize: currentDiagonal * 0.1,
                                      color: theme.inversePrimary),
                                ),
                              ],
                            );
                    },
                  ),
                  Text(":",
                      style: TextStyle(
                          fontSize: currentDiagonal * 0.05,
                          color: theme.inversePrimary)),
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
                              Text("MM",
                                  style:
                                      TextStyle(color: theme.inversePrimary)),
                              Text(minutes,
                                  style: TextStyle(
                                      fontSize: currentDiagonal * 0.1,
                                      color: theme.inversePrimary)),
                            ],
                          );
                  }),
                  Text(":",
                      style: TextStyle(
                          fontSize: currentDiagonal * 0.05,
                          color: theme.inversePrimary)),
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
                              Text(
                                "SS",
                                style: TextStyle(color: theme.inversePrimary),
                              ),
                              Text(
                                seconds,
                                style: TextStyle(
                                  fontSize: currentDiagonal * 0.1,
                                  color: theme.inversePrimary,
                                ),
                              ),
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
                  style: TextStyle(
                    fontSize: currentDiagonal * 0.1,
                    color: theme.inversePrimary,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
