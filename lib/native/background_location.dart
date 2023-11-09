
import 'package:flutter/services.dart';
import 'package:inri_driver/utils/platform.dart';

class BackgroundLocation{
  final _channel = const MethodChannel('app.inri/background-location');

  Future<void> startForegroundService() async {
    
    if(isAndroid){
      await _channel.invokeMethod('start');
    }
    
  }
  Future<void> stopForegroundService() async {
    
    if(isAndroid){
      await _channel.invokeMethod('stop');
    }
  }
}

// proyecto driver final