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
                onPressed: () => savePersonConfig(ref),
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
