import 'package:dental_clinic_app/feature/widget/common/easy_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'config/app_routes.dart';
import 'core/base/routes.dart';
import 'core/constant/route_constants.dart';
import 'feature/presentation/bloc/app_bloc.dart';
import 'feature/presentation/bloc/app_state.dart';
import 'feature/widget/common/non_over_scroll_behavior.dart';
import 'feature/widget/loading/custom_loading.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appBloc = GetIt.I.get<AppBloc>();
    return BlocProvider.value(
      value: appBloc,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        child: BlocSelector<AppBloc, AppState, AppLanguageState>(
          selector: (state) => state.appLanguageState ?? AppLanguageState(),
          builder: (context, state) {
            Intl.defaultLocale = state.locale.languageCode;
            return MaterialApp(
              navigatorKey: navigatorKey,
              supportedLocales: L10n.all,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              locale: state.locale,
              title: 'My Dental',
              builder: (context, child) {
                child = CustomLoading.init()(context, child);
                child = ScrollConfiguration(
                    behavior: NonOverScrollBehavior(), child: child);
                child = MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                        boldText: false,
                        textScaler: const TextScaler.linear(1.0)),
                    child: child);
                return child;
              },
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppRoutes.getRoute,
              initialRoute: RouteConstants.login,
              navigatorObservers: [routeObserver],
              theme: ThemeData(scaffoldBackgroundColor: Colors.white),
              // theme: ThemeData(
              //   hoverColor: context.themeColor.neutral110,
              //   indicatorColor: context.themeColor.neutral110,
              //   textSelectionTheme: TextSelectionThemeData(
              //     selectionColor: context.themeColor.mainColor.withOpacity(0.4),
              //     selectionHandleColor: context.themeColor.mainColor,
              //     // cursorColor: context.themeColor.neutral110,
              //   ),
              //   useMaterial3: false,
              // ),
            );
          },
        ),
      ),
    );
  }
}
