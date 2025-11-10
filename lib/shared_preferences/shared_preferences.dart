
import '../data/response/login_model.dart';

abstract class MySharedPreferences {

  set user(LoginModel? data);

  LoginModel? get user;

  void logout();


}
