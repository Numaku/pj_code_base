import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_clinic_app/feature/widget/common/text_input.dart';
import 'package:dental_clinic_app/feature/widget/common/button_style.dart';
import 'package:dental_clinic_app/feature/widget/common/easy_color.dart';
import '../../../../core/constant/route_constants.dart';
import '../../../../util/validates.dart';

import '../../bloc/register/register_bloc.dart';
import '../../bloc/register/register_event.dart';
import '../../bloc/register/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _onRegisterPressed(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<RegisterBloc>().add(RegisterSubmitted(
        username: _userNameController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(),
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Đăng ký thành công!")),
            );
            Navigator.pop(context); // Quay lại LoginScreen
          } else if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Đăng ký",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26),
                        child: Text(
                          "Hãy điền thông tin chi tiết để khởi tạo tài khoản",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: textColor),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // ====== Form Input ======
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextInput(
                            hintText: "Tên tài khoản",
                            controller: _userNameController,
                            //validator: Validate.validateUserName,
                            obsecureText: false,
                          ),
                          const SizedBox(height: 16),
                          TextInput(
                            hintText: "Số điện thoại",
                            controller: _phoneController,
                            //validator: Validate.validatePhone,
                            obsecureText: false,
                          ),
                          const SizedBox(height: 16),
                          TextInput(
                            hintText: "Email",
                            controller: _emailController,
                            //validator: Validate.validateEmail,
                            obsecureText: false,
                          ),
                          const SizedBox(height: 16),
                          TextInput(
                            hintText: "Password",
                            controller: _passwordController,
                            //validator: Validate.validatePass,
                            obsecureText: true,
                          ),
                          const SizedBox(height: 16),
                          TextInput(
                            hintText: "Nhắc lại mật khẩu",
                            controller: _confirmPassController,
                            // validator: (value) => Validate.validateConfirmPass(
                            //     value, _passwordController.text),
                            obsecureText: true,
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // ====== Button ======
                      BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          return state.isLoading
                              ? const CircularProgressIndicator()
                              : ButtonStyleWidget(
                            text: "Đăng ký",
                            onTap: () => Navigator.pushReplacementNamed(context, RouteConstants.otp),
                          );
                        },
                      ),

                      const SizedBox(height: 32),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Bạn đã có tài khoản! ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacementNamed(context, RouteConstants.login),
                            child: const Text(
                              "Đăng nhập",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF3A934B),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      const Text(
                        "Hoặc kết nối",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),

                      Wrap(
                        spacing: 24,
                        alignment: WrapAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/facebook.png",
                            width: 44,
                            height: 44,
                          ),
                          Image.asset(
                            "assets/images/instagram.png",
                            width: 44,
                            height: 44,
                          ),
                          Image.asset(
                            "assets/images/twitter.png",
                            width: 44,
                            height: 44,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
