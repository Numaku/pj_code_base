import 'dart:io';

import 'package:dental_clinic_app/core/base/routes.dart';
import 'package:dental_clinic_app/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../feature/presentation/bloc/app_bloc.dart';
import '../../feature/presentation/bloc/app_state.dart';
import '../../feature/widget/loading/custom_loading.dart';
import 'base_bloc.dart';

abstract class BaseScreenState<V extends StatefulWidget,
        B extends BaseBloc<Object, S>, S extends BaseState> extends State<V>
    with RouteAware, WidgetsBindingObserver {
  late B _bloc;

  B get bloc => _bloc;

  S get state => _bloc.state;

  late AppBloc _appBloc;

  AppBloc get appBloc => _appBloc;

  @protected
  late AppLocalizations _localizations;

  AppLocalizations get localizations => _localizations;

  @protected
  Widget buildContent(BuildContext context);

  @protected
  Widget? get footer => null;

  @protected
  bool get isUseScaffold => true;

  @protected
  bool get safeAreaTop => false;

  @protected
  bool get resizeToAvoidBottomInset => true;

  @protected
  bool get safeAreaBottom => false;

  @protected
  bool get safeAreaLeft => true;

  @protected
  bool get safeAreaRight => true;


  bool isFirstInit = true;

  @override
  void initState() {
    debugPrint("initState $runtimeType");
    WidgetsBinding.instance.addObserver(this);
    _bloc = GetIt.I.get<B>();
    _appBloc = context.read<AppBloc>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    debugPrint("didChangeDependencies $runtimeType");
    if (isFirstInit && mounted) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        onReceiveArguments(args as Map<String, dynamic>);
      }
    }
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    isFirstInit = false;
    super.didChangeDependencies();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    final bloc = context.read<AppBloc>();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onResume();
    } else if (state == AppLifecycleState.paused) {
      onPause();
    } else if (state == AppLifecycleState.detached) {
      onDetach();
    } else if (state == AppLifecycleState.inactive) {
      onInactive();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void didPush() {
    debugPrint("didPush $runtimeType");
    super.didPush();
  }

  @override
  void didPushNext() {
    debugPrint("didPushNext $runtimeType");
    super.didPushNext();
  }

  @override
  void didPop() {
    debugPrint("didPop $runtimeType");
    super.didPop();
  }

  @override
  void didPopNext() {
    debugPrint("didPopNext $runtimeType");
    super.didPopNext();
  }

  @override
  void dispose() {
    debugPrint("dispose $runtimeType");
    removeObserver();
    _bloc.isScreenDisposed = true;
    if (isDisposeScreen) {
      _bloc.dispose();
    }
    super.dispose();
  }

  @protected
  bool get isDisposeScreen => true;

  @protected
  bool get canDismissLoadingOutsideCurrentScreen => true;

  @protected
  void removeObserver() {
    routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
  }

  @protected
  Future<bool> willPopCallback() async {
    return !bloc.state.isLoading;
  }

  Future<bool> onWillPop() async{
    return true;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build $runtimeType");
    _localizations = AppLocalizations.of(context)!;
    bloc.localizations = _localizations;
    return Platform.isAndroid
        ? WillPopScope(onWillPop: (willPopCallback), child: _body(context))
        : _body(context);
  }

  Widget _body(BuildContext context) => BlocProvider.value(
        value: _bloc,
        child: BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            onAppStateListener(context, state);
          },
          child: BlocListener<B, S>(
              listener: (context, state) {
                if (state.isLoading) {
                  CustomLoading.show(
                      context: canDismissLoadingOutsideCurrentScreen
                          ? null
                          : context);
                } else {
                  CustomLoading.dismiss(
                      context: canDismissLoadingOutsideCurrentScreen
                          ? null
                          : context);
                  if (state.error != null) {
                    // context.showError(state.error!);
                  }
                  onStateListener(context, state);
                }
              },
              child: isUseScaffold
                  ? Scaffold(
                      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
                      body: SafeArea(
                        top: safeAreaTop,
                        bottom: safeAreaBottom,
                        left: safeAreaLeft,
                        right: safeAreaRight,
                        child: Container(
                          child: Column(
                            children: [
                              buildContent(context).expanded(),
                              if (footer != null) ...{footer!}
                            ],
                          ),
                        )
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
                          buildContent(context).expanded(),
                          if (footer != null) ...{footer!}
                        ],
                      ),
                    )),
        ),
      );

  @protected
  void onStateListener(BuildContext context, S state) {}

  @protected
  void onAppStateListener(BuildContext context, AppState state) {}

  @protected
  void onReceiveArguments(Map<String, dynamic> arguments) {}

  @protected
  void onResume() {
    debugPrint("onResume $runtimeType");
  }

  @protected
  void onPause() {
    debugPrint("onPause $runtimeType");
  }

  @protected
  void onDetach() {
    debugPrint("onDetach $runtimeType");
  }

  @protected
  void onInactive() {
    debugPrint("onInactive $runtimeType");
  }
}
