import 'package:animate_do/animate_do.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cronoapp/domain/entities/person_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CycleRunningScreen extends StatefulWidget {
  final PersonConfig currenConfig;

  const CycleRunningScreen({
    Key? key,
    required this.currenConfig,
  }) : super(key: key);

  @override
  CycleRunningScreenState createState() => CycleRunningScreenState();
}

class CycleRunningScreenState extends State<CycleRunningScreen> {
  late int currentCycles;
  late int currentMinutesEx;
  late int currentSecondsEx;
  late int currentMinutesBk;
  late int currentSecondsBk;
  final bool currentMode = true;
  final CountDownController _controller = CountDownController();

  @override
  void initState() {
    super.initState();
    currentCycles = widget.currenConfig.cycles;
    currentSecondsEx =
        int.parse(widget.currenConfig.exerciseDurationTime.split(":")[1]);
    currentMinutesEx =
        int.parse(widget.currenConfig.exerciseDurationTime.split(":")[0]) * 60 +
            currentSecondsEx;
    currentSecondsBk =
        int.parse(widget.currenConfig.breakDurationTime.split(":")[1]);
    currentMinutesBk =
        int.parse(widget.currenConfig.breakDurationTime.split(":")[0]) * 60 +
            currentSecondsBk;
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    void newConfig() {
      setState(() {
        if (currentCycles > 0) {
          currentCycles = currentCycles - 1;
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ejercitate"),
      ),
      body: Center(
        child: currentCycles > 0
            ? CircularCountDownTimer(
                key: UniqueKey(),
                controller: _controller,
                onComplete: () {
                  setState(() {
                    if (currentCycles > 0) {
                      currentCycles = currentCycles - 1;
                    }
                  });
                },
                isReverse: true,
                width: currentWidth / 2,
                height: currentHeight * 0.3,
                duration: currentMinutesEx,
                textStyle: const TextStyle(fontSize: 30),
                fillColor: Colors.green,
                strokeCap: StrokeCap.round,
                strokeWidth: 15,
                ringColor: Colors.grey,
              )
            : const Text(
                "¡Felicidades! has terminado",
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
              onTap: () => _controller.restart(),
            ),
          ],
        ),
      ),
    );
  }
}
