import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:cronoapp/presentation/shared/custom_fab.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cronoapp/domain/entities/person_model.dart';

class CycleRunningScreen extends StatefulWidget {
  final PersonConfig currentConfig;

  const CycleRunningScreen({
    Key? key,
    required this.currentConfig,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CycleRunningScreenState createState() => _CycleRunningScreenState();
}

class _CycleRunningScreenState extends State<CycleRunningScreen> {
  late int currentCycles;
  late int currentMinutesEx;
  late int currentSecondsEx;
  late int currentMinutesBk;
  late int currentSecondsBk;
  bool currentMode = true;
  int totalCyclesCompleted = 0;
  final CountDownController _controller = CountDownController();
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    currentCycles = widget.currentConfig.cycles;
    currentSecondsEx =
        int.parse(widget.currentConfig.exerciseDurationTime.split(":")[1]);
    currentMinutesEx =
        int.parse(widget.currentConfig.exerciseDurationTime.split(":")[0]) *
                60 +
            currentSecondsEx;
    currentSecondsBk =
        int.parse(widget.currentConfig.breakDurationTime.split(":")[1]);
    currentMinutesBk =
        int.parse(widget.currentConfig.breakDurationTime.split(":")[0]) * 60 +
            currentSecondsBk;
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    final diagonal = sqrt(pow(currentHeight, 2) - pow(currentWidth, 2));
    final plataforma = Theme.of(context).platform;
    final theme = Theme.of(context).colorScheme;
    final cycles = widget.currentConfig.cycles;

    void newConfig() {
      setState(() {
        currentMode = !currentMode;
        if (currentMode) {
          currentCycles--;
          totalCyclesCompleted++;
        }
      });
    }

    Future<void> playSound(bool mode) async {
      String soundPath1 = "sounds/sonido1.mp3";
      String soundPath2 = "sounds/sonido2.mp3";
      await player.play(AssetSource(mode ? soundPath1 : soundPath2));
    }

    return Scaffold(
      backgroundColor: theme.secondary,
      appBar: AppBar(
        title: currentCycles > 0
            ? Text(currentMode ? "Ejercítate" : "Descansa")
            : const Text("Rutina finalizada"),
        centerTitle: plataforma == TargetPlatform.android ? true : false,
      ),
      body: Center(
        child: currentCycles > 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Total ciclos: ${cycles > 0 && cycles < 10 ? "0$cycles" : "$cycles"}",
                    style: TextStyle(
                      fontSize: diagonal * 0.03,
                      color: theme.secondaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Ciclos completados: $totalCyclesCompleted",
                      style: TextStyle(
                        fontSize: diagonal * 0.03,
                        color: theme.secondaryContainer,
                        fontWeight: FontWeight.bold,
                      )),
                  CircularCountDownTimer(
                    key: UniqueKey(),
                    controller: _controller,
                    onChange: (value) {
                      if (value == "6") {
                        playSound(currentMode);
                      }
                    },
                    onComplete: () {
                      newConfig();
                      if (currentCycles > 0) {
                        _controller.restart(
                            duration: currentMode
                                ? currentMinutesEx
                                : currentMinutesBk);
                      }
                    },
                    isReverse: true,
                    width: currentWidth / 2,
                    height: currentHeight * 0.3,
                    duration: currentMode ? currentMinutesEx : currentMinutesBk,
                    textStyle: TextStyle(
                      fontSize: diagonal * 0.05,
                      fontWeight: FontWeight.bold,
                      color: theme.secondaryContainer,
                    ),
                    fillColor: currentMode ? Colors.green : Colors.blue,
                    strokeCap: StrokeCap.round,
                    strokeWidth: 22,
                    ringColor: theme.secondaryContainer,
                  ),
                  SizedBox(height: currentWidth / 6),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Excelente trabajo",
                    style: TextStyle(
                      fontSize: diagonal * 0.035,
                      fontWeight: FontWeight.bold,
                      color: theme.secondaryContainer,
                    ),
                  ),
                  Text(
                    "¡Felicidades! Has terminado",
                    style: TextStyle(
                      fontSize: diagonal * 0.035,
                      fontWeight: FontWeight.bold,
                      color: theme.secondaryContainer,
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton:
          currentCycles > 0 ? CustomFABWidget(controller: _controller) : null,
    );
  }
}
