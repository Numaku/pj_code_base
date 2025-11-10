import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared_preferences/shared_preferences.dart';
import '../shared_preferences/shared_preferences_impl.dart';
class SharedPreferencesDi {
  SharedPreferencesDi._();

  static Future<void> init(GetIt injector) async {
    final sharedPref = await SharedPreferences.getInstance();

    injector.registerSingleton<MySharedPreferences>(
        SharedPreferencesImpl(sharedPref));
  }
}
