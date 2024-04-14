import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cronoapp/providers.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CicleChronometers extends ConsumerWidget {
  const CicleChronometers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final diagonal = sqrt( pow(width, 2) + pow(height, 2) );

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Expanded(
        child: Column(
          children: [
            Text(
              "Cantidad de ciclos:  ",
              style: TextStyle(fontSize: diagonal * 0.02),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    ref.read(moments.notifier).state == value as int;
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
