import 'package:cronoapp/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    final theme = Theme.of(context).colorScheme;

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
          Text(
            text == "Horas"
                ? "HH"
                : text == "Minutos"
                    ? "MM"
                    : "SS",
            style: TextStyle(color: theme.inversePrimary),
          ),
          Text(
            value.length == 1 ? "0$value" : value,
            style: TextStyle(
              fontSize: diagonal * 0.1,
              color: ref.read(mainHours.notifier).state != "00" &&
                      ref.read(mainMinutes.notifier).state != "00" &&
                      ref.read(mainSeconds.notifier).state != "00"
                  ? theme.inversePrimary
                  : theme.secondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
