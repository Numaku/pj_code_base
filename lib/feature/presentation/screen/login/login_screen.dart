import 'package:dental_clinic_app/core/constant/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_clinic_app/feature/widget/common/text_input.dart';
import 'package:dental_clinic_app/feature/widget/common/easy_color.dart';
import 'package:dental_clinic_app/feature/widget/common/button_style.dart';


import '../../../../util/validates.dart';
import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../../bloc/login/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed(BuildContext context) {
    // Chạy validate form trước
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginBloc>().add(
        LoginSubmitted(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Đăng nhập thành công!")),
            );
            // TODO: Navigate home
            Navigator.of(context).pushReplacementNamed(RouteConstants.home);
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
                        "Đăng nhập",
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
                          "Vui lòng đăng nhập để tiếp tục trải nghiệm các tiện ích khách của chúng tôi",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: textColor),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // ======= Nhập Email + Password =======
                      Column(
                        children: [
                          TextInput(
                            controller: _emailController,
                            hintText: "Email",
                            obsecureText: false,
                            validator: Validate.validateEmail,
                          ),
                          const SizedBox(height: 16),
                          TextInput(
                            controller: _passwordController,
                            hintText: "Mật khẩu",
                            obsecureText: true,
                            validator: Validate.validatePass,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {Navigator.of(context).pushReplacementNamed(RouteConstants.forgetpass);},
                              child: const Text("Quên mật khẩu?"),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 50),

                      // ======= Nút Đăng Nhập =======
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return state.isLoading
                              ? const CircularProgressIndicator()
                              : ButtonStyleWidget(
                            text: "Đăng nhập",
                            onTap: () => _onLoginPressed(context),
                          );
                        },
                      ),

                      const SizedBox(height: 40),

                      // ======= Đăng ký =======
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Bạn chưa có tài khoản? ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed(RouteConstants.register);
                              // TODO: Navigate to Register screen
                            },
                            child: Text(
                              "Đăng ký",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: buttonColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      const Text(
                        "Hoặc kết nối",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 50),

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
