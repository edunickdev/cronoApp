import 'package:cronoapp/widgets/Cycles/cycles_section.dart';
import 'package:cronoapp/widgets/Cycles/section_widget.dart';
import 'package:flutter/material.dart';

class CiclesScreen extends StatelessWidget {
  static const name = "/cicles";

  const CiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
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
            ],
          ),
        );
      },
    );
  }
}


