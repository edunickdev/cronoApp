import 'package:cronoapp/cicles_chronometer/duration_cicles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../cicles_chronometer/circular_chronometer.dart';
import '../../main_chronometer/buttons_widgets.dart';
import '../../main_chronometer/custom_navigator_widget.dart';
import '../../main_chronometer/main_chronometer.dart';
import '../../providers.dart';

class HomeScreen extends ConsumerWidget {
  static const name = "/";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<List<int>> createCycles() {
      List<List<int>> cycles = [];
      int secondsB = int.parse(ref.watch(secsBreak));
      int secondsE = int.parse(ref.watch(secsExercise));
      int minutesB = int.parse(ref.watch(minsBreak));
      int minutesE = int.parse(ref.watch(minsExercise));
      int breakTime = 0;
      int exerciseTime = 0;
      if (minutesE > 0) {
        exerciseTime = minutesE * 60 + secondsE;
        ref.read(totalExerciseTime.notifier).state = exerciseTime;
      } else {
        exerciseTime = secondsE;
        ref.read(totalExerciseTime.notifier).state = exerciseTime;
      }
      if (minutesB > 0) {
        breakTime = minutesB * 60 + secondsB;
        ref.read(totalBreakTime.notifier).state = breakTime;
      } else {
        breakTime = secondsB;
        ref.read(totalBreakTime.notifier).state = breakTime;
      }

      for (int i = 0; i < ref.watch(moments); i++) {
        cycles.add([exerciseTime, breakTime]);
      }
      return cycles;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('CronoApp'),
        centerTitle: true,
      ),
      bottomNavigationBar: const CustomButtonNavigator(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const MainChronometer(),
            MainCronometerButtonsWidget(),
            const SizedBox(height: 15),
            const Divider(thickness: 3),
            const SizedBox(height: 30),
            const Text(
              "Ciclos de \n ejercicios/descansos",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  useSafeArea: true,
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Configuración de la sesión",
                        style: TextStyle(fontSize: 25)),
                    content: const DurationWidget(),
                    actions: [
                      IconButton(
                        onPressed: () {
                          ref.read(cycles.notifier).state = createCycles();
                          context.pop();
                        },
                        icon: const Icon(Icons.save, size: 40),
                      ),
                    ],
                  ),
                );
              },
              style: const ButtonStyle(elevation: MaterialStatePropertyAll(5)),
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Text("Configurar", style: TextStyle(fontSize: 25)),
              ),
            ),
            const SizedBox(height: 40),
            const CustomCircularChronometer(),
            const SizedBox(height: 50),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Ciclos: ${ref.watch(moments)}",
                style: const TextStyle(fontSize: 30),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
