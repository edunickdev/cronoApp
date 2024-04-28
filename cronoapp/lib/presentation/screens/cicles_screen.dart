import 'package:cronoapp/widgets/Cycles/cycles_section.dart';
import 'package:cronoapp/widgets/Cycles/dropdownwidget.dart';
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
              SizedBox(
                height: constraints.maxHeight * 0.08,
                child: Text("Configuración de ciclos",
                    style: TextStyle(fontSize: constraints.maxHeight * 0.04)),
              ),
              const Divider(),
              SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.26,
                child: SectionCyclesWidget(
                    myConstrains: constraints, title: MyOptions.exercise),
              ),
              const Divider(),
              SizedBox(
                height: constraints.maxHeight * 0.26,
                width: constraints.maxWidth,
                child: SectionCyclesWidget(
                    myConstrains: constraints, title: MyOptions.breaks),
              ),
              const Divider(),
              SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.08,
                child: CiclesSectionConfigWidget(myConstrains: constraints),
              ),
              const Divider(),
              SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.08,
                child: CustomDropdownWidget(myConstrains: constraints),
              ),
            ],
          ),
        );
      },
    );
  }
}
