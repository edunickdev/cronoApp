import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cronoapp/config/helpers/Running/running_function.dart';
import 'package:cronoapp/widgets/Cycles/dropbutton_widget.dart';

class CustomDropdownWidget extends ConsumerWidget {
  const CustomDropdownWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () => setTitleConfig(context, ref),
          icon: const Icon(Icons.save),
          label: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text("Guardar"),
          ),
        ),
        const SizedBox(width: 10),
        const DropButtonWidget()
      ],
    );
  }
}
