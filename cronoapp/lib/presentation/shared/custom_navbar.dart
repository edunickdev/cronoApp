import 'dart:math';

import 'package:cronoapp/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomNavBarWidget extends ConsumerWidget {
  const CustomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentIndex = ref.watch(selectScreen);
    final diagonal = sqrt(pow(MediaQuery.of(context).size.height, 2) -
        pow(MediaQuery.of(context).size.width, 2));

    return NavigationBar(
      height: diagonal * 0.13,
      selectedIndex: currentIndex,
      onDestinationSelected: (value) {
        ref.read(selectScreen.notifier).state = value;
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: "General"),
        NavigationDestination(
            icon: Icon(Icons.dashboard_customize), label: "Personal"),
      ],
    );
  }
}
