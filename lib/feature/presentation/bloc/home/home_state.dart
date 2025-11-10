import 'package:dental_clinic_app/core/base/base_bloc.dart';
import 'package:dental_clinic_app/core/base/failure.dart';

class HomeState extends BaseState<HomeState> {
  @override
  HomeState copyWith({bool isLoading = false, Failure? error}) {
    return HomeState();
  }
}