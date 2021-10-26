import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_pal/core/screen_arguments/add_countdown_scrn_args.dart';
import 'package:study_pal/core/screen_arguments/add_eve_to_con_scrn_args.dart';
import 'package:study_pal/core/screen_arguments/add_eve_to_mod_scrn_args.dart';
import 'package:study_pal/core/screen_arguments/change_sub_args.dart';
import 'package:study_pal/core/screen_arguments/content_list_screen_args.dart';
import 'package:study_pal/core/screen_arguments/content_screen_args.dart';
import 'package:study_pal/core/screen_arguments/module_screen_args.dart';
import 'package:study_pal/core/screen_arguments/quiz_screen_args.dart';
import 'package:study_pal/core/screen_arguments/subject_screen_args.dart';
import 'package:study_pal/logic/cubit/add_con_eve_cal_cubit/add_con_eve_cal_cubit.dart';
import 'package:study_pal/logic/cubit/add_mod_eve_cal_cubit/add_mod_eve_cal_cubit.dart';
import 'package:study_pal/logic/cubit/auth_nav_cubit/authscreen_nav_cubit.dart';
import 'package:study_pal/logic/cubit/change_subjects_cubit/change_subjects_cubit.dart';
import 'package:study_pal/logic/cubit/content_list_screen_cubit/content_list_screen_cubit.dart';
import 'package:study_pal/logic/cubit/countdown_tab_cubit/countdown_tab_cubit.dart';
import 'package:study_pal/logic/cubit/download_pdf_cubit/download_pdf_cubit.dart';
import 'package:study_pal/logic/cubit/module_screen_cubit/module_screen_cubit.dart';
import 'package:study_pal/logic/cubit/new_event_cubit/new_event_cubit.dart';
import 'package:study_pal/logic/cubit/profile_top_card_cubit/profile_top_card_cubit.dart';
import 'package:study_pal/logic/cubit/quiz_nav_cubit/quiz_nav_cubit.dart';
import 'package:study_pal/logic/cubit/set_countdown_cubit/set_countdown_cubit.dart';
import 'package:study_pal/logic/cubit/settings_cubit/setting_cubit.dart';
import 'package:study_pal/logic/cubit/show_cal_events_cubit/show_cal_events_cubit.dart';
import 'package:study_pal/logic/cubit/subject_screen_cubit/subject_screen_cubit.dart';
import 'package:study_pal/logic/cubit/working_cubit/working_cubit.dart';
import 'package:study_pal/presentation/screens/add_countdown_screen.dart';
import 'package:study_pal/presentation/screens/add_event_to_con_screen.dart';
import 'package:study_pal/presentation/screens/add_event_to_mod_screen.dart';
import 'package:study_pal/presentation/screens/auth_screen.dart';
import 'package:study_pal/presentation/screens/change_subjects_screen.dart';
import 'package:study_pal/presentation/screens/content_list_screen.dart';
import 'package:study_pal/presentation/screens/content_screen.dart';
import 'package:study_pal/presentation/screens/edit_profile_screen.dart';
import 'package:study_pal/presentation/screens/module_screen.dart';
import 'package:study_pal/presentation/screens/new_event_screen.dart';
import 'package:study_pal/presentation/screens/quiz_screen.dart';
import 'package:study_pal/presentation/screens/subject_screen.dart';
import 'package:study_pal/presentation/screens/working_screen.dart';

import '../../core/exceptions/route_exception.dart';
import '../screens/home_screen.dart';

class AppRouter {
  static const String home = '/home';
  static const String authScreen = '/';
  static const String subjectScreen = '/subjectScreen';
  static const String moduleScreen = '/moduleScreen';
  static const String contentListScreen = '/contentListScreen';
  static const String contentScreen = '/contentScreen';
  static const String quizScreen = '/quizScreen';
  static const String workingScreen = '/workingScreen';
  static const String addEventToConScreen = '/addEventToConScreen';
  static const String addEventToModScreen = '/addEventToModScreen';
  static const String newEventScreen = '/newEventScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String changeSubjectsScreen = '/changeSubjectsScreen';
  static const String addCountdownScreen = '/addCountdownScreen';

  static CountdownTabCubit countdownTabCubit = CountdownTabCubit();
  static ProfileTopCardCubit profileTopCardCubit = ProfileTopCardCubit();
  static ShowCalEventsCubit showCalEventsCubit = ShowCalEventsCubit();
  static SettingCubit settingCubit = SettingCubit();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    WorkingCubit _workingCubit = WorkingCubit();
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case authScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthscreenNavCubit(),
            child: AuthScreen(),
          ),
        );
      case subjectScreen:
        final SubjectScreenArgs args = settings.arguments as SubjectScreenArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SubjectScreenCubit(),
            child: SubjectScreen(
              args: args,
            ),
          ),
        );
      case moduleScreen:
        final ModuleScreenArgs args = settings.arguments as ModuleScreenArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ModuleScreenCubit(),
            child: ModuleScreen(
              args: args,
            ),
          ),
        );

      case contentListScreen:
        final ContentListScreenArgs args =
            settings.arguments as ContentListScreenArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ContentListScreenCubit(),
            child: ContentListScreen(
              args: args,
            ),
          ),
        );

      case contentScreen:
        final ContentScreenArgs args = settings.arguments as ContentScreenArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => DownloadPdfCubit(),
            child: ContentScreen(
              args: args,
            ),
          ),
        );

      case quizScreen:
        final QuizScreenArgs args = settings.arguments as QuizScreenArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => QuizNavCubit(),
            child: QuizScreen(
              args: args,
            ),
          ),
        );
      case workingScreen:
        final ContentScreenArgs args = settings.arguments as ContentScreenArgs;
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _workingCubit,
                  child: WorkingScreen(
                    args: args,
                  ),
                ));
      case addEventToConScreen:
        final AddEveToConScrnArgs args =
            settings.arguments as AddEveToConScrnArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddConEventToCalCubit(),
            child: AddEventToConScreen(
              args: args,
            ),
          ),
        );
      case addEventToModScreen:
        AddEveToModScrnArgs args = settings.arguments as AddEveToModScrnArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddModEveCalCubit(),
            child: AddEventToModScreen(
              args: args,
            ),
          ),
        );
      case newEventScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => NewEventCubit(),
              ),
              BlocProvider.value(value: showCalEventsCubit),
            ],
            child: NewEventScreen(),
          ),
        );
      case editProfileScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: settingCubit),
              BlocProvider.value(value: profileTopCardCubit),
            ],
            child: EditProfileScreen(),
          ),
        );
      case changeSubjectsScreen:
        ChangeSubScrnArgs args = settings.arguments as ChangeSubScrnArgs;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ChangeSubjectsCubit(),
              ),
              BlocProvider.value(value: settingCubit),
            ],
            child: ChangeSubjectScreen(
              args: args,
            ),
          ),
        );
      case addCountdownScreen:
        AddCountdownScrnArgs args = settings.arguments as AddCountdownScrnArgs;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SetCountdownCubit(),
              ),
              BlocProvider.value(value: countdownTabCubit),
            ],
            child: AddCountdownScreen(
              args: args,
            ),
          ),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
