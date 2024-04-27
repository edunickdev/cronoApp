import 'package:cronoapp/config/theme/custom_theme.dart';
import 'package:cronoapp/domain/entities/person_model.dart';
import 'package:cronoapp/presentation/screens/running_screen.dart';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cronoapp/presentation/screens/cicles_screen.dart';
import 'package:cronoapp/presentation/screens/home_screen.dart';
import 'package:cronoapp/presentation/shared/custom_navbar.dart';
import 'package:cronoapp/providers.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> screens = [const HomeScreen(), const CiclesScreen()];
    final int currentScreen = ref.watch(selectScreen);
    final showBtn = ref.watch(showButton);
    final currentBrightness = ref.read(myBrightness.notifier).state;
    final currentTheme = ref.read(myTheme.notifier).state;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CronoApp',
      theme: CustomTheme(
        selectedColor: currentTheme,
        brightness: currentBrightness,
      ).changeColor(),
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: currentBrightness
                  ? const Icon(Icons.sunny)
                  : const Icon(Icons.dark_mode),
            ),
            IconButton(
              onPressed: () {
                ref.read(myTheme.notifier).state = 4;
              },
              icon: const Icon(Icons.color_lens_rounded),
            )
          ],
        ),
        body: screens[currentScreen],
        bottomNavigationBar: const CustomNavBarWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: showBtn
            ? Builder(
                builder: (BuildContext context) {
                  return FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: FloatingActionButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed("/cicles"),
                      child: const Icon(Icons.play_arrow_rounded),
                    ),
                  );
                },
              )
            : null,
      ),
      routes: {
        "/cicles": (context) {
          late final PersonConfig myData;
          final amountCycles = ref.watch(currentConfig);
          if (amountCycles.id != 0) {
            myData = ref.read(currentConfig.notifier).state;
          } else {
            final timeExercise =
                "${ref.read(secsExercise.notifier).state}:${ref.read(minsExercise.notifier).state}";
            final timeBreak =
                "${ref.read(secsBreak.notifier).state}:${ref.read(minsBreak.notifier).state}";

            myData = PersonConfig(
                id: 0,
                title: "default",
                exerciseDurationTime: timeExercise,
                breakDurationTime: timeBreak,
                cycles: ref.read(cyclesAmount.notifier).state);
          }

          return CycleRunningScreen(currentConfig: myData);
        }
      },
    );
  }
}
