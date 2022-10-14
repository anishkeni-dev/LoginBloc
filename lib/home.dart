import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// isolates example
//
//
// isolates example

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BodyWidget(),
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
 late List<dynamic> result = [];

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(),
          ElevatedButton(
            child: Text('start'),
            onPressed: () async {

              //ReceivePort is to listen for the isolate to finish job
              final receivePort = ReceivePort();
              // here we are passing method name and sendPort instance from ReceivePort as listener
              await Isolate.spawn(computationallyExpensiveTask, receivePort.sendPort);

              //It will listen for isolate function to finish
              receivePort.listen((sum) {
                result.add(sum);
               print(result.toString());
                Text('$result');
              });

              //without isolate
              // print('heavy work started');
              // var sum = 0;
              // for (var i = 0; i <= 100000000; i++) {
              //   sum += i;
              // }
              // print(sum);
              // print('heavy work finished');


            },
          ),



        ],

      ),
    );
  }


}

// this function should be either top level(outside class) or static method
void computationallyExpensiveTask(SendPort sendPort) {
  print('heavy work started');
  var sum = 0;
  for (var i = 0; i <= 100000000; i++) {
    sum += i;
  }
  print('heavy work finished');
  //Remember there is no return, we are sending sum to listener defined defore.
  sendPort.send(sum);
}