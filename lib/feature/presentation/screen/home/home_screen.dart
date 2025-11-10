import 'package:dental_clinic_app/core/base/base_screen_state.dart';
import 'package:dental_clinic_app/feature/presentation/bloc/home/home_bloc.dart';
import 'package:dental_clinic_app/feature/presentation/bloc/home/home_state.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreenState<HomeScreen, HomeBloc, HomeState> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void onReceiveArguments(Map<String, dynamic> arguments) {
    super.onReceiveArguments(arguments);
    debugPrint('Build HomeScreen onReceiveArguments');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("didChangeDependencies home");

  }

  @override
  Widget buildContent(BuildContext context) {
    debugPrint('Build HomeScreen');
    return  Center(
      child: TextButton(child: Text("Click me"), onPressed: () {
        showDialog(context: context, builder: (ctx) {
          return AlertDialog(
            title: Text("Title"),
            content: Text("Content"),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(ctx).pop();
              }, child: Text("Close"))
            ],
          );
        });
      },),
    );
  }


}
