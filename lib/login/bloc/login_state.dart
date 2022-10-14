
import 'package:flutter/material.dart';
import 'package:login_bloc/home.dart';


class LoginState extends StatelessWidget {
  const LoginState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class LoginInitialState extends LoginState{}

class LoginValidState extends LoginState{}


class LoginErrorState extends LoginState{
 String errormessage = '';
LoginErrorState(this.errormessage);
}

class LoginLoadingState extends LoginState{}