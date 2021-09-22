import 'package:study_pal/data/models/countdown_model.dart';

class AddCountdownScrnArgs {
  final bool add;
  final Countdown? countdown;
  AddCountdownScrnArgs({
    required this.add,
    this.countdown,
  });
}
