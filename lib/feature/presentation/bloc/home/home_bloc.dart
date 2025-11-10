import 'package:dental_clinic_app/core/base/base_bloc.dart';
import 'package:dental_clinic_app/feature/presentation/bloc/home/home_event.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeEvent>((event, emit) {
      // Handle HomeEvent events here
    });
  }
}