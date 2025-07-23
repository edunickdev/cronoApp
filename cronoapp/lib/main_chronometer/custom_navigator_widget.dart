import 'package:flutter/material.dart';

class CustomButtonNavigator extends StatelessWidget {
  const CustomButtonNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings),
          style: const ButtonStyle(
              iconSize: WidgetStatePropertyAll(50),
              iconColor: WidgetStatePropertyAll(Colors.grey)),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.play_arrow_rounded),
          style: const ButtonStyle(
              iconSize: WidgetStatePropertyAll(70),
              iconColor: WidgetStatePropertyAll(Colors.green)),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.restore),
          style: const ButtonStyle(
              iconSize: WidgetStatePropertyAll(50),
              iconColor: WidgetStatePropertyAll(Colors.blue)),
        ),
      ],
    );
  }
}
