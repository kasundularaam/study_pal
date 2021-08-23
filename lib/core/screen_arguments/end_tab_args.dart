import 'package:study_pal/core/screen_arguments/content_screen_args.dart';

class EndTabArgs {
  final String clockValue;
  final int startTimestamp;
  final int endTimestamp;
  final int counter;
  final ContentScreenArgs contentScreenArgs;
  EndTabArgs({
    required this.clockValue,
    required this.startTimestamp,
    required this.endTimestamp,
    required this.counter,
    required this.contentScreenArgs,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EndTabArgs &&
        other.clockValue == clockValue &&
        other.startTimestamp == startTimestamp &&
        other.endTimestamp == endTimestamp &&
        other.counter == counter &&
        other.contentScreenArgs == contentScreenArgs;
  }

  @override
  int get hashCode {
    return clockValue.hashCode ^
        startTimestamp.hashCode ^
        endTimestamp.hashCode ^
        counter.hashCode ^
        contentScreenArgs.hashCode;
  }

  @override
  String toString() {
    return 'EndTabArgs(clockValue: $clockValue, startTimestamp: $startTimestamp, endTimestamp: $endTimestamp, counter: $counter, contentScreenArgs: $contentScreenArgs)';
  }
}
