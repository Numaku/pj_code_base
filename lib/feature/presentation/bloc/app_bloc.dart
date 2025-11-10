import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared_preferences/shared_preferences.dart';
import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this._mySharedPreferences) : super(AppState(
          appLanguageState:
              AppLanguageState(locale: const Locale('vi')),
        )) {
    // Define event handlers here
  }
  final MySharedPreferences _mySharedPreferences;

}