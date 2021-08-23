import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'pick_date_state.dart';

class PickDateCubit extends Cubit<PickDateState> {
  PickDateCubit() : super(PickDateInitial());

  Future<void> pickDate({required DateTime pickedDate}) async {
    DateFormat dateFormat = DateFormat("yyyy - MM - dd");
    String pickedDateStr = dateFormat.format(pickedDate);
    emit(PickDatePicked(pickedDate: pickedDate, pickedDateStr: pickedDateStr));
  }
}
