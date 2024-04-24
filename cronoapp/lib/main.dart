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
    // final amountCycles = ref.watch(currentConfig);
    // final amountMinutes =
    //     int.parse(amountCycles.exerciseDurationTime.split(":")[0]);
    // final amountSeconds =
    //     int.parse(amountCycles.exerciseDurationTime.split(":")[1]);
    // int currentCycle = amountCycles.cycles;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CronoApp',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber[600]),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
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
          return const CycleRunningScreen(
            amountCycles: 2,
            amountMinutes: 1,
            amountSeconds: 1,
          );
        }
      },
    );
  }
}
