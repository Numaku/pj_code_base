import 'package:dental_clinic_app/feature/presentation/bloc/home/home_bloc.dart';
import 'package:get_it/get_it.dart';

import '../feature/presentation/bloc/app_bloc.dart';

class BlocDi {
  BlocDi._();

  static Future<void> init(GetIt injector) async {
    injector.registerLazySingleton(
        () => AppBloc(injector()));

    injector.registerLazySingleton(
        () => HomeBloc());

  }
}
