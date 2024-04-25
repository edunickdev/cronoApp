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

// ignore: must_be_immutable
class CustomField extends ConsumerWidget {
  final String text;
  String value;
  final double diagonal;
  TextEditingController controller = TextEditingController();
  CustomField(
      {super.key,
      required this.text,
      required this.value,
      required this.diagonal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void setTime() {
      if (text == "Horas") {
        if (int.parse(controller.text) < 25 && int.parse(controller.text) > 0) {
          ref.read(mainHours.notifier).state = controller.text;
        }
      } else if (text == "Minutos") {
        if (int.parse(controller.text) < 60 && int.parse(controller.text) > 0) {
          ref.read(mainMinutes.notifier).state = controller.text;
        }
      } else if (text == "Segundos") {
        if (int.parse(controller.text) < 60 && int.parse(controller.text) > 0) {
          ref.read(mainSeconds.notifier).state = controller.text;
        }
      }
      controller.clear();
      Navigator.of(context).pop();
    }

    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(text),
            content: TextField(
              controller: controller,
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Ingresa el valor para $text',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: setTime,
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
      },
      child: Column(
        children: [
          Text(text == "Horas"
              ? "HH"
              : text == "Minutos"
                  ? "MM"
                  : "SS"),
          Text(
            value.length == 1 ? "0$value" : value,
            style: TextStyle(
              fontSize: diagonal * 0.1,
              color: ref.read(mainHours.notifier).state != "00" &&
                      ref.read(mainMinutes.notifier).state != "00" &&
                      ref.read(mainSeconds.notifier).state != "00"
                  ? Colors.black
                  : Colors.red[400],
            ),
          ),
        ],
      ),
    );
  }
}
