import 'package:cronoapp/config/storage/storage_functions.dart';
import 'package:cronoapp/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<SnackBar> resultSnackbar(WidgetRef ref) async {
  final response = await savePersonConfig(ref);

  final snackResponse = SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(response),
    duration: const Duration(milliseconds: 1200),
    backgroundColor: response.contains("ciclo") ||
            response.contains("ejercicio") ||
            response.contains("descanso")
        ? Colors.redAccent
        : Colors.green[400],
  );

  return snackResponse;
}

Future<void> setTitleConfig(BuildContext ctx, WidgetRef ref) async {
  final TextEditingController title = TextEditingController();
  final theme = Theme.of(ctx).buttonTheme.colorScheme;

  await showDialog(
    context: ctx,
    builder: (ctx) {
      return AlertDialog(
        title: const Text("Título de configuración"),
        content: TextField(
          controller: title,
          decoration: const InputDecoration(
            hintText: "Ingresa el título de tu configuración.",
          ),
        ),
        actions: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(theme!.inversePrimary),
            ),
            child: const Text('Aceptar'),
            onPressed: () {
              String inputValue = title.text;
              ref.read(titleConfig.notifier).state = inputValue;
              Navigator.pop(ctx);
            },
          ),
        ],
      );
    },
  );

  await resultSnackbar(ref).then((snackbar) =>
      {if (ctx.mounted) ScaffoldMessenger.of(ctx).showSnackBar(snackbar)});
}
