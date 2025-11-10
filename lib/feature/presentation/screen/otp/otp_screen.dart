import 'package:dental_clinic_app/feature/presentation/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
//import 'package:login_demo/login_page.dart';
import 'package:pinput/pinput.dart';

import '../../../widget/common/button_style.dart';
import '../../../widget/common/otp_widget.dart';


class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Center(
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
                            "Xác thực OTP",
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
                              "Vui lòng kiểm tra tin nhắn để nhận mã xác minh",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 70,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "OTP Code",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          const OtpWidget(),
                          const SizedBox(height: 40,),
                          ButtonStyleWidget(text: "Xác thực", onTap: (){
                            if(_formKey.currentState!.validate()){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                            }
                          },),
                          const SizedBox(height: 20,),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // TextStyleWidget(text: "Gửi lại sau", align: TextAlign.start),
                                // TextStyleWidget(text: "00:00", align: TextAlign.end)
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ));
  }
}

// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: List.generate(4, (index) {
//     return Container(
//       width: 70,
//       height: 56,
//       margin: const EdgeInsets.symmetric(horizontal: 8),
//       child: TextField(
//         keyboardType: TextInputType.number,
//         textAlign: TextAlign.center,
//         maxLength: 1,
//         style: const TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//         ),
//         decoration: InputDecoration(
//           counterText: "",
//           filled: true,
//           fillColor: const Color(0xFFF7F7F9),
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none),
//         ),
//       ),
//     );
//   }),
// ),