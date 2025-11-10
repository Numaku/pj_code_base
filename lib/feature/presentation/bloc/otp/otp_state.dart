import 'package:equatable/equatable.dart';

class OtpState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const OtpState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  OtpState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return OtpState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}
