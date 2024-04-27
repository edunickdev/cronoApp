import 'dart:math';

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

    final diagonal =
        sqrt(pow(MediaQuery.of(context).size.height, 2) - pow(MediaQuery.of(context).size.width, 2));

    return LayoutBuilder(
      builder: (context, constraints) {

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Configuración de ciclos", style: TextStyle(fontSize: diagonal * 0.04)),
              const Divider(),
              SectionCyclesWidget(
                  myConstrains: constraints, title: MyOptions.exercise),
              const Divider(),
              SectionCyclesWidget(
                  myConstrains: constraints, title: MyOptions.breaks),
              const Divider(),
              CiclesSectionConfigWidget(myConstrains: constraints),
              const Divider(),
              const CustomDropdownWidget()
            ],
          ),
        );
      },
    );
  }
}

