import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'forget_pass_event.dart';
part 'forget_pass_state.dart';

class ForgetPassBloc extends Bloc<ForgetPassEvent, ForgetPassState> {
  ForgetPassBloc() : super(ForgetPassInitial()) {
    on<ForgetPassEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
