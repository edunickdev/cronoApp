import 'package:cronoapp/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomNavBarWidget extends ConsumerWidget {
  const CustomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentIndex = ref.watch(selectScreen);

    return NavigationBar(
      height: 70,
      selectedIndex: currentIndex,
      onDestinationSelected: (value) {
        ref.read(selectScreen.notifier).state = value;
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: "Chrono"),
        NavigationDestination(icon: Icon(Icons.dashboard_customize), label: "Cycles"),
      ],
    );
  }
}