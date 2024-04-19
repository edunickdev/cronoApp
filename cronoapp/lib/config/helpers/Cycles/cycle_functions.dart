import 'package:cronoapp/providers.dart';
import 'package:cronoapp/widgets/Cycles/cycles_section.dart';
import 'package:cronoapp/widgets/Cycles/section_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void moreSecondsExercise(WidgetRef ref) {
  final secondsExercise = int.parse(ref.read(secsExercise.notifier).state);
  final minutesExercise = int.parse(ref.read(minsExercise.notifier).state);

  if (secondsExercise < 59) {
    ref.read(secsExercise.notifier).state = (secondsExercise + 1).toString();
  }
  if (secondsExercise >= 59) {
    ref.read(minsExercise.notifier).state = (minutesExercise + 1).toString();
    ref.read(secsExercise.notifier).state = "00";
  }
}

void lessSecondsExercise(WidgetRef ref) {
  final secondsExercise = int.parse(ref.read(secsExercise.notifier).state);
  final minutesExercise = int.parse(ref.read(minsExercise.notifier).state);

  if (minutesExercise > 0 && secondsExercise == 00) {
    ref.read(minsExercise.notifier).state = (minutesExercise - 1).toString();
    ref.read(secsExercise.notifier).state = "59";
  } else if (secondsExercise <= 59 && secondsExercise > 0) {
    ref.read(secsExercise.notifier).state = (secondsExercise - 1).toString();
    if (ref.watch(secsExercise) == "00") {
      return;
    }
  }
}

void moreSecondsBreak(WidgetRef ref) {
  final minutesBreak = int.parse(ref.read(minsBreak.notifier).state);
  final secondsBreak = int.parse(ref.read(secsBreak.notifier).state);
  if (secondsBreak < 59) {
    ref.read(secsBreak.notifier).state = (secondsBreak + 1).toString();
  }
  if (secondsBreak >= 59) {
    ref.read(minsBreak.notifier).state = (minutesBreak + 1).toString();
    ref.read(secsBreak.notifier).state = "00";
  }
}

void lessSecondsBreak(WidgetRef ref) {
  final minutesBreak = int.parse(ref.read(minsBreak.notifier).state);
  final secondsBreak = int.parse(ref.read(secsBreak.notifier).state);

  if (minutesBreak > 0 && secondsBreak == 00) {
    ref.read(minsBreak.notifier).state = (minutesBreak - 1).toString();
    ref.read(secsBreak.notifier).state = "59";
  } else if (secondsBreak <= 59 && secondsBreak > 0) {
    ref.read(secsBreak.notifier).state = (secondsBreak - 1).toString();
    if (ref.watch(secsBreak) == "00") {
      return;
    }
  }
}

void plusTenExercise(WidgetRef ref) {
  final secondsExercise = int.parse(ref.watch(secsExercise.notifier).state);
  final minutesExercise = int.parse(ref.watch(minsExercise.notifier).state);

  if (secondsExercise + 10 >= 59) {
    ref.read(minsExercise.notifier).state = (minutesExercise + 1).toString();
    if (secondsExercise + 10 == 60) {
      ref.read(secsExercise.notifier).state = "00";
    } else {
      final temp = ((secondsExercise + 10) - 60);
      ref.read(secsExercise.notifier).state = temp.toString();
    }
  } else if (secondsExercise < 59) {
    ref.read(secsExercise.notifier).state = (secondsExercise + 10).toString();
  } else if (secondsExercise == 59) {
    ref.read(minsExercise.notifier).state = (minutesExercise + 1).toString();
    ref.read(secsExercise.notifier).state = "00";
  }
}

void plusFifteenExercise(WidgetRef ref) {
  final secondsExercise = int.parse(ref.watch(secsExercise.notifier).state);
  final minutesExercise = int.parse(ref.watch(minsExercise.notifier).state);

  if (secondsExercise + 15 >= 60) {
    ref.read(minsExercise.notifier).state = (minutesExercise + 1).toString();
    if (secondsExercise + 15 == 60) {
      ref.read(secsExercise.notifier).state = "00";
    } else {
      final temp = ((secondsExercise + 15) - 60);
      ref.read(secsExercise.notifier).state = temp.toString();
    }
  } else if (secondsExercise < 59) {
    ref.read(secsExercise.notifier).state = (secondsExercise + 15).toString();
  } else if (secondsExercise == 59) {
    ref.read(minsExercise.notifier).state = (minutesExercise + 1).toString();
    ref.read(secsExercise.notifier).state = "00";
  }
}

void plusThirtyExercise(WidgetRef ref) {
  final secondsExercise = int.parse(ref.watch(secsExercise.notifier).state);
  final minutesExercise = int.parse(ref.watch(minsExercise.notifier).state);

  if (secondsExercise + 30 >= 60) {
    ref.read(minsExercise.notifier).state = (minutesExercise + 1).toString();
    if (secondsExercise + 30 == 60) {
      ref.read(secsExercise.notifier).state = "00";
    } else {
      final temp = ((secondsExercise + 30) - 60);
      ref.read(secsExercise.notifier).state = temp.toString();
    }
  } else if (secondsExercise < 59) {
    ref.read(secsExercise.notifier).state = (secondsExercise + 30).toString();
  } else if (secondsExercise == 59) {
    ref.read(minsExercise.notifier).state = (minutesExercise + 1).toString();
    ref.read(secsExercise.notifier).state = "00";
  }
}

void plusTenBreak(WidgetRef ref) {
  final secondsBreak = int.parse(ref.watch(secsBreak.notifier).state);
  final minutesBreak = int.parse(ref.watch(minsBreak.notifier).state);

  if (secondsBreak + 10 >= 60) {
    ref.read(minsBreak.notifier).state = (minutesBreak + 1).toString();
    if (secondsBreak + 10 == 60) {
      ref.read(secsBreak.notifier).state = "00";
    } else {
      final temp = ((secondsBreak + 10) - 60);
      ref.read(secsBreak.notifier).state = temp.toString();
    }
  } else if (secondsBreak < 59) {
    ref.read(secsBreak.notifier).state = (secondsBreak + 10).toString();
  } else if (secondsBreak == 59) {
    ref.read(minsBreak.notifier).state = (minutesBreak + 1).toString();
    ref.read(secsBreak.notifier).state = "00";
  }
}

void plusFifteenBreak(WidgetRef ref) {
  final secondsBreak = int.parse(ref.watch(secsBreak.notifier).state);
  final minutesBreak = int.parse(ref.watch(minsBreak.notifier).state);

  if (secondsBreak + 15 >= 60) {
    ref.read(minsBreak.notifier).state = (minutesBreak + 1).toString();
    if (secondsBreak + 15 == 60) {
      ref.read(secsBreak.notifier).state = "00";
    } else {
      final temp = ((secondsBreak + 15) - 60);
      ref.read(secsBreak.notifier).state = temp.toString();
    }
  } else if (secondsBreak < 59) {
    ref.read(secsBreak.notifier).state = (secondsBreak + 15).toString();
  } else if (secondsBreak == 59) {
    ref.read(minsBreak.notifier).state = (minutesBreak + 1).toString();
    ref.read(secsBreak.notifier).state = "00";
  }
}

void plusThirtyBreak(WidgetRef ref) {
  final secondsBreak = int.parse(ref.watch(secsBreak.notifier).state);
  final minutesBreak = int.parse(ref.watch(minsBreak.notifier).state);

  if (secondsBreak + 30 >= 60) {
    ref.read(minsBreak.notifier).state = (minutesBreak + 1).toString();
    if (secondsBreak + 30 == 60) {
      ref.read(secsBreak.notifier).state = "00";
    } else {
      final temp = ((secondsBreak + 30) - 60);
      ref.read(secsBreak.notifier).state = temp.toString();
    }
  } else if (secondsBreak < 59) {
    ref.read(secsBreak.notifier).state = (secondsBreak + 30).toString();
  } else if (secondsBreak == 59) {
    ref.read(minsBreak.notifier).state = (minutesBreak + 1).toString();
    ref.read(secsBreak.notifier).state = "00";
  }
}

void resetTimers(WidgetRef ref, MyOptions option) {
  if (option == MyOptions.all) {
    ref.read(minsExercise.notifier).state = "00";
    ref.read(secsExercise.notifier).state = "00";
    ref.read(minsBreak.notifier).state = "00";
    ref.read(secsBreak.notifier).state = "00";
    ref.read(cyclesAmount.notifier).state = 0;
  } else if (option == MyOptions.breaks ){
    ref.read(minsBreak.notifier).state = "00";
    ref.read(secsBreak.notifier).state = "00";
  } else {
    ref.read(minsExercise.notifier).state = "00";
    ref.read(secsExercise.notifier).state = "00";
  }
}

void configCycles(WidgetRef ref, Operations operation) {
  final currentCycles = ref.watch(cyclesAmount);

  if (currentCycles >= 0) {
    if (operation == Operations.plus) {
      ref.read(cyclesAmount.notifier).state = currentCycles + 1;
    } else {
      if (currentCycles == 0) {
        return;
      }
      ref.read(cyclesAmount.notifier).state = currentCycles - 1;
    }
    return;
  }
}

