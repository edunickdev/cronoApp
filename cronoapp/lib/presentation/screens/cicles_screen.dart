import 'package:cronoapp/config/storage/storage_functions.dart';
import 'package:cronoapp/widgets/Cycles/cycles_section.dart';
import 'package:cronoapp/widgets/Cycles/section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CiclesScreen extends ConsumerWidget {
  static const name = "/cicles";

  const CiclesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<SnackBar> resultSnackbar() async {
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

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text("Ciclos", style: TextStyle(fontSize: 45)),
              const Divider(),
              SectionCyclesWidget(
                  myConstrains: constraints, title: MyOptions.exercise),
              const Divider(),
              SectionCyclesWidget(
                  myConstrains: constraints, title: MyOptions.breaks),
              const Divider(),
              CiclesSectionConfigWidget(myConstrains: constraints),
              const Divider(),
              ElevatedButton.icon(
                onPressed: () {
                  resultSnackbar().then((snackbar) =>
                      {ScaffoldMessenger.of(context).showSnackBar(snackbar)});
                },
                icon: const Icon(Icons.save),
                label: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text("Guardar"),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
