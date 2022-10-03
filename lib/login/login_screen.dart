import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/home.dart';
import 'package:login_bloc/login/bloc/login_bloc.dart';
import 'package:login_bloc/login/bloc/login_event.dart';
import 'package:login_bloc/login/bloc/login_state.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}


class _MyLoginPageState extends State<MyLoginPage> {
  final pcontroller = TextEditingController();
  final ucontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getbackground(),
      child: Scaffold(
        appBar: getappbar(),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: <Widget>[
              getlogo(context),
              SizedBox(height: 20,),
              BlocBuilder<LoginBloc,LoginState>(
                  builder:( context, state ){
                    if(state is LoginErrorState){

                      return Text(state.errormessage,
                      style: TextStyle(color: Colors.white),);

                        }
                    else{
                          return Container();
                        }
                   }
                   ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.04,
                ),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white), //<-- SEE HERE
                  controller: ucontroller,
                  onChanged: (value){
                    BlocProvider.of<LoginBloc>(context).add(
                        LogInTextChangedEvent(ucontroller.text,pcontroller.text )
                    );
                  },
                  decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white, width: 2),
                      )),
                ),
              ),

              const SizedBox(height: 20),
              //password
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child:  TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: pcontroller,
                  onChanged: (value){
                    BlocProvider.of<LoginBloc>(context).add(
                      LogInTextChangedEvent(ucontroller.text,pcontroller.text )
                    );
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white, width: 2),
                      )),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(18),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              //submit button
              BlocBuilder<LoginBloc,LoginState>(
                builder: (context, state) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:(state is LoginValidState)?
                      MaterialStateProperty.all<Color>(Colors.white):MaterialStateProperty.all<Color>(Colors.grey),
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10))),
                    ),
                    onPressed: () {
                      if(state is LoginValidState) {
                        BlocProvider.of<LoginBloc>(context).add(
                            LoginSumittedEvent(
                                ucontroller.text, pcontroller.text)
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context)=> HomePage()
                            ));
                      }

                    },
                    child: const Text('Sign in'),
                  );
                }
              ),

              Container(
                padding: const EdgeInsets.all(18),
                child: const Text('New User? Sign Up',
                    style: TextStyle(color: Colors.white)),
              )
            ]),
          ),
        ),
      ),
    );
  }
}



getappbar(){
  return  AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
getlogo(context){
  return Column(
    children: [
      // Container(
      //   transform: Matrix4.translationValues(0, 70, 0),
      //   child: Image.asset(
      //     'images/logo.png',
      //     scale: 2.2,
      //   ),
      // ),
      Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.12,
        ),
        child: const AutoSizeText(
          'Sign in',
          style: TextStyle(
            color: Colors.white,
            fontSize: 35.0,
          ),
        ),
      ),
    ],
  );
}
getbackground(){
  // return  BoxDecoration(
  //   image: DecorationImage(
  //       image: AssetImage('images/frame1login.png'), fit: BoxFit.cover),
  // );
}