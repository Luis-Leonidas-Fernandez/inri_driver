
import 'package:inri_driver/repositories/background_location_repositories.dart';

class BackgroundInstance extends BackgroundLocationRepository{

 @override
  Future<void> startForegroundService()async {
    // ignore: avoid_print
    print('start');
  }
  @override
  Future<void> stopForegroundService()async {
    // ignore: avoid_print
    print('stop');
  }
}