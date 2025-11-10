import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      await Future.delayed(const Duration(seconds: 2)); // Giả lập gọi API

      if (event.email == "admin@gmail.com" && event.password == "Cuong@1234") {
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: "Email hoặc mật khẩu không đúng",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Đăng nhập thất bại: $e",
      ));
    }
  }
}
