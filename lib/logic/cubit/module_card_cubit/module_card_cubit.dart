import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_pal/data/repositories/repository.dart';

part 'module_card_state.dart';

class ModuleCardCubit extends Cubit<ModuleCardState> {
  ModuleCardCubit() : super(ModuleCardInitial());

  Future<void> loadModuleCardDetails({required String moduleId}) async {
    try {
      emit(ModuleCardLoading());
      int contentCount =
          await Repository.getContentCountByModId(moduleId: moduleId);
      int quizCount = await Repository.getQuizCountByModId(moduleId: moduleId);
      emit(ModuleCardLoaded(contentCount: contentCount, quizCount: quizCount));
    } catch (e) {
      emit(ModuleCardFailed(errorMsg: e.toString()));
    }
  }
}
