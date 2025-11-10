import 'package:dental_clinic_app/feature/widget/common/text_input.dart';
import 'package:flutter/material.dart';

import '../../../../util/validates.dart';
import '../../../widget/common/button_style.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          //child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 80),
            child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Quên mật khẩu",
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                               "Nhập Email của bạn để đặt lại mất khẩu",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextInput(
                            hintText: "Email",
                            controller: _emailController,
                            validator: Validate.validateEmail,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ButtonStyleWidget(
                            text: "Đặt lại mật khẩu",
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(24)),
                                        title: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                                "assets/images/email_notice.png"),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            const Text(
                                              "Kiểm tra Email",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                                "Chúng tôi đã gửi mật khẩu khôi phục đến email của bạn",
                                                textAlign: TextAlign.center)
                                          ],
                                        ),
                                      );
                                    });
                              }
                            },
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ),
          //)
        ));
  }
}
