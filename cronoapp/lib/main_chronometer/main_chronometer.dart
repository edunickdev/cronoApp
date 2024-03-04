import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cronoapp/providers.dart';

class MainChronometer extends ConsumerWidget {
  const MainChronometer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SegmentedButton(
              onSelectionChanged: (p0) {
                if (ref.watch(mainIsRunning) == false) {
                  ref.read(mainMode.notifier).state = p0.firstOrNull!;
                  ref.read(mainHours.notifier).state = "00";
                  ref.read(mainMinutes.notifier).state = "00";
                  ref.read(mainSeconds.notifier).state = "00";
                  ref.read(mainmiliSeconds.notifier).state = "00";
                }
              },
              segments: const [
                ButtonSegment(label: Text("Cuenta regresiva", style: TextStyle(fontSize: 15),), value: 0),
                ButtonSegment(label: Text("Cronometro", style: TextStyle(fontSize: 15),), value: 1)
              ],
              selected: {ref.watch(mainMode)},
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Consumer(builder: (context, ref, child) {
              String hours = ref.watch(mainHours);
              return ref.read(mainMode.notifier).state == 0 ? CustomField(text: "Horas", value: hours) : Text( hours, style: const TextStyle(fontSize: 50));
            }),
            const Text(":", style: TextStyle(fontSize: 50)),
            Consumer(builder: (context, ref, child) {
              String minutes = ref.watch(mainMinutes);
              return ref.read(mainMode.notifier).state == 0 ? CustomField(text: "Minutos", value: minutes) : Text( minutes, style: const TextStyle(fontSize: 50));
            }),
            const Text(":", style: TextStyle(fontSize: 50)),
            Consumer(builder: (context, ref, child) {
              String seconds = ref.watch(mainSeconds);
              return ref.read(mainMode.notifier).state == 0 ? CustomField(text: "Segundos", value: seconds) : Text( seconds, style: const TextStyle(fontSize: 50));
            }),
            const Text(":", style: TextStyle(fontSize: 30)),
            Consumer(builder: (context, ref, child) {
              String miliseconds = ref.watch(mainmiliSeconds);
              return Text(
                miliseconds.length == 1 ? "0$miliseconds" : miliseconds,
                style: const TextStyle(fontSize: 30),
              );
            }),
          ]),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomField extends ConsumerWidget {
  final String text;
  String value;
  TextEditingController controller = TextEditingController();
  CustomField({super.key, required this.text, required this.value});

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
      context.pop();
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
                  context.pop();
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
      child: Text(
        value.length == 1 ? "0$value" : value,
        style: const TextStyle(fontSize: 50),
      ),
    );
  }
}
