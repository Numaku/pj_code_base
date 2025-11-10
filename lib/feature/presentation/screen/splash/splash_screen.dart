import 'package:dental_clinic_app/core/constant/route_constants.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(RouteConstants.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build SplashScreen');
    return const Center(
      child: FlutterLogo(),
    );
  }


}
