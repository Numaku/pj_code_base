part of 'base_bloc.dart';

abstract class BaseState<S> {
  final bool isLoading;
  final Failure? error;
  const BaseState({this.isLoading = false, this.error});

  @protected
  S copyWith({bool isLoading = false, Failure? error});
}
