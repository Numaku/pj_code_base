import 'dart:ui';

class AppState {
  final AppLanguageState? appLanguageState;

  AppState({this.appLanguageState});

  AppState copyWith({AppLanguageState? appLanguageState}) {
    return AppState(appLanguageState: appLanguageState ?? this.appLanguageState);
  }
}

class AppLanguageState {
  final Locale locale;
  final Map<String, dynamic>? languages;

  AppLanguageState({this.locale = const Locale('en'), this.languages});

  AppLanguageState copyWith({Map<String, dynamic>? languages, Locale? locale}) {
    return AppLanguageState(
      languages: languages ?? this.languages,
      locale: locale ?? this.locale,
    );
  }
}