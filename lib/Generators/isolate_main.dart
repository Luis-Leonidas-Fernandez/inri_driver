// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:isolate';
//import 'package:flutter/services.dart';
//import 'package:geolocator/geolocator.dart';

class IsolateMain {

    IsolateMain._internal();
    static final IsolateMain _instance = IsolateMain._internal();
    static IsolateMain get instance => _instance;

    Isolate? _isolate;
    final receivePort = ReceivePort();
    late StreamSubscription subscriptionIsolate;
    

    static void isolatePosition( SendPort sendPort) async {   
  
      Timer.periodic(const Duration(seconds: 1), (_) {
      print("after timer");  
      sendPort.send(DateTime.now().toString());

     });
   
    }   
  

    void initIsolatePosition() async {

    try {

         _isolate?.kill();
         _isolate = await Isolate.spawn<SendPort>(isolatePosition,receivePort.sendPort);
         print("***$_isolate****resultado de Isolate.spawn Position****");

    } on IsolateSpawnException catch (e) {
      print(e);
    }      
   
                            
        subscriptionIsolate = receivePort.listen((message) { 
        print('****Isolate Listen Subscription: $message');
   });


  }

  
  
  void finishIsolate(){
    subscriptionIsolate.cancel();
    _isolate?.kill();
    print("KILLED ISOLATE");

  }

  
  
  

}

 /* final driverPosition = await Geolocator.getCurrentPosition(
   desiredAccuracy: LocationAccuracy.high);  
  
   final location = {'lat': driverPosition.latitude, 'long': driverPosition.longitude};
   
   print('***driverPosition: $location*******');
   Future.delayed(const Duration(seconds: 2)); 
   final data = location;
    //sendOk
  
  sendPort.send(data); */