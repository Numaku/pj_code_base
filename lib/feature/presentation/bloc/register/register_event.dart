import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

// Khi người dùng nhấn nút đăng ký
class RegisterSubmitted extends RegisterEvent {
  final String username;
  final String phone;
  final String email;
  final String password;

  const RegisterSubmitted({
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [username, phone, email, password];
}
