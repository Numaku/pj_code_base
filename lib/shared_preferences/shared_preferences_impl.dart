import 'dart:convert';

import 'package:dental_clinic_app/data/response/login_model.dart';
import 'package:dental_clinic_app/shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constant/app_constant.dart';

class SharedPreferencesImpl implements MySharedPreferences {
  SharedPreferences sharedPref;

  SharedPreferencesImpl(this.sharedPref);

  @override
  void logout() {

  }
  @override
  set user(LoginModel? data) {
    if (data != null) {
      sharedPref.setString(PreferenceKey.user, json.encode(data.toJson()));
    }
  }

  @override
  LoginModel? get user {
    try {
      var map = json.decode(sharedPref.getString(PreferenceKey.user) ?? "") as Map<String, dynamic>;
      var user = LoginModel.fromJson(map);
      return user;
    } catch (e) {
      return null;
    }
  }
}
