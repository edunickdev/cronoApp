import 'package:flutter/material.dart';
import 'package:cronoapp/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CicleChronometers extends ConsumerWidget {
  const CicleChronometers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<int> cicles = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Elija la cantidad de ciclos:  ", style: TextStyle(fontSize: 25)),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.04,
          child: DropdownButton(
            value: ref.watch(moments),
            elevation: 16,
            items: cicles
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toString(), style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                ref.read(moments.notifier).state = value;
              }
            },
          ),
        ),
      ],
    );
  }
}
