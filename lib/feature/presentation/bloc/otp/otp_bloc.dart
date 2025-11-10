import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(const OtpState()) {
    on<OtpSubmitted>(_onOtpSubmitted);
  }

  Future<void> _onOtpSubmitted(OtpSubmitted event, Emitter<OtpState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      await Future.delayed(const Duration(seconds: 2)); // Giả lập API check OTP

      // Giả lập OTP đúng là "1234"
      if (event.otp == "1234") {
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } else {
        emit(state.copyWith(
            isLoading: false, errorMessage: "OTP không đúng"));
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: "Xác thực thất bại: $e"));
    }
  }
}
