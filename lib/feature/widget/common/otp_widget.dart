import 'package:dental_clinic_app/core/constant/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_clinic_app/feature/widget/common/text_input.dart';
import 'package:dental_clinic_app/feature/widget/common/easy_color.dart';
import 'package:dental_clinic_app/feature/widget/common/button_style.dart';
import 'package:pinput/pinput.dart';

import '../../../util/validates.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({super.key});



  @override
  Widget build(BuildContext context) {
    //final TextEditingController _otpController;
    return Pinput(
      validator: Validate.validateOtp,
      pinputAutovalidateMode: PinputAutovalidateMode.disabled,
      forceErrorState: false,
      length: 4,
      defaultPinTheme: PinTheme(
          width: 70,
          height: 56,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,color: Colors.black
          ),
          decoration: BoxDecoration(
              color: Color(0xFFF7F7F9),
              borderRadius: BorderRadius.circular(12)
          )
      ),
      //validator: Validate.validateOtp,
    );
  }
}
