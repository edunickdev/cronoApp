import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:animate_do/animate_do.dart';
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

    void newConfig() {
      setState(() {
        currentMode = !currentMode;
        if (currentMode) {
          currentCycles--;
          totalCyclesCompleted++;
        }
      });
    }

    void restartTimer() {
      _controller.restart();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ejercítate"),
      ),
      body: Center(
        child: currentCycles > 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Total ciclos: ${widget.currentConfig.cycles > 0 && widget.currentConfig.cycles < 10 ? "0${widget.currentConfig.cycles}" : "${widget.currentConfig.cycles}"}",
                    style: TextStyle(fontSize: diagonal * 0.03),
                  ),
                  Text("Ciclos completados: $totalCyclesCompleted",
                      style: TextStyle(fontSize: diagonal * 0.03)),
                  CircularCountDownTimer(
                    key: UniqueKey(),
                    controller: _controller,
                    onChange: (value) {
                      // TODO: Función que dispara el sonido
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
                    textStyle: const TextStyle(fontSize: 30),
                    fillColor: Colors.green,
                    strokeCap: StrokeCap.round,
                    strokeWidth: 15,
                    ringColor: Colors.grey,
                  ),
                  SizedBox(height: currentWidth / 6),
                ],
              )
            : const Text(
                "¡Felicidades! Has terminado",
                style: TextStyle(fontSize: 25),
              ),
      ),
      floatingActionButton: FadeInLeft(
        child: SpeedDial(
          overlayOpacity: 0,
          animatedIcon: AnimatedIcons.menu_arrow,
          closeManually: true,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.play_arrow_rounded),
              label: "Iniciar",
              onTap: () => _controller.resume(),
            ),
            SpeedDialChild(
              child: const Icon(Icons.pause_rounded),
              label: "Pausar",
              onTap: () => _controller.pause(),
            ),
            SpeedDialChild(
              child: const Icon(Icons.refresh),
              label: "Reiniciar",
              onTap: restartTimer,
            ),
          ],
        ),
      ),
    );
  }
}
