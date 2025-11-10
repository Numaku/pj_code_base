import 'package:dental_clinic_app/feature/presentation/screen/forget_pass/forget_pass_screen.dart';
import 'package:dental_clinic_app/feature/presentation/screen/home/home_screen.dart';
import 'package:dental_clinic_app/feature/presentation/screen/otp/otp_screen.dart';
import 'package:dental_clinic_app/feature/presentation/screen/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../core/constant/route_constants.dart';
import '../feature/presentation/screen/login/login_screen.dart';
import '../feature/presentation/screen/splash/splash_screen.dart';

class ScreenDi {
  ScreenDi._();

  static Future<void> init(GetIt injector) async {
    injector.registerFactory<Widget>(() => const SplashScreen(),
        instanceName: RouteConstants.splash);

    injector.registerFactory<Widget>(() => const HomeScreen(),
        instanceName: RouteConstants.home);

    injector.registerFactory<Widget>(() => const LoginScreen(),
        instanceName: RouteConstants.login);

    injector.registerFactory<Widget>(() => RegisterScreen(),
        instanceName: RouteConstants.register);

    injector.registerFactory<Widget>(() => OtpScreen(),
        instanceName: RouteConstants.otp);

    injector.registerFactory<Widget>(() => ForgetPassScreen(),
        instanceName: RouteConstants.forgetpass);

  }
}
