
import 'login_event.dart';
import 'login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginBloc extends Bloc<LoginEvent,LoginState>{
  LoginBloc(): super(LoginInitialState()){
    on<LogInTextChangedEvent>((event, emit) {


//user exists
      if (event.unamevalue == 'anish' && event.passwordvalue == 'pass') {
        emit(LoginValidState());

      }

      else {
// incorrect credentials
        if (event.unamevalue == '' || event.unamevalue != 'anish') {
          emit(LoginErrorState("Please enter a valid username"));
        }
        else if (event.passwordvalue == '' || event.passwordvalue != 'pass') {
          emit(LoginErrorState("Please enter a valid password"));
        }
      }

    });

    on<LoginSumittedEvent>((event, emit) {
        emit(LoginLoadingState());
    });
  }
}



