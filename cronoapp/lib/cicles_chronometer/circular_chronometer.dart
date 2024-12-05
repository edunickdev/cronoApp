import 'dart:async';

import 'package:cronoapp/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomCircularChronometer extends ConsumerWidget {
  const CustomCircularChronometer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    Stream<int> totalExercise () async* {
      List cycle = ref.watch(objectCycles);
      for (int i = 0; i < cycle.length; i++) {
        yield i;
        if (cycle[i][0] >= 0){
          break;
        }
      }
    }
    
    return StreamBuilder(
      stream: totalExercise(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text('Select lot');
          case ConnectionState.waiting:
            return const Text('Awaiting bids...');
          case ConnectionState.active:
            return Text('\$${snapshot.data}');
          default:
            return Text('\$${snapshot.data} (closed)');
        }
      },
    );
  }
}
