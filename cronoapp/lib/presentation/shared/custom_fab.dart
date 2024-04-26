import 'package:animate_do/animate_do.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CustomFABWidget extends StatelessWidget {
  const CustomFABWidget({
    super.key,
    required CountDownController controller,
  }) : _controller = controller;

  final CountDownController _controller;

  @override
  Widget build(BuildContext context) {
    void restartTimer() {
      _controller.restart();
    }

    return FadeInLeft(
      child: SpeedDial(
        childPadding: const EdgeInsets.symmetric(vertical: 3),
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
    );
  }
}
