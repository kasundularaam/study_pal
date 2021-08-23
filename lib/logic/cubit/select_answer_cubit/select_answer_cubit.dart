import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'select_answer_state.dart';

class SelectAnswerCubit extends Cubit<SelectAnswerState> {
  SelectAnswerCubit() : super(SelectAnswerInitial());

  void selectAnswer({required String selectedAnswer}) {
    emit(SelectAnswerSelect(selectedAnswer: selectedAnswer));
  }
}
