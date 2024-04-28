import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cronoapp/config/helpers/Running/running_function.dart';
import 'package:cronoapp/widgets/Cycles/dropbutton_widget.dart';

class CustomDropdownWidget extends ConsumerWidget {
  final BoxConstraints myConstrains;

  const CustomDropdownWidget({super.key, required this.myConstrains});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () => setTitleConfig(context, ref),
          icon: const Icon(Icons.save),
          label: Text(
            "Guardar",
            style: TextStyle(fontSize: myConstrains.maxHeight * 0.03),
          ),
        ),
        SizedBox(width: myConstrains.maxWidth * 0.02),
        DropButtonWidget(myConstrains: myConstrains)
      ],
    );
  }
}
