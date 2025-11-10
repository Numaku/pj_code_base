import 'package:get_it/get_it.dart';
import 'di.dart';

class AppInjection {
  static final getIt = GetIt.instance;

  static Future<void> configureInjection() async {
    await DeviceInfoDi.init(getIt);
    await SharedPreferencesDi.init(getIt);
    await ApiDi.init(getIt);
    await NetworkDi.init(getIt);
    await RepositoryDi.init(getIt);
    await UseCaseDi.init(getIt);
    await BlocDi.init(getIt);
    await ScreenDi.init(getIt);
  }

}
