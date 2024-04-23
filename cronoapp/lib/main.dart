import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import 'package:cronoapp/presentation/screens/cicles_screen.dart';
import 'package:cronoapp/presentation/screens/home_screen.dart';
import 'package:cronoapp/presentation/shared/custom_navbar.dart';
import 'package:cronoapp/providers.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> screens = [const HomeScreen(), const CiclesScreen()];
    final int currentScreen = ref.watch(selectScreen);

    final myObject = ref.watch(currentConfig);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CronoApp',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber[600]),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: screens[currentScreen],
        bottomNavigationBar: const CustomNavBarWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: myObject.id != 0
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
      routes: {"/cicles": (context) => const CycleRunningScreen()},
    );
  }
}

class CycleRunningScreen extends ConsumerWidget {
  const CycleRunningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    final amountCycles = ref.watch(currentConfig);
    int currentCycle = amountCycles.cycles;

    int controlTimers(){
      while (currentCycle > 0) {
        final amountMinutes = int.parse(amountCycles.exerciseDurationTime.split(":")[0]);
        final amountSeconds = int.parse(amountCycles.exerciseDurationTime.split(":")[1]);

        if (amountMinutes != 0) {
          int totalSeconds = amountMinutes * 60;
          totalSeconds = totalSeconds + amountSeconds;
          currentCycle =- 1;
          return totalSeconds;
        } else {
          currentCycle =- 1;
          return amountSeconds;
        }
      }
      return 0;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ejercitate"),
      ),
      body: Center(
        child: CircularCountDownTimer(
          width: currentWidth / 2,
          height: currentHeight * 0.3,
          duration: controlTimers(),
          fillColor: Colors.green,
          ringColor: Colors.grey,
        ),
      ),
      floatingActionButton: FadeInLeft(
        child: SpeedDial(
          overlayOpacity: 0,
          animatedIcon: AnimatedIcons.menu_arrow,
          closeManually: true,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.play_arrow_rounded)
            ),
            SpeedDialChild(
              child: const Icon(Icons.pause_rounded)
            ),
            SpeedDialChild(
              child: const Icon(Icons.refresh)
            ),
          ],
        ),
      ),
    );
  }
}
