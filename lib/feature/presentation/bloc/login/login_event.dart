import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

// Khi người dùng bấm nút đăng nhập
class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  const LoginSubmitted(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}
