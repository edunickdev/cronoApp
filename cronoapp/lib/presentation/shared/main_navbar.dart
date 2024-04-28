import 'package:cronoapp/config/theme/custom_theme.dart';
import 'package:cronoapp/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

PreferredSizeWidget mainAppBarWidget(BuildContext context, WidgetRef ref) {
  final currentBrightness = ref.watch(myBrightness);

  return AppBar(
    actions: [
      IconButton(
        onPressed: () async {
          if (ref.watch(mainIsRunning.notifier).state) {
            return;
          }
          ref.read(myBrightness.notifier).state = !currentBrightness;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('brightness', !currentBrightness);
        },
        icon: currentBrightness
            ? const Icon(Icons.dark_mode_rounded)
            : const Icon(Icons.sunny),
      ),
      PopupMenuButton<int>(
        icon: const Icon(Icons.color_lens),
        itemBuilder: (context) {
          return myListOfColors.asMap().entries.map((entry) {
            int index = entry.key;
            Color color = entry.value;
            return PopupMenuItem<int>(
              value: index,
              child: Container(
                color: color,
                height: 30,
                width: 30,
              ),
            );
          }).toList();
        },
        onSelected: (value) async {
          if (ref.watch(mainIsRunning.notifier).state) {
            return;
          }
          ref.read(myTheme.notifier).state = value;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('theme', value);
        },
      ),
    ],
  );
}
