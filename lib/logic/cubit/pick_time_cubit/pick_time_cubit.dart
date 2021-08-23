import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'pick_time_state.dart';

class PickTimeCubit extends Cubit<PickTimeState> {
  PickTimeCubit() : super(PickTimeInitial());

  void pickTime({required TimeOfDay pickedTime}) {
    int hr = pickedTime.hour;
    int min = pickedTime.minute;
    String pickedTimeStr = "$hr : $min";
    emit(PickTimePicked(pickedTime: pickedTime, pickedTimeStr: pickedTimeStr));
  }
}
